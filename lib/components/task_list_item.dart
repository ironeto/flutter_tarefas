import 'package:gerenciador_de_tarefas/models/task_model.dart';
import 'package:gerenciador_de_tarefas/providers/task_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../routes/route_paths.dart';

class TaskListItem extends StatelessWidget {
  const TaskListItem(
      this.task, {
        Key? key,
      }) : super(key: key);

  final TaskModel task;

  String _formatSubtitle() {
    return "Duração ${task.effortHours.toString()} hora(s)";
  }

  @override
  Widget build(BuildContext context) {
    final tasksProvider = Provider.of<TasksProvider>(context);
    return ListTile(
      leading: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          IconButton(
            icon: const Icon(Icons.delete),
            onPressed: () => tasksProvider.deleteTask(task),
          ),
          IconButton(
            icon: const Icon(Icons.remove),
            onPressed: () => tasksProvider.removeEffort(task),
          ),
        ],
      ),
      title: Text(task.name),
      subtitle: Text(_formatSubtitle()),
      trailing: IconButton(
        icon: const Icon(Icons.add),
        onPressed: () => tasksProvider.addEffort(task, 0),
      ),
      onTap: () {
        Navigator.of(context).pushNamed(RoutePaths.TaskSHOWSCREEN, arguments: task);
      },
    );
  }
}
