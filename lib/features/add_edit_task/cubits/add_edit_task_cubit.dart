import 'dart:developer' as devtools show log;
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hive/hive.dart';
import 'package:syncfusion_flutter_datepicker/datepicker.dart';
import 'package:todo_assignment/features/show_tasks/screens/show_tasks_screen.dart';
import 'package:todo_assignment/main.dart';
import 'package:todo_assignment/services/db_service/db_service.dart';
import 'package:todo_assignment/utils/common/common_color.dart';
import 'package:todo_assignment/utils/common/common_route.dart';
import 'package:todo_assignment/utils/common/models/task_model.dart';
import 'package:todo_assignment/utils/common/widgets/custom_snackbar.dart';
import 'add_edit_task_state.dart';

class AddEditTaskCubit extends Cubit<AddEditTaskState> {
  final GlobalKey<FormState> formKey = GlobalKey();
  final titleController = TextEditingController();
  final descriptionController = TextEditingController();
  final priorityLevelController = TextEditingController();
  final dueDateController = TextEditingController();
  final addReminderController = TextEditingController();
  final DateRangePickerController dateController = DateRangePickerController();
  late DbService dbService;
  final String title, description, priorityLevel, dueDate, addReminder;

  AddEditTaskCubit(
    this.title,
    this.description,
    this.priorityLevel,
    this.dueDate,
    this.addReminder,
  ) : super(AddEditTaskInitial()) {
    titleController.text = title;
    descriptionController.text = description;
    priorityLevelController.text = priorityLevel;
    dueDateController.text = dueDate;
    addReminderController.text = addReminder;
    initDbService();
  }

  /// init-database-service
  Future<void> initDbService() async {
    var box = Hive.box(name: 'tasksDb');
    dbService = DbServiceImpl(box: box);
  }

  /// add-task
  void addTask(TaskModel task) async {
    emit(AddEditTaskLoading());
    try {
      dbService.addTaskInDb(task: task);
      emit(AddEditTaskSuccess());
      Routes.pushReplacement(
          widget: const ShowTasksScreen(),
          context: navigatorKey.currentContext!);
      showSnackBar(
        navigatorKey.currentContext!,
        'Task added successfully!',
        CommonColor.successColor,
        CommonColor.whiteColor,
      );
    } catch (e) {
      emit(AddEditTaskError(e.toString()));
    }
  }

  /// edit-task
  void editTask(TaskModel task) async {
    debugPrint('edit-task-id::::::${task.id}');
    emit(AddEditTaskLoading());
    try {
      dbService.updateTask(task);
      emit(AddEditTaskSuccess());
      Routes.pushReplacement(
          widget: const ShowTasksScreen(),
          context: navigatorKey.currentContext!);
      showSnackBar(
        navigatorKey.currentContext!,
        'Task updated successfully!',
        CommonColor.successColor,
        CommonColor.whiteColor,
      );
    } catch (e) {
      emit(AddEditTaskError(e.toString()));
    }
  }

  @override
  void onChange(Change<AddEditTaskState> change) {
    super.onChange(change);
    devtools.log('AddEditTaskState on change -> $change');
  }

  @override
  void onError(Object error, StackTrace stackTrace) {
    super.onError(error, stackTrace);
    devtools.log('AddEditTaskState on error -> $error');
  }
}
