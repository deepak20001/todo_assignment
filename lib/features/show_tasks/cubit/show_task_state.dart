import 'package:equatable/equatable.dart';
import 'package:todo_assignment/utils/common/models/task_model.dart';

abstract class ShowTasksState extends Equatable {
  const ShowTasksState();

  @override
  List<Object> get props => [];
}

class ShowTasksInitial extends ShowTasksState {}

class ShowTasksLoading extends ShowTasksState {}

class ShowTasksLoaded extends ShowTasksState {
  final List<TaskModel> tasks;
  final List<TaskModel> urgentPriorityTasks;
  final List<TaskModel> mediumPriorityTasks;
  final List<TaskModel> leastPriorityTasks;

  const ShowTasksLoaded(
    this.tasks,
    this.urgentPriorityTasks,
    this.mediumPriorityTasks,
    this.leastPriorityTasks,
  );

  @override
  List<Object> get props => [tasks];
}

class ShowTasksError extends ShowTasksState {
  final String message;

  const ShowTasksError(this.message);

  @override
  List<Object> get props => [message];
}
