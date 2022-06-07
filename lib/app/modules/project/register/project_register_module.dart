import 'package:flutter_modular/flutter_modular.dart';
import 'package:job_timer/app/modules/project/register/project_register_page.dart';

class ProjectRegisterModule extends Module {
  static String route = '/register';

  @override
  List<Bind> get binds => [];

  @override
  List<ModularRoute> get routes => [
        ChildRoute(
          ProjectRegisterPage.route,
          child: (context, args) => const ProjectRegisterPage(),
        ),
      ];
}
