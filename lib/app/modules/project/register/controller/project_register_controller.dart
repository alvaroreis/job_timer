import 'dart:developer';

import 'package:bloc/bloc.dart';

import '../../../../entities/project_status.dart';
import '../../../../services/project/project_service.dart';
import '../../../../view_models/project_model.dart';

part 'project_register_state.dart';

class ProjectRegisterController extends Cubit<ProjectRegisterStatus> {
  final ProjectService _projectService;
  ProjectRegisterController({required ProjectService projectService})
      : _projectService = projectService,
        super(ProjectRegisterStatus.initial);

  Future<void> register(String name, int estimate) async {
    try {
      emit(ProjectRegisterStatus.loading);
      final projectModel = ProjectModel(
        name: name,
        estimate: estimate,
        taks: [],
        status: ProjectStatus.em_andamento,
      );
      await _projectService.register(projectModel);
      await Future.delayed(const Duration(milliseconds: 700));
      emit(ProjectRegisterStatus.success);
    } catch (e, s) {
      log('Ocorreu um erro ao salvar projeto', error: e, stackTrace: s);
      emit(ProjectRegisterStatus.failure);
    }
  }
}
