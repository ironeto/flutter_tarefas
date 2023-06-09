import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:gerenciador_de_tarefas/firebase_options.dart';
import 'package:gerenciador_de_tarefas/providers/task_provider.dart';
import 'package:gerenciador_de_tarefas/routes/route_paths.dart';
import 'package:gerenciador_de_tarefas/screens/create_task_screen.dart';
import 'package:gerenciador_de_tarefas/screens/task_show_screen.dart';
import 'package:gerenciador_de_tarefas/screens/task_list_screen.dart';
import 'package:provider/provider.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
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
