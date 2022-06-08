import 'package:flutter_modular/flutter_modular.dart';
import 'package:job_timer/app/modules/project/detail/project_detail_module.dart';
import 'package:job_timer/app/modules/project/register/project_register_module.dart';

class ProjectModule extends Module {
  static const String route = '/project';
  @override
  List<ModularRoute> get routes => [
        ModuleRoute(
          ProjectRegisterModule.route,
          module: ProjectRegisterModule(),
        ),
        ModuleRoute(
          ProjectDetailModule.route,
          module: ProjectDetailModule(),
        ),
      ];
}
