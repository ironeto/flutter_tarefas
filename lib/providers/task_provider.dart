import 'dart:math';

import 'package:flutter/material.dart';

import '../models/task_model.dart';

class TasksProvider with ChangeNotifier {
  final List<TaskModel> itens = [
    TaskModel(1,"Fazer Café","https://images.pexels.com/photos/312418/pexels-photo-312418.jpeg", 1,0,0),
    TaskModel(2,"Açucar","https://images.pexels.com/photos/6167330/pexels-photo-6167330.jpeg", 2,0,0)
  ];

  void addEffort(TaskModel Task) {
      Task.effortHours++;
      notifyListeners();
  }

  void setLocation(TaskModel Task, double latitude, double longitude) {
    Task.latitude = latitude;
    Task.longitude = longitude;
    notifyListeners();
  }

  void removeEffort(TaskModel Task) {
    if (Task.effortHours > 1) {
        Task.effortHours--;
        notifyListeners();
    }
  }

  void deleteTask(TaskModel task) {
    itens.removeWhere((t) => t.id == task.id);
    notifyListeners();
  }


  void addTask(String name, int effortHours) {
    int lastId = itens.isNotEmpty ? itens.map((task) => task.id).reduce(max) + 1 : 1;
    final newTask = TaskModel(
      (lastId + 1),
      name,
      "",
      effortHours,
      0,
      0
    );

    itens.add(newTask);
    notifyListeners();
  }


  int countItens() => itens.fold(0, (acc, p) => acc + p.effortHours);
}