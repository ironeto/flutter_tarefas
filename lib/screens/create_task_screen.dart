import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/task_provider.dart';

class CreateTaskScreen extends StatelessWidget {
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _effortHoursController = TextEditingController();

  void _createTask(BuildContext context) {
    final tasksProvider = Provider.of<TasksProvider>(context, listen: false);
    final String name = _nameController.text;
    final double effortHours = double.tryParse(_effortHoursController.text) ?? 0.0;

    tasksProvider.addTask(name, effortHours);

    Navigator.of(context).pop(); // Navigate back to the task list screen
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Create Task'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            TextField(
              controller: _nameController,
              decoration: InputDecoration(labelText: 'Task Name'),
            ),
            SizedBox(height: 16.0),
            TextField(
              controller: _effortHoursController,
              decoration: InputDecoration(labelText: 'Effort Hours'),
              keyboardType: TextInputType.number,
            ),
            SizedBox(height: 16.0),
            ElevatedButton(
              onPressed: () => _createTask(context),
              child: Text('Create'),
            ),
          ],
        ),
      ),
    );
  }
}
