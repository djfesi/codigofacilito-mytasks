import 'package:MyTask/domain/entity/task.dart';
import 'package:MyTask/presentation/screens/form_task/task_form_screen.dart';
import 'package:MyTask/presentation/screens/view_task/detail_task_screen.dart';
import 'package:MyTask/theme/styles/text_style_app.dart';
import 'package:flutter/cupertino.dart';
import 'package:timeago/timeago.dart' as timeago;
import 'package:flutter/material.dart';

class TaskTile extends StatelessWidget {
  const TaskTile({
    super.key,
    required this.task,
    required this.onDelete,
  });

  final Task task;
  final VoidCallback onDelete;

  @override
  Widget build(BuildContext context) {
    final String timeAgo = timeago.format(task.createdAt, locale: Localizations.localeOf(context).languageCode);

    return ListTile(
      leading: IconButton(
        onPressed: () {
          Navigator.of(context).pushNamed(TaskFormScreen.formTask, arguments: task);
        },
        icon: const Icon(Icons.edit, size: 40,),
      ),
      onTap: () {
        Navigator.of(context).pushNamed(DetailTaskScreen.detail, arguments: task);
      },
      title: Text(task.title, style: textStyleBase.h220,),
      subtitle: Text('ID: ${task.id} - $timeAgo'),
      trailing: IconButton(
        onPressed: onDelete,
        icon: const Icon(Icons.delete, size: 40,),
      ),
    );
  }
}
