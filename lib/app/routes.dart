import 'package:eschool_teacher/ui/screens/classScreen.dart';
import 'package:eschool_teacher/ui/screens/home/homeScreen.dart';
import 'package:eschool_teacher/ui/screens/loginScreen.dart';
import 'package:eschool_teacher/ui/screens/splashScreen.dart';
import 'package:eschool_teacher/ui/screens/subject/subjectScreen.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class Routes {
  static const String splash = "splash";
  static const String home = "/";
  static const String login = "login";
  static const String classScreen = "/class";
  static const String subjectScreen = "/subject";

  static String currentRoute = splash;

  static Route<dynamic> onGenerateRouted(RouteSettings routeSettings) {
    currentRoute = routeSettings.name ?? "";
    switch (routeSettings.name) {
      case splash:
        {
          return CupertinoPageRoute(
              builder: (_) => SplashScreen()); //Splash screen
        }
      case login:
        {
          return CupertinoPageRoute(
              builder: (_) => LoginScreen()); //Splash screen
        }
      case home:
        {
          return CupertinoPageRoute(
              builder: (_) => HomeScreen()); //Splash screen
        }
      case classScreen:
        {
          return CupertinoPageRoute(
              builder: (_) => ClassScreen()); //Splash screen
        }
      case subjectScreen:
        {
          return CupertinoPageRoute(
              builder: (_) => SubjectScreen()); //Splash screen
        }
      default:
        {
          return CupertinoPageRoute(builder: (context) => const Scaffold());
        }
    }
  }
}
