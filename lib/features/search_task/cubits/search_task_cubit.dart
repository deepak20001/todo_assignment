// Cubit class
import 'dart:developer' as devtools show log;
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hive/hive.dart';
import 'package:todo_assignment/features/search_task/cubits/search_task_state.dart';
import 'package:todo_assignment/services/db_service/db_service.dart';
import 'package:todo_assignment/utils/common/models/task_model.dart';

class SearchTasksCubit extends Cubit<SearchTasksState> {
  late DbService dbService;
  List<TaskModel> _tasks = [];
  List<TaskModel> _filteredTasks = [];
  String _sortBy = '';
  TextEditingController searchController = TextEditingController();

  SearchTasksCubit() : super(SearchTasksInitial()) {
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
      emit(SearchTasksLoading());
      final List<TaskModel> tasks = dbService.loadTasks();
      _tasks = tasks;
      _filteredTasks = tasks;

      emit(SearchTasksLoaded(
        tasks,
        tasks,
        _sortBy,
      ));
    } catch (error) {
      emit(SearchTasksError(error.toString()));
    }
  }

  /// toggle-task-completion
  void toggleTaskCompletion(TaskModel task, bool val) async {
    try {
      // task.isCompleted = true; --> can't do like this as our fields are final so using copyWith method
      final updatedTask = task.copyWith(isCompleted: val);

      dbService.updateTask(updatedTask);
      final updatedTasks = dbService.loadTasks();
      _tasks = updatedTasks;
      _filteredTasks = updatedTasks;
      emit(SearchTasksLoaded(
        updatedTasks,
        updatedTasks,
        _sortBy,
      ));
    } catch (error) {
      emit(SearchTasksError(error.toString()));
    }
  }

  /// delete task
  void deleteTask(TaskModel task) async {
    try {
      dbService.deleteTask(task: task);
      final updatedTasks = dbService.loadTasks();
      _tasks = updatedTasks;
      _filteredTasks = updatedTasks;

      emit(SearchTasksLoaded(
        updatedTasks,
        updatedTasks,
        _sortBy,
      ));
    } catch (error) {
      emit(SearchTasksError(error.toString()));
    }
  }

  /// search tasks by keyword or title
  void searchTasks(String keyword) {
    try {
      emit(SearchTasksLoading());

      // Filter tasks based on the keyword or title
      final List<TaskModel> filteredTasks = _tasks.where((task) {
        final titleMatch =
            task.title.toLowerCase().contains(keyword.toLowerCase());
        final descriptionMatch =
            task.description.toLowerCase().contains(keyword.toLowerCase());
        return titleMatch || descriptionMatch;
      }).toList();

      _filteredTasks = filteredTasks;

      emit(SearchTasksLoaded(
        _tasks,
        filteredTasks,
        _sortBy,
      ));
    } catch (error) {
      emit(SearchTasksError(error.toString()));
    }
  }

  /// on selecting sort by
  void onSelectingSortBy(String val) {
    try {
      emit(SearchTasksLoading());

      _sortBy = val;
      List<TaskModel> filteredTasks = [];
      if (_sortBy == 'Task Priority') {
        List<TaskModel> urgentPriorityList = [];
        List<TaskModel> mediumPriorityList = [];
        List<TaskModel> leastPriorityList = [];

        for (int i = 0; i < _filteredTasks.length; i++) {
          if (_filteredTasks[i].priorityLevel == 'Urgent-Priority') {
            urgentPriorityList.add(_filteredTasks[i]);
          } else if (_filteredTasks[i].priorityLevel == 'Medium-Priority') {
            mediumPriorityList.add(_filteredTasks[i]);
          } else {
            leastPriorityList.add(_filteredTasks[i]);
          }
        }

        filteredTasks = [
          ...urgentPriorityList,
          ...mediumPriorityList,
          ...leastPriorityList
        ];
      } else {
        filteredTasks = _filteredTasks;
        filteredTasks.sort((a, b) => a.dueDate.compareTo(b.dueDate));
      }

      _filteredTasks = filteredTasks;

      emit(SearchTasksLoaded(
        _tasks,
        filteredTasks,
        _sortBy,
      ));
    } catch (error) {
      emit(SearchTasksError(error.toString()));
    }
  }

  @override
  void onChange(Change<SearchTasksState> change) {
    super.onChange(change);
    devtools.log('ShowTasksState on change -> $change');
  }

  @override
  void onError(Object error, StackTrace stackTrace) {
    super.onError(error, stackTrace);
    devtools.log('ShowTasksState on error -> $error');
  }
}
