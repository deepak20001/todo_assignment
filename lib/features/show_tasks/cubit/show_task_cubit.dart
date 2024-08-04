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
      final tasks = dbService.loadTasks();
      emit(ShowTasksLoaded(tasks));
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
      emit(ShowTasksLoaded(updatedTasks));
    } catch (error) {
      emit(ShowTasksError(error.toString()));
    }
  }

  /// delete task
  void deleteTask(String taskId) async {
    try {
      dbService.deleteTask(taskId: taskId);
      final updatedTasks = dbService.loadTasks();
      emit(ShowTasksLoaded(updatedTasks));
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
