import 'package:flutter/material.dart';
import 'package:bottom_picker/bottom_picker.dart';
import 'package:intl/intl.dart';
import 'package:todo_assignment/utils/common/common_color.dart';
import 'package:todo_assignment/utils/common/common_const.dart';
import 'package:todo_assignment/utils/common/widgets/custom_snackbar.dart';
import 'package:todo_assignment/utils/common/widgets/custom_text.dart';

void showTimePickerBottomSheet(
  BuildContext context,
  Size size,
  TextEditingController addReminderController,
  TextEditingController dueDateController,
) {
  showModalBottomSheet(
    backgroundColor: CommonColor.whiteColor,
    context: context,
    isScrollControlled: true,
    enableDrag: false,
    builder: (builder) {
      return Padding(
        padding: EdgeInsets.all(size.width * numD03),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            /// title,, close-icon-button
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                CustomText(
                  title: 'Set Reminder Time',
                  fontSize: size.width * numD042,
                  fontWeight: FontWeight.w700,
                ),
                IconButton(
                  padding: EdgeInsets.zero,
                  style: ButtonStyle(
                    tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                    backgroundColor: WidgetStateProperty.resolveWith<Color?>(
                      (Set<WidgetState> states) {
                        return Colors.grey.withOpacity(0.3);
                      },
                    ),
                  ),
                  icon: const Icon(Icons.close),
                  onPressed: () {
                    Navigator.pop(context);
                  },
                ),
              ],
            ),
            SizedBox(height: size.width * numD03),

            /// time-picker
            Container(
                decoration: BoxDecoration(
                    border: Border.all(
                        width: size.width * numD001, color: Colors.grey),
                    borderRadius:
                        const BorderRadius.all(Radius.circular(num8))),
                child: BottomPicker.time(
                  buttonSingleColor: CommonColor.blackColor,
                  buttonWidth: size.width * numD80,
                  buttonPadding: 0,
                  onSubmit: (index) {
                    onTimeSubmitTap(
                      context,
                      dueDateController,
                      addReminderController,
                      index,
                    );
                  },
                  buttonStyle: BoxDecoration(
                    color: CommonColor.blackColor,
                    borderRadius: BorderRadius.all(
                      Radius.circular(size.width * numD015),
                    ),
                  ),
                  buttonContent: Padding(
                    padding: EdgeInsets.all(size.width * numD04),
                    child: CustomText(
                      title: 'Set',
                      fontSize: size.width * numD04,
                      fontWeight: FontWeight.bold,
                      color: CommonColor.whiteColor,
                      textAlign: TextAlign.center,
                    ),
                  ),
                  displayCloseIcon: false,
                  use24hFormat: false,
                  initialTime: Time(
                    minutes: 0,
                  ),
                  pickerTitle: Container(),
                )),
          ],
        ),
      );
    },
  );
}

/// on-time-submit-tap
void onTimeSubmitTap(
  BuildContext context,
  TextEditingController dueDateController,
  TextEditingController addReminderController,
  DateTime index,
) {
  if (DateFormat('dd-MMM-yyyy').parse(dueDateController.text) ==
      DateTime.parse(index.toString())) {
    DateTime now = DateTime.now();
    final selectedDateTime =
        DateTime(now.year, now.month, now.day, now.hour, now.minute);
    addReminderController.text = DateFormat('h:mm a').format(selectedDateTime);
  } else {
    addReminderController.text =
        DateFormat('h:mm a').format(DateTime.parse(index.toString()));
  }
}
