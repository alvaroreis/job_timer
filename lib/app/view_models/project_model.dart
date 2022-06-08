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
}
