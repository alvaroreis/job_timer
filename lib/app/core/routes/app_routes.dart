class AppRoutes {
  AppRoutes._();

  static const String splash_route = '/';
  //home
  static const String home_module_route = '/home/';
  // static const String home_page_route = '$home_module_route/';

  //login
  static const String login_module_route = '/login/';
  // static const String login_page_route = '$login_module_route/';

  //project
  static const String project_module_route = '/project';

  //project detail
  static const String project_detail_module_route = '/detail/';
  static const String project_detail_page_route =
      project_module_route + project_detail_module_route;

  //project register
  static const String project_register_module_route = '/register/';
  static const String project_register_page_route =
      project_module_route + project_register_module_route;

  //project task
  static const String project_task_module_route = '/task/';
  static const String project_task_page_route =
      project_module_route + project_task_module_route;
}
