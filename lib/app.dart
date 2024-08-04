import 'package:flutter/material.dart';
import 'package:todo_assignment/features/add_edit_task/screens/add_edit_task_screen.dart';
import 'package:todo_assignment/features/show_tasks/screens/show_tasks_screen.dart';
import 'package:todo_assignment/main.dart';
import 'package:todo_assignment/utils/common/common_color.dart';
import 'package:todo_assignment/utils/common/common_const.dart';

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.sizeOf(context);

    return MaterialApp(
      title: appNameText,
      navigatorKey: navigatorKey,
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        scaffoldBackgroundColor: CommonColor.whiteColor,
        colorScheme: const ColorScheme.light(
          primary: CommonColor.themeColor,
        ),
        elevatedButtonTheme: ElevatedButtonThemeData(
          style: ElevatedButton.styleFrom(
            backgroundColor: CommonColor.blackColor,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(
                size.width * numD01,
              ),
            ),
          ),
        ),
        appBarTheme: const AppBarTheme(
          elevation: 0,
          backgroundColor: CommonColor.themeColor,
          iconTheme: IconThemeData(
            color: CommonColor.blackColor,
          ),
        ),
        useMaterial3: true,
      ),
      home: const ShowTasksScreen(),
    );
  }
}
