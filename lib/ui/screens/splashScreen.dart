import 'package:eschool_teacher/app/routes.dart';
import 'package:flutter/material.dart';

class SplashScreen extends StatefulWidget {
  SplashScreen({Key? key}) : super(key: key);

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    navigateToNextScreen();
    super.initState();
  }

  void navigateToNextScreen() async {
    await Future.delayed(Duration(seconds: 2));
    Navigator.of(context).pushReplacementNamed(Routes.login);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: FlutterLogo(
          size: 30.0,
        ),
      ),
    );
  }
}
