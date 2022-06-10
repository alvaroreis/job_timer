import 'package:flutter_modular/flutter_modular.dart';
import 'package:job_timer/app/modules/home/home_page.dart';
import 'package:modular_bloc_bind/modular_bloc_bind.dart';

import 'controller/home_controller.dart';

class HomeModule extends Module {
  @override
  List<Bind> get binds => [
        BlocBind.lazySingleton(
          (i) => HomeController(projectService: i()), // appModule
        ),
      ];

  @override
  List<ModularRoute> get routes => [
        ChildRoute(
          '/',
          child: (context, args) => HomePage(
            controller: Modular.get<HomeController>()..findAll(),
          ),
        ),
      ];
}
