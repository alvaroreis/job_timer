import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:job_timer/app/core/ui/images_ui.dart';
import 'package:job_timer/app/modules/home/home_module.dart';
import 'package:job_timer/app/modules/login/login_module.dart';

class SplashPage extends StatefulWidget {
  static String route = '/';
  const SplashPage({Key? key}) : super(key: key);

  @override
  State<SplashPage> createState() => _SplashPageState();
}

class _SplashPageState extends State<SplashPage> {
  @override
  void initState() {
    super.initState();

    FirebaseAuth.instance.authStateChanges().listen((User? user) {
      if (null == user) {
        Modular.to.navigate(LoginModule.route);
      } else {
        Modular.to.navigate(HomeModule.route);
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Material(
      child: Container(
        padding: const EdgeInsets.all(8.0),
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            colors: [
              Color(0XFF0092B9),
              Color(0XFF0167B2),
            ],
          ),
        ),
        child: Center(
          child: Image.asset(ImagesUI.logo),
        ),
      ),
    );
  }
}
