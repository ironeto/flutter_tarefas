import 'package:gerenciador_de_tarefas/models/task_model.dart';
import 'package:gerenciador_de_tarefas/routes/route_paths.dart';
import 'package:gerenciador_de_tarefas/screens/task_show_screen.dart';
import 'package:flutter/material.dart';

import 'screens/task_list_screen.dart';

void main() {
  runApp(App());
}

class App extends StatelessWidget {


  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      // home: TaskListScreen(_Tasks),
      routes: {
        RoutePaths.HOME: (context) => TaskListScreen(),
        RoutePaths.TaskSHOWSCREEN: (context) => TaskShowScreen(),
      }
    );
  }
}
