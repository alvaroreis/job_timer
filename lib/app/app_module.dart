import 'package:flutter_modular/flutter_modular.dart';
import 'package:job_timer/app/core/database/database.dart';
import 'package:job_timer/app/core/database/database_impl.dart';
import 'package:job_timer/app/modules/login/login_module.dart';
import 'package:job_timer/app/repositories/project/project_repository.dart';
import 'package:job_timer/app/repositories/project/project_repository_impl.dart';
import 'package:job_timer/app/services/auth/auth_service.dart';
import 'package:job_timer/app/services/auth/auth_service_impl.dart';
import 'package:job_timer/app/services/project/project_service.dart';
import 'package:job_timer/app/services/project/project_service_impl.dart';

import 'modules/home/home_module.dart';
import 'modules/project/project_module.dart';
import 'modules/splash/splash_page.dart';

class AppModule extends Module {
  @override
  List<Bind> get binds => [
        Bind.lazySingleton<AuthService>((i) => AuthServiceImpl()),
        Bind.lazySingleton<Database>((i) => DatabaseImpl()),

        // project
        Bind.lazySingleton<ProjectRepository>(
          (i) => ProjectRepositoryImpl(database: i()),
        ),
        Bind.lazySingleton<ProjectService>(
          (i) => ProjectServiceImpl(repository: i()),
        ),
      ];

  @override
  List<ModularRoute> get routes => [
        ChildRoute(
          SplashPage.route,
          child: (context, args) => const SplashPage(),
        ),
        ModuleRoute(LoginModule.route, module: LoginModule()),
        ModuleRoute(HomeModule.route, module: HomeModule()),
        ModuleRoute(ProjectModule.route, module: ProjectModule()),
      ];
}
