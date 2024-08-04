import 'package:flutter/material.dart';
import 'package:todo_assignment/utils/common/common_color.dart';
import 'package:todo_assignment/utils/common/common_const.dart';
import 'package:todo_assignment/utils/common/widgets/custom_space.dart';
import 'package:todo_assignment/utils/common/widgets/custom_text.dart';

/// product categories bottom sheet
void priorityLevelBottomSheet(
  final BuildContext context,
  final Size size,
  final List<String> listData,
  Function(String) onSelectPriority,
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
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              /// title, close-button
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  CustomText(
                    title: 'Priority Level',
                    fontSize: size.width * numD045,
                    fontWeight: FontWeight.w600,
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
              verticalSpace(size.width * numD03),
              Container(
                decoration: BoxDecoration(
                  border:
                      Border.all(color: CommonColor.blackColor.withOpacity(.3)),
                  borderRadius: BorderRadius.circular(size.width * numD015),
                ),
                child: ListView.separated(
                  padding: EdgeInsets.all(size.width * numD015),
                  shrinkWrap: true,
                  itemBuilder: (ctx, index) {
                    return InkWell(
                      onTap: () {
                        onSelectPriority(listData[index]);
                        Navigator.pop(context);
                      },
                      child: SizedBox(
                        width: size.width,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            CustomText(
                              title: listData[index],
                              fontSize: size.width * numD038,
                            ),
                            IconButton(
                              onPressed: null,
                              icon: Icon(
                                Icons.flag,
                                color: (listData[index] == 'Urgent-Priority')
                                    ? CommonColor.errorColor
                                    : (listData[index] == 'Medium-Priority')
                                        ? CommonColor.blueColor
                                        : CommonColor.successColor,
                              ),
                            ),
                          ],
                        ),
                      ),
                    );
                  },
                  separatorBuilder: (ctx, index) {
                    return Divider(
                      color: CommonColor.blackColor.withOpacity(.3),
                    );
                  },
                  itemCount: listData.length,
                ),
              ),
            ],
          ),
        ),
      );
    },
  );
}
