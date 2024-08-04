import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:todo_assignment/features/show_tasks/cubit/show_task_cubit.dart';
import 'package:todo_assignment/features/show_tasks/cubit/show_task_state.dart';
import 'package:todo_assignment/features/show_tasks/widgets/edit_delete_bottom_sheet.dart';
import 'package:todo_assignment/utils/common/common_color.dart';
import 'package:todo_assignment/utils/common/common_const.dart';
import 'package:todo_assignment/utils/common/models/task_model.dart';
import 'package:todo_assignment/utils/common/widgets/custom_space.dart';
import 'package:todo_assignment/utils/common/widgets/custom_text.dart';

Widget priorityTasks(
  BuildContext context,
  Size size,
  ShowTasksCubit cubitData,
  String title,
  Color color,
  List<TaskModel> tasks,
) {
  return BlocBuilder<ShowTasksCubit, ShowTasksState>(
    builder: (context, state) {
      return Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Container(
                padding: EdgeInsets.all(size.width * numD015),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(size.width * numD03),
                  border: Border.all(color: color),
                ),
                child: CustomText(
                  title: title,
                  fontSize: size.width * numD04,
                  fontWeight: FontWeight.w500,
                ),
              ),
              Icon(
                Icons.flag,
                color: color,
              ),
            ],
          ),
          ListView.separated(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            padding: EdgeInsets.symmetric(vertical: size.width * numD03),
            itemCount: tasks.length,
            itemBuilder: (context, index) {
              final task = tasks[index];
              return GestureDetector(
                onLongPress: () {
                  debugPrint('LongPressed');
                  HapticFeedback.vibrate();
                  editDeleteBottomSheet(
                    context,
                    size,
                    cubitData,
                    task,
                  );
                },
                child: Material(
                  elevation: 5,
                  child: ListTile(
                    /// check-box
                    leading: Checkbox(
                      activeColor: CommonColor.blackColor,
                      materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
                      visualDensity: VisualDensity.compact,
                      value: task.isCompleted,
                      onChanged: (val) {
                        debugPrint('check-boc-val::::$val');
                        cubitData.toggleTaskCompletion(task, val ?? false);
                      },
                    ),

                    /// title
                    title: CustomText(
                      title: task.title,
                      fontSize: size.width * numD04,
                      fontWeight: FontWeight.w600,
                    ),

                    /// description
                    subtitle: CustomText(
                      title: task.description,
                      fontSize: size.width * numD035,
                    ),

                    /// due-date, reminder
                    trailing: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        CustomText(
                          title: task.dueDate,
                          fontSize: size.width * numD025,
                        ),
                        CustomText(
                          title: task.addReminder,
                          fontSize: size.width * numD025,
                        ),
                      ],
                    ),
                  ),
                ),
              );
            },
            separatorBuilder: (BuildContext context, int index) {
              return verticalSpace(size.width * numD015);
            },
          )
        ],
      );
    },
  );
}
