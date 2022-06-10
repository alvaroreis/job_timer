import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:job_timer/app/services/project/project_service.dart';
import 'package:job_timer/app/view_models/project_model.dart';

part 'project_detail_state.dart';

class ProjectDetailController extends Cubit<ProjectDetailState> {
  final ProjectService _projectService;
  ProjectDetailController({required ProjectService projectService})
      : _projectService = projectService,
        super(const ProjectDetailState.initial());

  void setProject(ProjectModel projectModel) {
    emit(state.copyWith(
      status: ProjectDetailStatus.complete,
      projectModel: projectModel,
    ));
  }

  void update() async {
    final project = await _projectService.findById(state.projectModel!.id!);
    emit(state.copyWith(
      projectModel: project,
      status: ProjectDetailStatus.complete,
    ));
  }

  void finish() async {
    try {
      emit(state.copyWith(status: ProjectDetailStatus.loading));
      await _projectService.finish(state.projectModel!.id!);
      update();
    } catch (e) {
      emit(state.copyWith(status: ProjectDetailStatus.failure));
    }
  }
}
