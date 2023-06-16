import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shared_pk/GenericOverviewCard.dart';
import 'package:shared_pk/IGenericOverviewCard.dart';

import '../components/task_list.dart';
import '../providers/task_provider.dart';
import '../routes/route_paths.dart';

class TaskListScreen extends StatelessWidget {
  const TaskListScreen({Key? key});

  void _createNewTask(BuildContext context) {
    Navigator.of(context).pushNamed(RoutePaths.CREATE_TASK);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Tarefas"),
      ),
      body: Consumer<TasksProvider>(
        builder: (context, tasksProvider, _) {
          return Column(
            children: [
              TaskList(),
              GenericOverviewCard<IGenericOverviewCard>(),
            ],
          );
        },
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
