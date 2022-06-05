import 'package:flutter_modular/flutter_modular.dart';
import 'package:job_timer/app/modules/login/login_page.dart';

class LoginModule extends Module {
  static String route = '/login';
  @override
  List<Bind> get binds => [];

  @override
  List<ModularRoute> get routes => [
        ChildRoute(
          LoginPage.route,
          child: (context, args) => const LoginPage(),
        ),
      ];
}
