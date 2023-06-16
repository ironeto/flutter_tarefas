import 'dart:convert';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:gerenciador_de_tarefas/models/task_model.dart';
import 'package:http/http.dart';

import '../repositories/tasks_repository.dart';

class TasksService {
  final TasksRepository _tasksRepository = TasksRepository();

  Future<List<TaskModel>> list() async {
    try {
      final List<TaskModel> list = [];
      final response = await _tasksRepository.list();
      final docs = response.docs;
      for (var doc in docs) {
        list.add(TaskModel.fromJson(doc.id, doc.data()));
      }
      return list;
    } catch (err) {
      throw Exception("Problemas ao consultar lista de tasks.");
    }
  }

  Future<String> insert(TaskModel product) async {
    try {
      final response = await _tasksRepository.insert(product.toJson());
      return response.id;
    } catch (err) {
      throw Exception("Problemas ao inserir a task.");
    }
  }

  /* Future<bool> delete(String id) async {
    try {
      Response response = await _tasksRepository.delete(id);
      return response.statusCode == 200;
    } catch (err) {
      throw Exception("Problemas ao excluir task.");
    }
  } */
}