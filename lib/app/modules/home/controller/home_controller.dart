import 'dart:developer';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:job_timer/app/services/project/project_service.dart';

import '../../../entities/project_status.dart';
import '../../../view_models/project_model.dart';

part 'home_state.dart';

class HomeController extends Cubit<HomeState> {
  final ProjectService _projectService;
  HomeController({required ProjectService projectService})
      : _projectService = projectService,
        super(HomeState.initial());

  Future<void> findAll() async {
    try {
      emit(state.copyWith(status: HomeStatus.loading));
      final projects = await _projectService.findByStatus(state.projectFilter);
      emit(state.copyWith(status: HomeStatus.complete, projects: projects));
    } catch (e, s) {
      log('Ocorreu um erro ao buscar projetos', error: e, stackTrace: s);
      emit(state.copyWith(
        status: HomeStatus.failure,
        errorMessage: 'Ocorreu um erro ao buscar projetos',
      ));
    }
  }

  Future<void> filter(ProjectStatus status) async {
    try {
      emit(state.copyWith(status: HomeStatus.loading, projects: []));
      final projects = await _projectService.findByStatus(status);
      emit(state.copyWith(
        status: HomeStatus.complete,
        projects: projects,
        projectFilter: status,
      ));
    } catch (e, s) {
      log('Ocorreu um erro ao buscar projetos', error: e, stackTrace: s);
      emit(state.copyWith(
        status: HomeStatus.failure,
        errorMessage: 'Ocorreu um erro ao buscar projetos',
      ));
    }
  }

  void update() => filter(state.projectFilter);
}
