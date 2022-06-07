import 'package:flutter_modular/flutter_modular.dart';
import 'package:job_timer/app/modules/login/controller/login_controller.dart';
import 'package:job_timer/app/modules/login/login_page.dart';
import 'package:modular_bloc_bind/modular_bloc_bind.dart';

class LoginModule extends Module {
  static String route = '/login';
  @override
  List<Bind> get binds => [
        BlocBind.lazySingleton(
          (i) => LoginController(authService: i()), // authService > appModule
        ),
      ];

  @override
  List<ModularRoute> get routes => [
        ChildRoute(
          LoginPage.route,
          child: (context, args) => LoginPage(controller: Modular.get()),
        ),
      ];
}
