import 'package:gerenciador_de_tarefas/providers/task_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class TaskOverviewCard extends StatelessWidget {
  const TaskOverviewCard({super.key});

  @override
  Widget build(BuildContext context) {
    final Tasks = Provider.of<TasksProvider>(context);
    return Card(
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          const Text(
            "Total",
            style: TextStyle(fontSize: 22.0),
          ),
          Column(
            children: [
              Text(
                "${Tasks.countItens()}",
                style: TextStyle(fontSize: 22.0),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
