import 'package:flutter_modular/flutter_modular.dart';
import 'package:job_timer/app/modules/project/detail/project_detail_page.dart';

class ProjectDetailModule extends Module {
  static String route = '/detail';

  @override
  List<ModularRoute> get routes => [
        ChildRoute(
          ProjectDetailPage.route,
          child: (context, args) => const ProjectDetailPage(),
        ),
      ];
}
