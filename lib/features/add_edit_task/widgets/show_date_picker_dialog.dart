import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:syncfusion_flutter_datepicker/datepicker.dart';
import 'package:todo_assignment/utils/common/common_color.dart';
import 'package:todo_assignment/utils/common/common_const.dart';
import 'package:todo_assignment/utils/common/widgets/custom_space.dart';

void showDatePickerDialog(
  BuildContext context,
  Size size,
  TextEditingController controller,
  DateRangePickerController dateController,
) {
  // Parse the date from the controller or use a default date
  DateTime? initialDate = controller.text.isNotEmpty
      ? DateFormat('dd-MMM-yyyy').parse(controller.text)
      : DateTime.now();

  // Set the initial selected date in the controller
  dateController.selectedDate = initialDate;

  showModalBottomSheet(
    context: context,
    builder: (BuildContext context) {
      return Padding(
        padding: EdgeInsets.all(size.width * numD03),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.end,
          mainAxisSize: MainAxisSize.min,
          children: [

            /// close-icon
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
            verticalSpace(size.width * numD03),

            /// Date range picker
            Card(
              elevation: 3,
              child: SfDateRangePicker(
                yearCellStyle: DateRangePickerYearCellStyle(
                  todayTextStyle: const TextStyle(
                    color: CommonColor.blueColor,
                    fontWeight: FontWeight.bold,
                  ),
                  todayCellDecoration: BoxDecoration(
                    border: Border.all(
                      color: CommonColor.blueColor,
                    ),
                    borderRadius: BorderRadius.circular(size.width * numD03),
                  ),
                ),
                monthCellStyle: DateRangePickerMonthCellStyle(
                  selectionColor: CommonColor.blackColor,
                  selectionTextStyle: const TextStyle(
                    color: CommonColor.whiteColor,
                    fontWeight: FontWeight.bold,
                  ),
                  todayTextStyle: const TextStyle(
                    color: CommonColor.blueColor,
                    fontWeight: FontWeight.bold,
                  ),
                  todayCellDecoration: BoxDecoration(
                    border: Border.all(
                      color: CommonColor.blueColor,
                    ),
                    borderRadius: BorderRadius.circular(size.width * numD03),
                  ),
                ),
                showNavigationArrow: true,
                controller: dateController,
                initialDisplayDate: initialDate,
                initialSelectedDate: initialDate,
                selectionColor: CommonColor.blackColor,
                selectionTextStyle: const TextStyle(
                  color: CommonColor.whiteColor,
                  fontWeight: FontWeight.bold,
                ),
                enablePastDates: false,
                onSelectionChanged: (DateRangePickerSelectionChangedArgs args) {
                  if (args.value is DateTime) {
                    controller.text =
                        DateFormat('dd-MMM-yyyy').format(args.value);
                    Navigator.pop(context);
                  }
                },
                selectionMode: DateRangePickerSelectionMode.single,
                showActionButtons: false,
              ),
            ),
          ],
        ),
      );
    },
  );
}
