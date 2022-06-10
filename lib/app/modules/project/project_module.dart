import 'package:flutter_modular/flutter_modular.dart';
import 'package:job_timer/app/core/routes/app_routes.dart';
import 'package:job_timer/app/modules/project/detail/project_detail_module.dart';
import 'package:job_timer/app/modules/project/register/project_register_module.dart';
import 'package:job_timer/app/modules/project/task/task_module.dart';

class ProjectModule extends Module {
  @override
  List<ModularRoute> get routes => [
        ModuleRoute(
          AppRoutes.project_register_module_route,
          module: ProjectRegisterModule(),
        ),
        ModuleRoute(
          AppRoutes.project_detail_module_route,
          module: ProjectDetailModule(),
        ),
        ModuleRoute(
          AppRoutes.project_task_module_route,
          module: TaskModule(),
        ),
      ];
}
