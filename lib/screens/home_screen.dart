import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../models/time_entry.dart';
import '../providers/project_task_provider.dart';

class HomeScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child: Scaffold(
        appBar: AppBar(
          title: Text('Time Tracker'),
          backgroundColor: Colors.blue,
          bottom: TabBar(
            tabs: [
              Tab(text: 'All Entries'),
              Tab(text: 'Projects'),
            ],
            indicatorColor: Colors.white,
          ),
        ),
        body: TabBarView(
          children: [
            // Tab 1: All Entries
            Consumer<TimeEntryProvider>(
              builder: (context, provider, child) {
                return ListView.builder(
                  itemCount: provider.entries.length,
                  itemBuilder: (context, index) {
                    final entry = provider.entries[index];
                    return ListTile(
                      title: Text('${entry.project} - ${entry.totalTime} hours'),
                      subtitle: Text('${entry.date.toLocal().toString().split(" ")[0]} - Notes: ${entry.notes}'),
                    );
                  },
                );
              },
            ),
            // Tab 2: Manage Projects
            Center(
              child: ElevatedButton.icon(
                icon: Icon(Icons.settings),
                label: Text('Open Project Settings'),
                onPressed: () {
                  Navigator.pushNamed(context, '/manage_projects');
                },
              ),
            ),
          ],
        ),
        floatingActionButton: FloatingActionButton(
          child: Icon(Icons.add),
          onPressed: () {
            Navigator.pushNamed(context, '/add_time_entry');
          },
        ),
      ),
    );
  }
}
