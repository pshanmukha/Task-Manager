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

// for single task

SingleTask singleTaskFromJson(String str) => SingleTask.fromJson(json.decode(str));

String singleTaskToJson(SingleTask data) => json.encode(data.toJson());

class SingleTask {
  SingleTask({
    required this.task,
  });

  Task task;

  factory SingleTask.fromJson(Map<String, dynamic> json) => SingleTask(
    task: Task.fromJson(json["task"]),
  );

  Map<String, dynamic> toJson() => {
    "task": task.toJson(),
  };
}

class Task {
  Task({
    required this.completed,
    required this.id,
    required this.name,
  });

  bool completed;
  String id;
  String name;

  factory Task.fromJson(Map<String, dynamic> json) => Task(
    completed: json["completed"],
    id: json["_id"],
    name: json["name"],
  );

  Map<String, dynamic> toJson() => {
    "completed": completed,
    "_id": id,
    "name": name,
  };
}