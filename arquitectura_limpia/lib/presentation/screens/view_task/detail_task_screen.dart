import 'package:MyTask/data/services/services.dart';
import 'package:MyTask/domain/entity/task.dart';
import 'package:MyTask/my_app.dart';
import 'package:MyTask/theme/styles/text_style_app.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import '../../../main.dart';

class DetailTaskScreen extends StatefulWidget {
  const DetailTaskScreen({super.key, required this.task});

  static const detail = '/detail';

  final Task task;

  @override
  State<DetailTaskScreen> createState() => _DetailTaskScreenState();
}

class _DetailTaskScreenState extends State<DetailTaskScreen> {
  late DbService _dbService;

  @override
  void initState() {
    super.initState();
    _dbService = context.findAncestorWidgetOfExactType<MyApp>()!.dbService;
  }

  @override
  Widget build(BuildContext context) {
    final localizations = AppLocalizations.of(context)!;
    return Scaffold(
      appBar: AppBar(
        title: Text(
          localizations.details,
          style: textStyleBase.h226,
        ),
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            alignment: Alignment.center,
            child: Image.asset("assets/images/task_detail.png"),
          ),
          Text(
            widget.task.title,
            style: textStyleBase.h134,
          ),
          Text(
            widget.task.description,
            style: textStyleBase.h220,
          ),
        ],
      ),
    );
  }
}
