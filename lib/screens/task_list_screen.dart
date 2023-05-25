import 'package:gerenciador_de_tarefas/providers/task_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../components/task_list.dart';
import '../components/task_overview_card.dart';
import '../models/task_model.dart';
import '../routes/route_paths.dart';

class TaskListScreen extends StatefulWidget {
  const TaskListScreen({Key? key});

  @override
  State<TaskListScreen> createState() => _TaskListScreenState();
}

class _TaskListScreenState extends State<TaskListScreen> {
  void _createNewTask(BuildContext context) {
    Navigator.of(context).pushNamed(RoutePaths.CREATE_TASK);
  }

  @override
  Widget build(BuildContext context) {
    final tasksProvider = Provider.of<TasksProvider>(context);

    return Scaffold(
      appBar: AppBar(
        title: const Text("Tarefas"),
      ),
      body: Column(
        children: [
          TaskList(),
          TaskOverviewCard(),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          _createNewTask(context);
        },
        child: const Icon(Icons.add),
      ),
    );
  }
}
