import 'package:flutter/foundation.dart';
import 'package:todo_assignment/utils/common/models/task_model.dart';
import 'package:hive/hive.dart';
import 'package:todo_assignment/utils/common_methods.dart';

abstract interface class DbService {
  void addTaskInDb({required TaskModel task});
  Future<void> deleteTask({required String taskId});
  List<TaskModel> loadTasks();
  void updateTask(TaskModel task);
}

class DbServiceImpl implements DbService {
  final Box box;
  DbServiceImpl({required this.box});

  @override
  void addTaskInDb({required TaskModel task}) {
    try {
      List<dynamic> idsList = box.get('idsList', defaultValue: []);

      /// generate unique id
      String uniqueId = idGenerator();
      task.id = uniqueId;

      /// here i am setting the id of the task
      box.put(uniqueId, task.toMap());

      /// insert the task in the list in my database
      idsList.insert(0, uniqueId);

      for (var element in idsList) {
        debugPrint('$element::::::::::::::::::::::::::::::::::::');
      }


      /// put the ids list again in database
      box.put('idsList', idsList);

      debugPrint('task added successfully.......................');
    } catch (e) {
      debugPrint('Error while adding task:::::::::$e');
    }
  }

  @override
  Future<void> deleteTask({required String taskId}) async {
    try {
      debugPrint('Deleting task id::::::$taskId');
      List<dynamic> idsList = box.get('idsList', defaultValue: []);
      for (int i = 0; i < idsList.length; i++) {
        debugPrint(idsList[i]);
      }
      idsList.remove(taskId);
      bool isDeleted = box.delete(taskId);
      box.put('idsList', idsList);
      debugPrint('deletion successful:::::::::::::::::::$isDeleted');
    } catch (e) {
      debugPrint('error-while-deleting::::$e');
    }
  }

  @override
  List<TaskModel> loadTasks() {
    debugPrint('Tasks-loading:::::::');
    try {
      List<dynamic> idsList = box.get('idsList', defaultValue: []);
      List<TaskModel> tasks = idsList.map((id) {
        Map<String, dynamic> taskMap = box.get(id);
        return TaskModel.fromMap(taskMap);
      }).toList();
      return tasks;
    } catch (e) {
      debugPrint('error while loading tasks::::$e');
      return <TaskModel>[];
    }
  }

  @override
  void updateTask(TaskModel task) {
    debugPrint(
        'Task-updating:::::::${task.title}----${task.isCompleted}-------${task.id}');
    try {
      box.put(task.id, task.toMap());
    } catch (e) {
      debugPrint('Error while updating task: $e');
    }
  }
}
