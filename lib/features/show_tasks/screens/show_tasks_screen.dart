import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:lottie/lottie.dart';
import 'package:todo_assignment/features/add_edit_task/screens/add_edit_task_screen.dart';
import 'package:todo_assignment/features/search_task/screens/search_task_screen.dart';
import 'package:todo_assignment/features/show_tasks/cubit/show_task_cubit.dart';
import 'package:todo_assignment/features/show_tasks/cubit/show_task_state.dart';
import 'package:todo_assignment/features/show_tasks/widgets/edit_delete_bottom_sheet.dart';
import 'package:todo_assignment/features/show_tasks/widgets/priority_tasks.dart';
import 'package:todo_assignment/utils/common/common_color.dart';
import 'package:todo_assignment/utils/common/common_const.dart';
import 'package:todo_assignment/utils/common/common_route.dart';
import 'package:todo_assignment/utils/common/common_utils.dart';
import 'package:todo_assignment/utils/common/models/task_model.dart';
import 'package:todo_assignment/utils/common/widgets/custom_space.dart';
import 'package:todo_assignment/utils/common/widgets/custom_text.dart';
import 'package:todo_assignment/utils/common/widgets/custom_text_form_field.dart';

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
          actions: [
            BlocBuilder<ShowTasksCubit, ShowTasksState>(
              builder: (context, state) {
                return IconButton(
                  onPressed: () {
                    Routes.push(widget: const SearchTask(), context: context)
                        .then(
                      (val) => context.read<ShowTasksCubit>().initDbService(),
                    );
                  },
                  icon: const Icon(Icons.search),
                );
              },
            ),
          ],
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
                  notificationId: 0,
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
                return SingleChildScrollView(
                  physics: const BouncingScrollPhysics(),
                  child: Padding(
                    padding:
                        EdgeInsets.symmetric(horizontal: size.width * numD035),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        verticalSpace(size.width * numD03),

                        /// urgent-priority
                        if (state.urgentPriorityTasks.isNotEmpty) ...[
                          priorityTasks(
                            context,
                            size,
                            cubitData,
                            'Urgent Priority',
                            CommonColor.errorColor,
                            state.urgentPriorityTasks,
                          ),
                          verticalSpace(size.width * numD03),
                        ],

                        /// medium-priority
                        if (state.mediumPriorityTasks.isNotEmpty) ...[
                          priorityTasks(
                            context,
                            size,
                            cubitData,
                            'Medium Priority',
                            CommonColor.blueColor,
                            state.mediumPriorityTasks,
                          ),
                          verticalSpace(size.width * numD03),
                        ],

                        /// least-priority
                        if (state.leastPriorityTasks.isNotEmpty) ...[
                          priorityTasks(
                            context,
                            size,
                            cubitData,
                            'Least Priority',
                            CommonColor.successColor,
                            state.leastPriorityTasks,
                          ),
                          verticalSpace(size.width * numD20),
                        ],
                      ],
                    ),
                  ),
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
