import 'package:job_timer/app/entities/project.dart';

import '../entities/project_status.dart';
import 'project_task_model.dart';

class ProjectModel {
  final int? id;
  final String name;
  final int estimate;
  final List<ProjectTaskModel> taks;
  final ProjectStatus status;

  ProjectModel({
    this.id,
    required this.name,
    required this.estimate,
    required this.taks,
    required this.status,
  });

  factory ProjectModel.fromEntity(Project project) {
    // carregando taks do banco de dados
    project.taks.loadSync();

    return ProjectModel(
      name: project.name,
      status: project.status,
      taks: project.taks.map(ProjectTaskModel.fromEntity).toList(),
      estimate: project.estimate,
    );
  }
}
