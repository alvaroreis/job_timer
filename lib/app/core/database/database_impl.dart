import 'package:isar/isar.dart';
import 'package:job_timer/app/entities/project.dart';
import 'package:job_timer/app/entities/project_task.dart';
import 'package:path_provider/path_provider.dart';

import './database.dart';

class DatabaseImpl implements Database {
  Isar? _instanse;

  @override
  Future<Isar> openDatabase() async {
    if (null == _instanse) {
      final dir = await getApplicationSupportDirectory();
      _instanse = await Isar.open(
        schemas: [ProjectTaskSchema, ProjectSchema],
        directory: dir.path,
        inspector: true,
      );
    }
    return _instanse!;
  }
}
