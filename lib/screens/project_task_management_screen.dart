import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../models/project.dart';
import '../models/task.dart';
import '../providers/project_task_provider.dart';

class ProjectTaskManagementScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Manage Projects & Tasks")),
      body: Consumer<TimeEntryProvider>(
        builder: (context, provider, child) {
          return Center(child: Text("Project and task management UI here."));
        },
      ),
    );
  }
}
