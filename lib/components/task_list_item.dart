import 'package:gerenciador_de_tarefas/models/task_model.dart';
import 'package:gerenciador_de_tarefas/providers/task_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../routes/route_paths.dart';

class TaskListItem extends StatelessWidget {
  const TaskListItem(
    this.Task, {
    super.key,
  });

  final TaskModel Task;

  String _formatSubtitle() {
    String effort = Task.effortHours.toString();
    return "R\$ $effort (${Task.effortHours})";
  }

  @override
  Widget build(BuildContext context) {
    final _Tasks = Provider.of<TasksProvider>(context);
    return ListTile(
      leading: IconButton(
        icon: const Icon(Icons.remove),
        onPressed: () => _Tasks.removeItem(Task),
      ),
      title: Text(Task.name),
      subtitle: Text(_formatSubtitle()),
      trailing: IconButton(
        icon: const Icon(Icons.add),
        onPressed: () => _Tasks.addItem(Task),
      ),
      onTap: () {
        Navigator.of(context)
            .pushNamed(RoutePaths.TaskSHOWSCREEN, arguments: Task);
        // Navigator.of(context)
        // .p
      },
    );
  }
}
