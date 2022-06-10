import 'dart:developer';

import 'package:isar/isar.dart';
import 'package:job_timer/app/core/database/database.dart';
import 'package:job_timer/app/core/exceptions/failure_error.dart';
import 'package:job_timer/app/entities/project_status.dart';

import './project_repository.dart';
import '../../entities/project.dart';
import '../../entities/project_task.dart';

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

  @override
  Future<Project> addTask(int projectId, ProjectTask task) async {
    final conn = await _database.openDatabase();
    final project = await findById(projectId);
    project.taks.add(task);
    await conn.writeTxn((isar) => project.taks.save());
    return project;
  }

  @override
  Future<Project> findById(int projectId) async {
    final conn = await _database.openDatabase();
    final project = await conn.projects.get(projectId);

    if (null == project) {
      throw FailureError(message: 'Projeto não encontrado.');
    }
    return project;
  }

  @override
  Future<void> finish(int projectId) async {
    try {
      final conn = await _database.openDatabase();
      final project = await conn.projects.get(projectId);
      if (null == project) {
        throw FailureError(message: 'Projeto não encontrado.');
      }
      project.status = ProjectStatus.finalizado;
      await conn
          .writeTxn((isar) => isar.projects.put(project, saveLinks: true));
    } on IsarError catch (e, s) {
      log(e.message, error: e, stackTrace: s);
      FailureError(message: 'Ocorreu um erro ao finalizar o projeto.');
    }
  }
}
