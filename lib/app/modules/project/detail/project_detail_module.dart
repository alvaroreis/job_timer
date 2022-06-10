import 'package:flutter_modular/flutter_modular.dart';
import 'package:job_timer/app/modules/project/detail/project_detail_page.dart';
import 'package:job_timer/app/view_models/project_model.dart';
import 'package:modular_bloc_bind/modular_bloc_bind.dart';

import 'controller/project_detail_controller.dart';

class ProjectDetailModule extends Module {
  static String route = '/detail';

  @override
  List<Bind<Object>> get binds => [
        BlocBind.lazySingleton(
          (i) => ProjectDetailController(projectService: i()), //AppModule
        ),
      ];

  @override
  List<ModularRoute> get routes => [
        ChildRoute(
          ProjectDetailPage.route,
          child: (context, args) => ProjectDetailPage(
            controller: Modular.get()..setProject(args.data as ProjectModel),
          ),
        ),
      ];
}
