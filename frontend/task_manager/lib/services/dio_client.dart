import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:task_manager/constants/constants.dart';
import 'package:task_manager/models/tasks_model.dart';

class DioClient {
  final Dio dio = Dio();

  Future<Tasks> fetchTasks() async {
    try{
      final response = await dio.get(baseURL+"/tasks",options: Options(
        responseType: ResponseType.plain,
      ),);
      final tasks = tasksFromJson(response.data);
      debugPrint("$response");
      return tasks;
    } on DioError catch(e){
      debugPrint("StatusCode: ${e.toString()}");
      throw Exception("Failed to load Tasks");
    }
  }

  Future<bool> createTask({required String name, bool isCompleted = false}) async {
    try{
      final response = await dio.post(baseURL+"/tasks",
        data: {
          "name":name,
          "completed":isCompleted,
        },
        options: Options(
        responseType: ResponseType.plain,
      ),);
      debugPrint("statusCode: ${response.statusCode}");
      return response.statusCode == 201;//successfully created
    } on DioError catch(e){
      debugPrint("StatusCode: ${e.toString()}");
      throw Exception("Failed to create Tasks");
    }
  }
}