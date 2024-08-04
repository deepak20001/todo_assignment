import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:todo_assignment/features/add_edit_task/screens/add_edit_task_screen.dart';
import 'package:todo_assignment/features/show_tasks/cubit/show_task_cubit.dart';
import 'package:todo_assignment/utils/common/common_color.dart';
import 'package:todo_assignment/utils/common/common_const.dart';
import 'package:todo_assignment/utils/common/common_route.dart';
import 'package:todo_assignment/utils/common/models/task_model.dart';
import 'package:todo_assignment/utils/common/widgets/custom_space.dart';
import 'package:todo_assignment/utils/common/widgets/custom_text.dart';

/// edit-delete-bottom-sheet
void editDeleteBottomSheet(
  final BuildContext context,
  final Size size,
  final ShowTasksCubit cubitData,
  final TaskModel task,
) {
  showModalBottomSheet(
    isDismissible: true,
    isScrollControlled: true,
    useSafeArea: true,
    context: context,
    builder: (BuildContext context) {
      debugPrint('nfId------------------------------${task.notificationId}');
      return SafeArea(
        child: Container(
          width: double.infinity,
          padding: EdgeInsets.symmetric(
              horizontal: size.width * numD03, vertical: size.width * numD065),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.only(
              topLeft: Radius.circular(size.width * numD07),
              topRight: Radius.circular(size.width * numD07),
            ), // Optional: for rounded border
            color: CommonColor.whiteColor,
          ),
          child: BlocProvider.value(
            value: cubitData,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: <Widget>[
                InkWell(
                  onTap: () {
                    Navigator.pop(context);
                    Routes.push(
                        widget: AddEditTaskScreen(
                          id: task.id,
                          title: task.title,
                          description: task.description,
                          priorityLevel: task.priorityLevel,
                          dueDate: task.dueDate,
                          addReminder: task.addReminder,
                          isEditingTask: true,
                          notificationId: task.notificationId,
                        ),
                        context: context);
                  },
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      CustomText(
                        title: 'Edit task',
                        fontSize: size.width * numD04,
                      ),
                      horizontalSpace(size.width * numD03),
                      const Icon(Icons.edit),
                    ],
                  ),
                ),
                const Divider(thickness: .3),
                InkWell(
                  onTap: () {
                    cubitData.deleteTask(task);
                    Navigator.pop(context);
                  },
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      CustomText(
                        title: 'Delete task',
                        fontSize: size.width * numD04,
                      ),
                      horizontalSpace(size.width * numD03),
                      const Icon(Icons.delete),
                    ],
                  ),
                ),
                verticalSpace(size.width * numD03),
              ],
            ),
          ),
        ),
      );
    },
  );
}
