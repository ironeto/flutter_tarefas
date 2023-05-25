import 'package:gerenciador_de_tarefas/components/task_list_item.dart';
import 'package:gerenciador_de_tarefas/providers/task_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class TaskList extends StatelessWidget {
  const TaskList({super.key});

  @override
  Widget build(BuildContext context) {
    final _Tasks = Provider.of<TasksProvider>(context);

    List<Widget> _generateListTasks(BuildContext context) {
      return _Tasks.itens
          .map((Task) => TaskListItem(Task))
          .toList();
    }

    return _Tasks.itens.isNotEmpty
        ? Expanded(
            child: ListView(
              children: _generateListTasks(context),
            ),
          )
        : Text("Não há produtos cadastrados.");
  }
}
