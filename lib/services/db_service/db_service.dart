import 'package:flutter/foundation.dart';
import 'package:todo_assignment/services/notification_service/notification_service.dart';
import 'package:todo_assignment/utils/common/models/task_model.dart';
import 'package:hive/hive.dart';
import 'package:todo_assignment/utils/common_methods.dart';

abstract interface class DbService {
  void addTaskInDb({required TaskModel task});
  Future<void> deleteTask({required TaskModel task});
  List<TaskModel> loadTasks();
  void updateTask(TaskModel task);
}

class DbServiceImpl implements DbService {
  final Box box;
  DbServiceImpl({required this.box});

  @override
  void addTaskInDb({required TaskModel task}) {
    try {
      // Generate unique IDs for task and notification
      String uniqueId = idGenerator();
      task.id = uniqueId;
      task.notificationId = generateUniqueNotificationId();

      // Save task to database
      box.put(uniqueId, task.toMap());

      // Update task IDs list
      List<dynamic> idsList = box.get('idsList', defaultValue: []);
      idsList.insert(0, uniqueId);
      box.put('idsList', idsList);

      // Schedule notification
      DateTime combinedDateTime =
          combineDateAndTime(task.dueDate, task.addReminder);
      NotificationService.scheduleNotification(
        task.notificationId,
        task.title,
        task.description,
        combinedDateTime,
      );

      debugPrint('Task added successfully with ID: $uniqueId');
    } catch (e) {
      debugPrint('Error while adding task: $e');
    }
  }

  @override
  Future<void> deleteTask({required TaskModel task}) async {
    try {
      // Cancel notification
      NotificationService.cancelNotification(task.notificationId);

      // Delete task from database
      List<dynamic> idsList = box.get('idsList', defaultValue: []);
      idsList.remove(task.id);
      box.delete(task.id);
      box.put('idsList', idsList);

      debugPrint('Task deleted successfully with ID: ${task.id}');
    } catch (e) {
      debugPrint('Error while deleting task: $e');
    }
  }

  @override
  List<TaskModel> loadTasks() {
    try {
      List<dynamic> idsList = box.get('idsList', defaultValue: []);
      List<TaskModel> tasks = idsList.map((id) {
        Map<String, dynamic> taskMap = box.get(id);
        return TaskModel.fromMap(taskMap);
      }).toList();

      debugPrint('Tasks loaded successfully');
      return tasks;
    } catch (e) {
      debugPrint('Error while loading tasks: $e');
      return <TaskModel>[];
    }
  }

  @override
  void updateTask(TaskModel task) {
    try {
      // Cancel notification
      NotificationService.cancelNotification(task.notificationId);

      if (!task.isCompleted) {
        /// create new notification
        task.notificationId = generateUniqueNotificationId();

        // Schedule notification
        DateTime combinedDateTime =
            combineDateAndTime(task.dueDate, task.addReminder);
        NotificationService.scheduleNotification(
          task.notificationId,
          task.title,
          task.description,
          combinedDateTime,
        );
      }

      box.put(task.id, task.toMap());

      debugPrint('Task updated successfully with ID: ${task.id}');
    } catch (e) {
      debugPrint('Error while updating task: $e');
    }
  }
}
