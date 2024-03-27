import 'package:MyTask/domain/entity/task.dart';
import 'package:MyTask/my_app.dart';
import 'package:MyTask/presentation/screens/list_task/change_notifier/change_notifier.dart';
import 'package:MyTask/theme/styles/text_style_app.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:provider/provider.dart';

class TaskFormScreen extends StatefulWidget {
  const TaskFormScreen({super.key, this.task});

  static const formTask = '/formTask';

  final Task? task;

  @override
  State<TaskFormScreen> createState() => _TaskFormScreenState();
}

class _TaskFormScreenState extends State<TaskFormScreen> {
  late Task _formTask;

  @override
  void initState() {
    super.initState();
    _formTask = widget.task ??
        Task(
          id: 0,
          title: '',
          description: '',
          createdAt: DateTime.now(),
        );
  }

  Future<void> save() async {
    final taskProvider = Provider.of<TaskProvider>(context, listen: false);
    final localizations = AppLocalizations.of(context)!;
    bool result = false;

    if (_formTask.id == 0) {
      result = await taskProvider.addTask(_formTask);
    } else {
      result = await taskProvider.updateTask(_formTask);
    }

    if (!context.mounted) return;

    ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        content: Text(result
            ? (_formTask.id == 0
                ? localizations.addedTask
                : localizations.updatedTask)
            : localizations.errorOccurred)));
    if (result) Navigator.pop(context);
  }

  @override
  Widget build(BuildContext context) {
    final localizations = AppLocalizations.of(context)!;
    return Form(
      child: Scaffold(
        appBar: AppBar(
          title: Text(
            _formTask.id == 0 ? localizations.loadtask : localizations.editTask,
            style: textStyleBase.h226,
          ),
          actions: [
            IconButton(
              onPressed: save,
              icon: const Icon(
                Icons.save,
                size: 40,
              ),
            ),
          ],
        ),
        body: SafeArea(
          child: ListView(
            padding: const EdgeInsets.all(20),
            children: [
              _formTask.id == 0
                  ? Image.asset("assets/images/task_detail.png")
                  : Image.asset("assets/images/task.png"),
              TextFormField(
                initialValue: _formTask.title,
                onChanged: (value) {
                  setState(() {
                    _formTask = Task(
                        id: _formTask.id,
                        title: value,
                        description: _formTask.description,
                        createdAt: _formTask.createdAt);
                  });
                },
                validator: (value) {
                  return null;
                },
                style: TextStyle(fontSize: 22.0),
                decoration: InputDecoration(
                  labelText: localizations.title,
                  labelStyle: textStyleBase.h220,
                ),
              ),
              TextFormField(
                initialValue: _formTask.description,
                onChanged: (value) {
                  setState(() {
                    _formTask = Task(
                        id: _formTask.id,
                        title: _formTask.title,
                        description: value,
                        createdAt: _formTask.createdAt);
                  });
                },
                validator: (value) {
                  return null;
                },
                style: TextStyle(fontSize: 22.0),
                decoration: InputDecoration(
                  labelText: localizations.description,
                  labelStyle: textStyleBase.h220, //
                ),
                minLines: 3,
                maxLines: null,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
