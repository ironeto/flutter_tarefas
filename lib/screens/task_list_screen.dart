import 'package:gerenciador_de_tarefas/providers/task_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../components/task_list.dart';
import '../components/task_overview_card.dart';

class TaskListScreen extends StatefulWidget {
  const TaskListScreen({super.key});

  @override
  State<TaskListScreen> createState() => _TaskListScreenState();
}

class _TaskListScreenState extends State<TaskListScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Tarefas"),
      ),
      body: ChangeNotifierProvider(
        create: (context) => TasksProvider(),
        child: Column(
          children: const [
            TaskList(),
            TaskOverviewCard(),
          ],
        ),
      ),
    );
  }
}
