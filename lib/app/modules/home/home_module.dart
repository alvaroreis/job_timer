import 'package:flutter_modular/flutter_modular.dart';
import 'package:job_timer/app/modules/home/home_page.dart';

class HomeModule extends Module {
  static String route = '/home';

  @override
  List<Bind> get binds => [];

  @override
  List<ModularRoute> get routes => [
        ChildRoute(
          HomePage.route,
          child: (context, args) => const HomePage(),
        ),
      ];
}
