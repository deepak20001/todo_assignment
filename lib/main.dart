import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:hive/hive.dart';
import 'package:path_provider/path_provider.dart';
import 'package:todo_assignment/app.dart';
import 'package:todo_assignment/services/notification_service/notification_service.dart';
import 'package:timezone/data/latest.dart' as tz;

var navigatorKey = GlobalKey<NavigatorState>();

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp,
  ]);
  final directory = await getApplicationDocumentsDirectory();
  Hive.defaultDirectory = directory.path;
  await NotificationService.init();
  tz.initializeTimeZones();

  runApp(const MyApp());
}
