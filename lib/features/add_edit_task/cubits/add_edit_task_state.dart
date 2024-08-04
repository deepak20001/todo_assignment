import 'package:equatable/equatable.dart';
import 'package:todo_assignment/utils/common/models/task_model.dart';

abstract class AddEditTaskState extends Equatable {
  const AddEditTaskState();

  @override
  List<Object> get props => [];
}

class AddEditTaskInitial extends AddEditTaskState {}

class AddEditTaskLoading extends AddEditTaskState {}

class AddEditTaskLoaded extends AddEditTaskState {
  final TaskModel task;

  const AddEditTaskLoaded(this.task);

  @override
  List<Object> get props => [task];
}

class AddEditTaskError extends AddEditTaskState {
  final String message;

  const AddEditTaskError(this.message);

  @override
  List<Object> get props => [message];
}

class AddEditTaskSuccess extends AddEditTaskState {}
