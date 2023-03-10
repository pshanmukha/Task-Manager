// To parse this JSON data, do
//
//     final tasks = tasksFromJson(jsonString);

import 'dart:convert';

Tasks tasksFromJson(String str) => Tasks.fromJson(json.decode(str));

String tasksToJson(Tasks data) => json.encode(data.toJson());

class Tasks {
  Tasks({
    required this.tasks,
  });

  List<Task> tasks;

  factory Tasks.fromJson(Map<String, dynamic> json) => Tasks(
    tasks: List<Task>.from(json["tasks"].map((x) => Task.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "tasks": List<dynamic>.from(tasks.map((x) => x.toJson())),
  };
}

class Task {
  Task({
    required this.completed,
    required this.id,
    required this.name,
    required this.v,
  });

  bool completed;
  String id;
  String name;
  int v;

  factory Task.fromJson(Map<String, dynamic> json) => Task(
    completed: json["completed"],
    id: json["_id"],
    name: json["name"],
    v: json["__v"],
  );

  Map<String, dynamic> toJson() => {
    "completed": completed,
    "_id": id,
    "name": name,
    "__v": v,
  };
}