import 'dart:developer';

import 'package:bloc/bloc.dart';
import 'package:job_timer/app/services/project/project_service.dart';
import 'package:job_timer/app/view_models/project_model.dart';

import '../../../../view_models/project_task_model.dart';

part 'task_state.dart';

class TaskController extends Cubit<TaskStatus> {
  late final ProjectModel _projectModel;
  final ProjectService _projectService;
  TaskController({required ProjectService projectService})
      : _projectService = projectService,
        super(TaskStatus.initial);

  void setProject(ProjectModel projectModel) => _projectModel = projectModel;

  Future<void> register({required int duration, required String name}) async {
    try {
      emit(TaskStatus.loading);
      final taskModel = ProjectTaskModel(name: name, duration: duration);
      await _projectService.addTask(_projectModel.id!, taskModel);
      await Future.delayed(const Duration(milliseconds: 700));
      emit(TaskStatus.success);
    } catch (e, s) {
      log('Ocorreu um erro ao salvar task.', error: e, stackTrace: s);
      emit(TaskStatus.failure);
    }
  }
}
