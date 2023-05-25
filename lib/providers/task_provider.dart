import 'package:flutter/material.dart';

import '../models/task_model.dart';

class TasksProvider with ChangeNotifier {
  final List<TaskModel> itens = [
    TaskModel("Fazer Café", "Cozinha",
        "https://images.pexels.com/photos/312418/pexels-photo-312418.jpeg", 1),
    TaskModel("Açucar", "Padaria",
        "https://images.pexels.com/photos/6167330/pexels-photo-6167330.jpeg", 2)
  ];

  void addItem(TaskModel Task) {
      Task.effortHours++;
      notifyListeners();
  }

  void removeItem(TaskModel Task) {
    if (Task.effortHours > 0) {
        Task.effortHours--;
        notifyListeners();
    }
  }

  int countItens() => itens.fold(0, (acc, p) => acc + p.effortHours);
}