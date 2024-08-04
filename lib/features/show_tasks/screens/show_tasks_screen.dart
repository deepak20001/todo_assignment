import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:lottie/lottie.dart';
import 'package:todo_assignment/features/add_edit_task/screens/add_edit_task_screen.dart';
import 'package:todo_assignment/features/show_tasks/cubit/show_task_cubit.dart';
import 'package:todo_assignment/features/show_tasks/cubit/show_task_state.dart';
import 'package:todo_assignment/features/show_tasks/widgets/edit_delete_bottom_sheet.dart';
import 'package:todo_assignment/utils/common/common_color.dart';
import 'package:todo_assignment/utils/common/common_const.dart';
import 'package:todo_assignment/utils/common/common_route.dart';
import 'package:todo_assignment/utils/common/common_utils.dart';
import 'package:todo_assignment/utils/common/widgets/custom_text.dart';

class ShowTasksScreen extends StatelessWidget {
  const ShowTasksScreen({super.key});

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.sizeOf(context);

    return BlocProvider(
      create: (context) => ShowTasksCubit(),
      child: Scaffold(
        /// app-bar
        appBar: AppBar(
          centerTitle: true,
          title: CustomText(
            title: 'My Tasks',
            fontSize: size.width * numD05,
            fontWeight: FontWeight.bold,
          ),
        ),

        /// floating-action-button
        floatingActionButton: FloatingActionButton.extended(
          backgroundColor: CommonColor.blackColor,
          onPressed: () {
            Routes.push(
                widget: const AddEditTaskScreen(
                  id: '',
                  title: '',
                  description: '',
                  priorityLevel: '',
                  dueDate: '',
                  addReminder: '',
                  isEditingTask: false,
                ),
                context: context);
          },
          label: CustomText(
            title: 'Add Task',
            fontSize: size.width * numD035,
            color: CommonColor.whiteColor,
          ),
          icon: const Icon(
            Icons.add,
            color: CommonColor.whiteColor,
          ),
        ),

        /// body
        body: BlocBuilder<ShowTasksCubit, ShowTasksState>(
          builder: (context, state) {
            final cubitData = context.read<ShowTasksCubit>();

            if (state is ShowTasksLoading) {
              return const Center(
                child: CircularProgressIndicator(
                  color: CommonColor.blackColor,
                ),
              );
            } else if (state is ShowTasksError) {
              return Text('Error: ${state.message}');
            } else if (state is ShowTasksLoaded) {
              if (state.tasks.isEmpty) {
                return Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Lottie.asset('${CommonPath.aniamtionPath}no_data.json'),
                    CustomText(
                      title: 'Add some tasks!',
                      fontSize: size.width * numD045,
                      fontWeight: FontWeight.w600,
                    ),
                  ],
                );
              } else {
                return ListView.builder(
                  itemCount: state.tasks.length,
                  itemBuilder: (context, index) {
                    final task = state.tasks[index];
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
                      child: ListTile(
                        /// check-box
                        leading: Checkbox(
                          activeColor: CommonColor.blackColor,
                          materialTapTargetSize:
                              MaterialTapTargetSize.shrinkWrap,
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
                    );
                  },
                );
              }
            }
            return const SizedBox.shrink();
          },
        ),
      ),
    );
  }
}
