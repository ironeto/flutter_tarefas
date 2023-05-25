import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/task_provider.dart';

class CreateTaskScreen extends StatelessWidget {
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _effortHoursController = TextEditingController();

  void _createTask(BuildContext context) {
    final tasksProvider = Provider.of<TasksProvider>(context, listen: false);
    final String name = _nameController.text;
    int effortHours = 0;
    try {
      effortHours = int.parse(_effortHoursController.text);
    } catch(e) {
      effortHours = 1;
    }

    tasksProvider.addTask(name, effortHours);

    Navigator.of(context).pop(); // Navigate back to the task list screen
  }

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => TasksProvider(),
      child: Scaffold(
        appBar: AppBar(
          title: Text('Criar Tarefa'),
        ),
        body: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            children: [
              TextField(
                controller: _nameController,
                decoration: InputDecoration(labelText: 'Nome'),
              ),
              SizedBox(height: 16.0),
              TextField(
                controller: _effortHoursController,
                decoration: InputDecoration(labelText: 'Esforço (Hs)'),
                keyboardType: TextInputType.number,
              ),
              SizedBox(height: 16.0),
              ElevatedButton(
                onPressed: () => _createTask(context),
                child: Text('Criar'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
