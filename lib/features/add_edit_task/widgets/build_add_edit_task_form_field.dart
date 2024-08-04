import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:syncfusion_flutter_datepicker/datepicker.dart';
import 'package:todo_assignment/features/add_edit_task/widgets/priority_level_bottom_sheet.dart';
import 'package:todo_assignment/features/add_edit_task/widgets/show_date_picker_dialog.dart';
import 'package:todo_assignment/features/add_edit_task/widgets/show_time_picker_bottom_sheet.dart';
import 'package:todo_assignment/utils/common/common_const.dart';
import 'package:todo_assignment/utils/common/common_form_validation.dart';
import 'package:todo_assignment/utils/common/widgets/custom_space.dart';
import 'package:todo_assignment/utils/common/widgets/custom_text_form_field.dart';

Widget buildAddEditTaskFormField(
  BuildContext context,
  Size size,
  TextEditingController titleController,
  TextEditingController descriptionController,
  TextEditingController priorityLevelController,
  TextEditingController dueDateController,
  TextEditingController addReminderController,
  DateRangePickerController dateController,
) {
  if (dueDateController.text.trim().isEmpty) {
    dueDateController.text = DateFormat('dd-MMM-yyyy').format(DateTime.now());
  }
  return Column(
    children: [
      CustomTextFormField(
        size: size,
        controller: titleController,
        hintText: 'Title',
        validation: (value) {
          return CommonFormValidation.nameValidator(value, 'Name');
        },
      ),
      verticalSpace(size.width * numD03),
      CustomTextFormField(
        size: size,
        controller: descriptionController,
        hintText: 'Description',
        maxLines: 4,
        validation: (value) {
          return CommonFormValidation.nameValidator(value, 'Description');
        },
      ),
      verticalSpace(size.width * numD03),
      CustomTextFormField(
        size: size,
        controller: priorityLevelController,
        isRead: true,
        hintText: 'Priority level',
        onTap: () {
          priorityLevelBottomSheet(
            context,
            size,
            ['Urgent-Priority', 'Medium-Priority', 'Least-Priority'],
            (priority) {
              priorityLevelController.text = priority;
            },
          );
        },
        validation: (value) {
          return CommonFormValidation.nameValidator(value, 'Priority level');
        },
      ),
      verticalSpace(size.width * numD03),
      CustomTextFormField(
        size: size,
        controller: dueDateController,
        isRead: true,
        hintText: 'Due Date',
        validation: (value) {
          return CommonFormValidation.nameValidator(value, 'Due Date');
        },
        onTap: () {
          showDatePickerDialog(
            context,
            size,
            dueDateController,
            dateController,
          );
        },
      ),
      verticalSpace(size.width * numD03),
      CustomTextFormField(
        size: size,
        controller: addReminderController,
        isRead: true,
        hintText: 'Add reminder',
        validation: (value) {
          return CommonFormValidation.nameValidator(value, 'Add reminder');
        },
        onTap: () {
          showTimePickerBottomSheet(
            context,
            size,
            addReminderController,
            dueDateController,
          );
        },
      ),
    ],
  );
}
