import 'dart:math';

import 'package:flutter/material.dart';

import '../models/task_model.dart';

class TasksProvider with ChangeNotifier {
  final List<TaskModel> itens = [
    TaskModel(1,"Fazer Café", 1,0,0),
    TaskModel(2,"Desenvolver projeto", 2,0,0)
  ];

  void addEffort(TaskModel Task, int effort) {
      if(effort == 0)
        Task.effortHours++;
      else
        Task.effortHours = effort;

      notifyListeners();
  }

  void save(TaskModel Task, String name, int effortHours, double latitude, double longitude) {
    Task.name = name;
    Task.latitude = latitude;
    Task.longitude = longitude;
    Task.effortHours = effortHours;
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
      effortHours,
      0,
      0
    );

    itens.add(newTask);
    notifyListeners();
  }


  int countItens() => itens.fold(0, (acc, p) => acc + p.effortHours);
}