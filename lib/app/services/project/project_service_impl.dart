import 'package:job_timer/app/repositories/project/project_repository.dart';
import 'package:job_timer/app/view_models/project_model.dart';

import './project_service.dart';
import '../../entities/project.dart';

class ProjectServiceImpl implements ProjectService {
  final ProjectRepository _repository;

  ProjectServiceImpl({
    required ProjectRepository repository,
  }) : _repository = repository;

  @override
  Future<void> register(ProjectModel projectModel) async {
    final project = Project()
      ..id = projectModel.id
      ..name = projectModel.name
      ..status = projectModel.status
      ..estimate = projectModel.estimate;

    await _repository.register(project);
  }
}
