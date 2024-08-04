import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:lottie/lottie.dart';
import 'package:todo_assignment/features/search_task/cubits/search_task_cubit.dart';
import 'package:todo_assignment/features/search_task/cubits/search_task_state.dart';
import 'package:todo_assignment/features/search_task/widgets/edit_delete_bottom_sheet.dart';
import 'package:todo_assignment/utils/common/common_color.dart';
import 'package:todo_assignment/utils/common/common_const.dart';
import 'package:todo_assignment/utils/common/common_utils.dart';
import 'package:todo_assignment/utils/common/widgets/custom_space.dart';
import 'package:todo_assignment/utils/common/widgets/custom_text.dart';
import 'package:todo_assignment/utils/common/widgets/custom_text_form_field.dart';

class SearchTask extends StatelessWidget {
  const SearchTask({super.key});

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.sizeOf(context);

    return BlocProvider(
      create: (context) => SearchTasksCubit(),
      child: Scaffold(
        resizeToAvoidBottomInset: false,

        /// app-bar
        appBar: AppBar(
          centerTitle: true,
          title: CustomText(
            title: 'Search',
            fontSize: size.width * numD05,
            fontWeight: FontWeight.bold,
          ),
        ),

        /// body
        body: BlocBuilder<SearchTasksCubit, SearchTasksState>(
          builder: (context, state) {
            final cubitData = context.read<SearchTasksCubit>();

            return Padding(
              padding: EdgeInsets.all(size.width * numD035),
              child: Column(
                children: [
                  Row(
                    children: [
                      Expanded(
                        child: CustomTextFormField(
                          controller: cubitData.searchController,
                          size: size,
                          hintText: 'Search tasks',
                          suffixIcon:
                              cubitData.searchController.text.trim().isEmpty
                                  ? const Icon(Icons.search)
                                  : IconButton(
                                      onPressed: () {
                                        FocusScope.of(context)
                                            .requestFocus(FocusNode());
                                        cubitData.searchController.clear();
                                        cubitData.loadTasks();
                                      },
                                      icon: const Icon(Icons.close),
                                    ),
                          onChange: (val) {
                            cubitData.searchTasks(val);
                          },
                        ),
                      ),
                      horizontalSpace(size.width * numD015),
                      BlocBuilder<SearchTasksCubit, SearchTasksState>(
                        builder: (context, state) {
                          if (state is SearchTasksLoaded) {
                            return InkWell(
                              onTap: () {
                                sortByBottomSheet(
                                  context,
                                  size,
                                  cubitData,
                                  state.sortBy,
                                );
                              },
                              child: Container(
                                decoration: BoxDecoration(
                                  color: CommonColor.blackColor,
                                  borderRadius: BorderRadius.circular(
                                      size.width * numD015),
                                ),
                                child: Icon(
                                  Icons.filter_alt_outlined,
                                  color: CommonColor.whiteColor,
                                  size: size.width * numD13,
                                ),
                              ),
                            );
                          } else {
                            return const SizedBox.shrink();
                          }
                        },
                      ),
                    ],
                  ),
                  verticalSpace(size.width * numD045),
                  BlocBuilder<SearchTasksCubit, SearchTasksState>(
                      builder: (context, state) {
                    final cubitData = context.read<SearchTasksCubit>();

                    if (state is SearchTasksLoading) {
                      return const Center(
                        child: CircularProgressIndicator(
                          color: CommonColor.blackColor,
                        ),
                      );
                    } else if (state is SearchTasksError) {
                      return Text('Error: ${state.message}');
                    } else if (state is SearchTasksLoaded) {
                      if (state.searchList.isEmpty) {
                        return Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Lottie.asset(
                                '${CommonPath.aniamtionPath}no_data.json'),
                            CustomText(
                              title: 'No task found!',
                              fontSize: size.width * numD045,
                              fontWeight: FontWeight.w600,
                            ),
                          ],
                        );
                      } else {
                        return Expanded(
                          child: ListView.separated(
                            physics: const BouncingScrollPhysics(),
                            shrinkWrap: true,
                            padding: EdgeInsets.symmetric(
                                vertical: size.width * numD03),
                            itemCount: state.searchList.length,
                            itemBuilder: (context, index) {
                              final task = state.searchList[index];
                              return GestureDetector(
                                onLongPress: () {
                                  FocusScope.of(context)
                                      .requestFocus(FocusNode());
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
                                      materialTapTargetSize:
                                          MaterialTapTargetSize.shrinkWrap,
                                      visualDensity: VisualDensity.compact,
                                      value: task.isCompleted,
                                      onChanged: (val) {
                                        debugPrint('check-boc-val::::$val');
                                        FocusScope.of(context)
                                            .requestFocus(FocusNode());
                                        cubitData.toggleTaskCompletion(
                                            task, val ?? false);
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
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
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
                            separatorBuilder:
                                (BuildContext context, int index) {
                              return verticalSpace(size.width * numD015);
                            },
                          ),
                        );
                      }
                    }
                    return const SizedBox.shrink();
                  })
                ],
              ),
            );
          },
        ),
      ),
    );
  }
}

/// sort-by-bottom-sheet
void sortByBottomSheet(
  final BuildContext context,
  final Size size,
  final SearchTasksCubit cubitData,
  final String val,
) {
  showModalBottomSheet(
    isDismissible: true,
    isScrollControlled: true,
    useSafeArea: true,
    context: context,
    builder: (BuildContext context) {
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
                CustomText(
                  title: 'SORT BY',
                  fontSize: size.width * numD045,
                ),
                const Divider(thickness: .5),
                verticalSpace(size.width * numD03),
                InkWell(
                  splashColor: Colors.transparent,
                  highlightColor: Colors.transparent,
                  onTap: () {
                    cubitData.onSelectingSortBy('Task Priority');
                    Navigator.pop(context);
                  },
                  child: Row(
                    children: [
                      Container(
                        height: size.width * numD05,
                        width: size.width * numD05,
                        alignment: Alignment.center,
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          border: Border.all(
                            color: val == 'Task Priority'
                                ? CommonColor.blackColor
                                : CommonColor.greyColor,
                            width: val == 'Task Priority'
                                ? size.width * numD014
                                : size.width * numD001,
                          ),
                        ),
                      ),
                      SizedBox(width: size.width * numD03),
                      CustomText(
                        title: 'Task Priority',
                        fontSize: size.width * numD04,
                      ),
                    ],
                  ),
                ),
                verticalSpace(size.width * numD03),
                InkWell(
                  splashColor: Colors.transparent,
                  highlightColor: Colors.transparent,
                  onTap: () {
                    cubitData.onSelectingSortBy('Due Date');
                    Navigator.pop(context);
                  },
                  child: Row(
                    children: [
                      Container(
                        height: size.width * numD05,
                        width: size.width * numD05,
                        alignment: Alignment.center,
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          border: Border.all(
                            color: val == 'Due Date'
                                ? CommonColor.blackColor
                                : CommonColor.greyColor.withOpacity(0.5),
                            width: val == 'Due Date'
                                ? size.width * numD014
                                : size.width * numD001,
                          ),
                        ),
                      ),
                      SizedBox(width: size.width * numD03),
                      CustomText(
                        title: 'Due Date',
                        fontSize: size.width * numD04,
                      ),
                    ],
                  ),
                ),
                SizedBox(width: size.width * numD075),
                verticalSpace(size.width * numD03),
              ],
            ),
          ),
        ),
      );
    },
  );
}
