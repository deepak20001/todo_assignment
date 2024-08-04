import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:todo_assignment/features/add_edit_task/cubits/add_edit_task_cubit.dart';
import 'package:todo_assignment/features/add_edit_task/cubits/add_edit_task_state.dart';
import 'package:todo_assignment/features/add_edit_task/widgets/build_add_edit_task_form_field.dart';
import 'package:todo_assignment/utils/common/common_const.dart';
import 'package:todo_assignment/utils/common/models/task_model.dart';
import 'package:todo_assignment/utils/common/widgets/custom_button.dart';
import 'package:todo_assignment/utils/common/widgets/custom_space.dart';
import 'package:todo_assignment/utils/common/widgets/custom_text.dart';

class AddEditTaskScreen extends StatelessWidget {
  const AddEditTaskScreen({
    super.key,
    required this.id,
    required this.title,
    required this.description,
    required this.priorityLevel,
    required this.dueDate,
    required this.addReminder,
    required this.isEditingTask,
  });
  final String id;
  final String title;
  final String description;
  final String priorityLevel;
  final String dueDate;
  final String addReminder;
  final bool isEditingTask;

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.sizeOf(context);

    return BlocProvider(
      create: (context) => AddEditTaskCubit(
        title,
        description,
        priorityLevel,
        dueDate,
        addReminder,
      ),
      child: BlocBuilder<AddEditTaskCubit, AddEditTaskState>(
        builder: (context, state) {
          var cubitData = context.read<AddEditTaskCubit>();

          return Scaffold(
            /// app-bar
            appBar: AppBar(
              centerTitle: true,
              title: CustomText(
                title: isEditingTask ? 'Edit Task' : 'Add Task',
                fontSize: size.width * numD05,
                fontWeight: FontWeight.bold,
              ),
            ),

            /// bottom-nav-bar
            bottomNavigationBar: Padding(
              padding: EdgeInsets.all(size.width * numD035),
              child: CustomButton(
                onTap: () {
                  if (cubitData.formKey.currentState!.validate()) {
                    var task = TaskModel(
                      title: cubitData.titleController.text,
                      description: cubitData.descriptionController.text,
                      id: id,
                      priorityLevel: cubitData.priorityLevelController.text,
                      dueDate: cubitData.dueDateController.text,
                      addReminder: cubitData.addReminderController.text,
                      isCompleted: false,
                    );

                    if (isEditingTask) {
                      cubitData.editTask(task);
                    } else {
                      cubitData.addTask(task);
                    }
                  }
                },
                buttonText: isEditingTask ? 'Update' : 'Add',
              ),
            ),

            /// body
            body: SingleChildScrollView(
              child: Padding(
                padding: EdgeInsets.symmetric(horizontal: size.width * numD035),
                child: Form(
                  key: context.read<AddEditTaskCubit>().formKey,
                  child: Column(
                    children: [
                      verticalSpace(size.width * numD04),
                      buildAddEditTaskFormField(
                        context,
                        size,
                        cubitData.titleController,
                        cubitData.descriptionController,
                        cubitData.priorityLevelController,
                        cubitData.dueDateController,
                        cubitData.addReminderController,
                        cubitData.dateController,
                      ),
                      verticalSpace(size.width * numD035),
                    ],
                  ),
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
