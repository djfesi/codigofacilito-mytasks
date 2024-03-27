import 'package:MyTask/data/services/services.dart';
import 'package:MyTask/my_app.dart';
import 'package:MyTask/presentation/screens/list_task/change_notifier/change_notifier.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  final dbService = DbService();
  await dbService.open(dbName: 'myTasks.sqlite', version: 2);
  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(
            create: (_) => TaskProvider(dbService: dbService)),
        ChangeNotifierProvider(create: (context) => ThemeProvider()),
      ],
      child: MyApp(dbService: dbService),
    ),
  );
}
