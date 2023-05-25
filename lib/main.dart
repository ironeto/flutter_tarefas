import 'package:flutter/material.dart';
import 'package:gerenciador_de_tarefas/providers/task_provider.dart';
import 'package:gerenciador_de_tarefas/routes/route_paths.dart';
import 'package:gerenciador_de_tarefas/screens/create_task_screen.dart';
import 'package:gerenciador_de_tarefas/screens/task_show_screen.dart';
import 'package:gerenciador_de_tarefas/screens/task_list_screen.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(App());
}

class App extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider<TasksProvider>(
          create: (context) => TasksProvider(),
        ),
      ],
      child: MaterialApp(
        title: 'Your App',
        initialRoute: RoutePaths.HOME,
        routes: {
          RoutePaths.HOME: (context) => TaskListScreen(),
          RoutePaths.TaskSHOWSCREEN: (context) => TaskShowScreen(),
          RoutePaths.CREATE_TASK: (context) => CreateTaskScreen(),
        },
      ),
    );
  }
}
