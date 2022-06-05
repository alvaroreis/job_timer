import 'package:flutter_modular/flutter_modular.dart';
import 'package:job_timer/app/modules/login/login_module.dart';

import 'modules/home/home_module.dart';
import 'modules/splash/splash_page.dart';

class AppModule extends Module {
  @override
  List<Bind> get binds => [];

  @override
  List<ModularRoute> get routes => [
        ChildRoute(
          SplashPage.route,
          child: (context, args) => const SplashPage(),
        ),
        ModuleRoute(LoginModule.route, module: LoginModule()),
        ModuleRoute(HomeModule.route, module: HomeModule()),
      ];
}
