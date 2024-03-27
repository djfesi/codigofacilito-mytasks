import 'package:MyTask/data/services/services.dart';
import 'package:MyTask/domain/entity/task.dart';
import 'package:MyTask/presentation/screens/form_task/task_form_screen.dart';
import 'package:MyTask/presentation/screens/list_task/change_notifier/change_notifier.dart';
import 'package:MyTask/presentation/screens/list_task/list_task_screen.dart';
import 'package:MyTask/presentation/screens/splash/splash_screen.dart';
import 'package:MyTask/presentation/screens/view_task/detail_task_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';
import 'package:MyTask/theme/color_schemes.g.dart';

class MyApp extends StatelessWidget {
  const MyApp({super.key, required this.dbService});

  final DbService dbService;

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    final themeProvider = Provider.of<ThemeProvider>(context);
    return ScreenUtilInit(builder: (context, child) {
      return MaterialApp(
          debugShowCheckedModeBanner: true,
          localizationsDelegates: [
            AppLocalizations.delegate,
            GlobalMaterialLocalizations.delegate,
            GlobalWidgetsLocalizations.delegate,
            GlobalCupertinoLocalizations.delegate,
          ],
          supportedLocales: [
            Locale('en'), // English
            Locale('es'), // Spanish
          ],
          onGenerateTitle: (BuildContext context) =>
              AppLocalizations.of(context)!.mytasks,
          themeMode: themeProvider.themeMode,
          theme: ThemeData(
            useMaterial3: true,
            colorScheme: lightColorScheme,
          ),
          darkTheme: ThemeData(
            useMaterial3: true,
            colorScheme: darkColorScheme,
          ),
          initialRoute: TasksScreen.home,
          routes: {
            TasksScreen.home: (context) => TasksScreen(),
            TaskFormScreen.formTask: (context) => TaskFormScreen(
                task: ModalRoute.of(context)?.settings.arguments as Task?),
            DetailTaskScreen.detail: (context) => DetailTaskScreen(
                task: ModalRoute.of(context)?.settings.arguments as Task)
          });
    });
  }
}
