import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:intl/intl.dart';
import '../models/time_entry.dart';
import '../providers/project_task_provider.dart';

class AddTimeEntryScreen extends StatefulWidget {
  @override
  _AddTimeEntryScreenState createState() => _AddTimeEntryScreenState();
}

class _AddTimeEntryScreenState extends State<AddTimeEntryScreen> {
  final _formKey = GlobalKey<FormState>();
  final _taskController = TextEditingController();
  final _notesController = TextEditingController();
  final _totalTimeController = TextEditingController();
  DateTime _selectedDate = DateTime.now();
  String _selectedProject = 'Project A'; // Replace with dynamic projects later

  void _submitEntry() {
    if (_formKey.currentState!.validate()) {
      final id = DateTime.now().millisecondsSinceEpoch.toString();
      final entry = TimeEntry(
        id: id,
        project: _selectedProject, // ✅ FIXED
        task: _taskController.text,
        totalTime: double.parse(_totalTimeController.text),
        date: _selectedDate,
        notes: _notesController.text,
      );

      Provider.of<TimeEntryProvider>(context, listen: false).addTimeEntry(entry);
      Navigator.of(context).pop();
    }
  }

  Future<void> _pickDate() async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: _selectedDate,
      firstDate: DateTime(2020),
      lastDate: DateTime(2100),
    );
    if (picked != null && picked != _selectedDate) {
      setState(() {
        _selectedDate = picked;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Add Time Entry")),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: Column(
            children: [
              TextFormField(
                controller: _taskController,
                decoration: InputDecoration(labelText: 'Task'),
                validator: (value) => value!.isEmpty ? 'Enter a task' : null,
              ),
              TextFormField(
                controller: _totalTimeController,
                decoration: InputDecoration(labelText: 'Total Time (hrs)'),
                keyboardType: TextInputType.number,
                validator: (value) => value!.isEmpty ? 'Enter time' : null,
              ),
              TextFormField(
                controller: _notesController,
                decoration: InputDecoration(labelText: 'Notes'),
              ),
              SizedBox(height: 10),
              Row(
                children: [
                  Text('Date: ${DateFormat.yMd().format(_selectedDate)}'),
                  TextButton(
                    onPressed: _pickDate,
                    child: Text('Choose Date'),
                  ),
                ],
              ),
              SizedBox(height: 20),
              ElevatedButton(
                onPressed: _submitEntry,
                child: Text('Add Entry'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}