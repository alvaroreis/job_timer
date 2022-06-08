import 'dart:developer';

import 'package:isar/isar.dart';
import 'package:job_timer/app/core/database/database.dart';
import 'package:job_timer/app/core/exceptions/failure_error.dart';
import 'package:job_timer/app/entities/project_status.dart';

import './project_repository.dart';
import '../../entities/project.dart';

class ProjectRepositoryImpl implements ProjectRepository {
  final Database _database;

  ProjectRepositoryImpl({required Database database}) : _database = database;

  @override
  Future<void> register(Project project) async {
    try {
      final conn = await _database.openDatabase();
      await conn.writeTxn((isar) => isar.projects.put(project));
    } on IsarError catch (e, s) {
      log('Ocorreu um erro ao cadastrar projeto', error: e, stackTrace: s);
      throw FailureError(message: 'Ocorreu um erro ao cadastrar projeto');
    }
  }

  @override
  Future<List<Project>> findByStatus(ProjectStatus status) async {
    final conn = await _database.openDatabase();
    return await conn.projects.filter().statusEqualTo(status).findAll();
  }
}
