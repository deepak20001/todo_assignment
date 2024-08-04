import 'package:equatable/equatable.dart';
import 'package:todo_assignment/utils/common/models/task_model.dart';

abstract class SearchTasksState extends Equatable {
  const SearchTasksState();

  @override
  List<Object> get props => [];
}

class SearchTasksInitial extends SearchTasksState {}

class SearchTasksLoading extends SearchTasksState {}

class SearchTasksLoaded extends SearchTasksState {
  final List<TaskModel> tasks;
  final List<TaskModel> searchList;
  String sortBy = '';

  SearchTasksLoaded(
    this.tasks,
    this.searchList,
    this.sortBy,
  );

  @override
  List<Object> get props => [tasks, searchList];
}

class SearchTasksError extends SearchTasksState {
  final String message;

  const SearchTasksError(this.message);

  @override
  List<Object> get props => [message];
}
