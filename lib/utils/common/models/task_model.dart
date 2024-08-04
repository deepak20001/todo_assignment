// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

class TaskModel {
  String id = '';
  final String title;
  final String description;
  final String priorityLevel;
  final String dueDate;
  final String addReminder;
  bool isCompleted = false;
  int notificationId;

  TaskModel({
    required this.id,
    required this.title,
    required this.description,
    required this.priorityLevel,
    required this.dueDate,
    required this.addReminder,
    required this.isCompleted,
    required this.notificationId,
  });

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id': id,
      'title': title,
      'description': description,
      'priorityLevel': priorityLevel,
      'dueDate': dueDate,
      'addReminder': addReminder,
      'isCompleted': isCompleted,
      'notificationId': notificationId,
    };
  }

  factory TaskModel.fromMap(Map<String, dynamic> map) {
    return TaskModel(
      id: map['id'] as String,
      title: map['title'] as String,
      description: map['description'] as String,
      priorityLevel: map['priorityLevel'] as String,
      dueDate: map['dueDate'] as String,
      addReminder: map['addReminder'] as String,
      isCompleted: map['isCompleted'] as bool,
      notificationId: map['notificationId'] as int,
    );
  }

  String toJson() => json.encode(toMap());

  factory TaskModel.fromJson(String source) =>
      TaskModel.fromMap(json.decode(source) as Map<String, dynamic>);

  TaskModel copyWith({
    String? id,
    String? title,
    String? description,
    String? priorityLevel,
    String? dueDate,
    String? addReminder,
    bool? isCompleted,
    int? notificationId,
  }) {
    return TaskModel(
      id: id ?? this.id,
      title: title ?? this.title,
      description: description ?? this.description,
      priorityLevel: priorityLevel ?? this.priorityLevel,
      dueDate: dueDate ?? this.dueDate,
      addReminder: addReminder ?? this.addReminder,
      isCompleted: isCompleted ?? this.isCompleted,
      notificationId: notificationId ?? this.notificationId,
    );
  }
}
