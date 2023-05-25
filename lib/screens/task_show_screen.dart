import 'package:gerenciador_de_tarefas/models/task_model.dart';
import 'package:flutter/material.dart';

class TaskShowScreen extends StatelessWidget {
  const TaskShowScreen({super.key});

  @override
  Widget build(BuildContext context) {
    // var arg =
    TaskModel task = ModalRoute.of(context)?.settings.arguments as TaskModel;

    return Scaffold(
      appBar: AppBar(
        title: Text(task.name),
      ),
      body: Column(
        children: [
          Image.network(task.imageUrl),
          Text(task.name,
            style: TextStyle(
              fontSize: 30.0
            ),
          ),
          Text(task.effortHours.toString(),
            style: TextStyle(
              fontSize: 30.0
            ),),
          Text(task.location,
            style: TextStyle(
              fontSize: 30.0
            ),)
        ],
      ),
    );
  }
}
