import 'package:flutter_modular/flutter_modular.dart';
import 'package:job_timer/app/modules/project/task/task_page.dart';
import 'package:job_timer/app/view_models/project_model.dart';
import 'package:modular_bloc_bind/modular_bloc_bind.dart';

import 'controller/task_controller.dart';

class TaskModule extends Module {
  static String route = '/task';

  @override
  List<Bind<Object>> get binds => [
        BlocBind.lazySingleton(
          (i) => TaskController(projectService: i()), //AppModule
        ),
      ];

  @override
  List<ModularRoute> get routes => [
        ChildRoute(
          TaskPage.route,
          child: (context, args) => TaskPage(
            controller: Modular.get()..setProject(args.data as ProjectModel),
          ),
        ),
      ];
}
