import 'dart:math';

import 'package:flutter/material.dart';
import 'package:shared_pk/IGenericOverviewCard.dart';

import '../models/task_model.dart';

class TasksProvider extends ChangeNotifier implements IGenericOverviewCard {
  final List<TaskModel> itens = [
    TaskModel(1,"Fazer Café", 1,0,0, DateTime(2023,5,28)),
    TaskModel(2,"Desenvolver projeto", 2,0,0, DateTime(2023,5,28))
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
    Task.date = DateTime.now();
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


  void addTask(String name, int effortHours, double latitude, double longitude) {
    int lastId = itens.isNotEmpty ? itens.map((task) => task.id).reduce(max) + 1 : 1;
    final newTask = TaskModel(
      (lastId + 1),
      name,
      effortHours,
      latitude,
      longitude,
      DateTime.now()
    );

    itens.add(newTask);
    notifyListeners();
  }

  @override
  int countItems() {
    return itens.fold(0, (acc, p) => acc + p.effortHours);
  }
}