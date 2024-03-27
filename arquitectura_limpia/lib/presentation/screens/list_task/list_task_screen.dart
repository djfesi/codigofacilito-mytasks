import 'package:MyTask/data/services/services.dart';
import 'package:MyTask/presentation/screens/list_task/change_notifier/change_notifier.dart';
import 'package:flutter/material.dart';
import 'package:MyTask/domain/entity/task.dart';
import 'package:MyTask/presentation/screens/form_task/task_form_screen.dart';
import 'package:MyTask/presentation/screens/list_task/widgets/task_title.dart';
import 'package:MyTask/theme/styles/text_style_app.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:provider/provider.dart';

class TasksScreen extends StatelessWidget {
  static const home = '/home';

  @override
  Widget build(BuildContext context) {
    final localizations = AppLocalizations.of(context)!;
    final theme = Theme.of(context).colorScheme;
    final taskProvider = Provider.of<TaskProvider>(context);
    final tasks = taskProvider.tasks;

    return Scaffold(
      backgroundColor: theme.background,
      appBar: AppBar(
        title: Text(localizations.tasklist, style: textStyleBase.h226),
        actions: [
          IconButton(
            icon: Icon(
              Icons.brightness_4,
              size: 40,
            ),
            onPressed: () {
              final themeProvider =
                  Provider.of<ThemeProvider>(context, listen: false);
              themeProvider.toggleTheme();
            },
          ),
          IconButton(
            onPressed: () =>
                Navigator.of(context).pushNamed(TaskFormScreen.formTask),
            icon: const Icon(Icons.add, size: 40),
          ),
        ],
      ),
      body: SafeArea(
        child: tasks.isEmpty
            ? Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Image.asset("assets/images/task_view.png"),
                    Text(localizations.notask, style: textStyleBase.h132),
                    ElevatedButton(
                      onPressed: () => Navigator.of(context)
                          .pushNamed(TaskFormScreen.formTask),
                      child: Text(localizations.loadtask,
                          style: textStyleBase.h220),
                    ),
                  ],
                ),
              )
            : ListView.separated(
                itemBuilder: (_, index) {
                  final task = tasks[index];
                  return TaskTile(
                    task: task,
                    onDelete: () => taskProvider.deleteTask(task.id),
                  );
                },
                separatorBuilder: (_, __) => const Divider(),
                itemCount: tasks.length,
              ),
      ),
    );
  }
}
