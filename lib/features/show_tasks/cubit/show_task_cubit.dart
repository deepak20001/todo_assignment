// Cubit class
import 'dart:developer' as devtools show log;
import 'package:flutter/foundation.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hive/hive.dart';
import 'package:todo_assignment/features/show_tasks/cubit/show_task_state.dart';
import 'package:todo_assignment/services/db_service/db_service.dart';
import 'package:todo_assignment/utils/common/models/task_model.dart';

class ShowTasksCubit extends Cubit<ShowTasksState> {
  late DbService dbService;

  ShowTasksCubit() : super(ShowTasksInitial()) {
    initDbService();
  }

  /// initialise database service
  Future<void> initDbService() async {
    var box = Hive.box(name: 'tasksDb');
    dbService = DbServiceImpl(box: box);
    loadTasks();
  }

  /// load tasks
  Future<void> loadTasks() async {
    debugPrint('loadTasks-method::::::::::::::::::::::::::::::');
    try {
      emit(ShowTasksLoading());
      final List<TaskModel> tasks = dbService.loadTasks();
      List<TaskModel> urgentPriorityTasks = <TaskModel>[];
      List<TaskModel> mediumPriorityTasks = <TaskModel>[];
      List<TaskModel> leastPriorityTasks = <TaskModel>[];

      for (int i = 0; i < tasks.length; i++) {
        switch (tasks[i].priorityLevel) {
          case 'Urgent-Priority':
            urgentPriorityTasks.add(tasks[i]);
            break;
          case 'Medium-Priority':
            mediumPriorityTasks.add(tasks[i]);
            break;
          case 'Least-Priority':
            leastPriorityTasks.add(tasks[i]);
            break;
          default:
        }
      }
      emit(ShowTasksLoaded(
        tasks,
        urgentPriorityTasks,
        mediumPriorityTasks,
        leastPriorityTasks,
      ));
    } catch (error) {
      emit(ShowTasksError(error.toString()));
    }
  }

  /// toggle-task-completion
  void toggleTaskCompletion(TaskModel task, bool val) async {
    try {
      // task.isCompleted = true; --> can't do like this as our fields are final so using copyWith method
      final updatedTask = task.copyWith(isCompleted: val);

      dbService.updateTask(updatedTask);
      final updatedTasks = dbService.loadTasks();
      List<TaskModel> urgentPriorityTasks = <TaskModel>[];
      List<TaskModel> mediumPriorityTasks = <TaskModel>[];
      List<TaskModel> leastPriorityTasks = <TaskModel>[];

      for (int i = 0; i < updatedTasks.length; i++) {
        switch (updatedTasks[i].priorityLevel) {
          case 'Urgent-Priority':
            urgentPriorityTasks.add(updatedTasks[i]);
            break;
          case 'Medium-Priority':
            mediumPriorityTasks.add(updatedTasks[i]);
            break;
          case 'Least-Priority':
            leastPriorityTasks.add(updatedTasks[i]);
            break;
          default:
        }
      }
      emit(ShowTasksLoaded(
        updatedTasks,
        urgentPriorityTasks,
        mediumPriorityTasks,
        leastPriorityTasks,
      ));
    } catch (error) {
      emit(ShowTasksError(error.toString()));
    }
  }

  /// delete task
  void deleteTask(TaskModel task) async {
    try {
      dbService.deleteTask(task: task);
      final updatedTasks = dbService.loadTasks();
      List<TaskModel> urgentPriorityTasks = <TaskModel>[];
      List<TaskModel> mediumPriorityTasks = <TaskModel>[];
      List<TaskModel> leastPriorityTasks = <TaskModel>[];

      for (int i = 0; i < updatedTasks.length; i++) {
        switch (updatedTasks[i].priorityLevel) {
          case 'Urgent-Priority':
            urgentPriorityTasks.add(updatedTasks[i]);
            break;
          case 'Medium-Priority':
            mediumPriorityTasks.add(updatedTasks[i]);
            break;
          case 'Least-Priority':
            leastPriorityTasks.add(updatedTasks[i]);
            break;
          default:
        }
      }
      emit(ShowTasksLoaded(
        updatedTasks,
        urgentPriorityTasks,
        mediumPriorityTasks,
        leastPriorityTasks,
      ));
    } catch (error) {
      emit(ShowTasksError(error.toString()));
    }
  }

  @override
  void onChange(Change<ShowTasksState> change) {
    super.onChange(change);
    devtools.log('ShowTasksState on change -> $change');
  }

  @override
  void onError(Object error, StackTrace stackTrace) {
    super.onError(error, stackTrace);
    devtools.log('ShowTasksState on error -> $error');
  }
}
