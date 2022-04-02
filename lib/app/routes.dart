import 'package:eschool_teacher/ui/screens/addAssignmentScreen.dart';
import 'package:eschool_teacher/ui/screens/assignment/assignmentScreen.dart';
import 'package:eschool_teacher/ui/screens/assignments/assignmentsScreen.dart';
import 'package:eschool_teacher/ui/screens/classScreen.dart';
import 'package:eschool_teacher/ui/screens/home/homeScreen.dart';
import 'package:eschool_teacher/ui/screens/loginScreen.dart';
import 'package:eschool_teacher/ui/screens/splashScreen.dart';
import 'package:eschool_teacher/ui/screens/studyMaterials/studyMaterialsScreen.dart';
import 'package:eschool_teacher/ui/screens/subject/subjectScreen.dart';
import 'package:eschool_teacher/ui/screens/uploadFiles/uploadFilesScreen.dart';
import 'package:eschool_teacher/ui/screens/uploadVideos/uploadVideosScreen.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class Routes {
  static const String splash = "splash";
  static const String home = "/";
  static const String login = "login";
  static const String classScreen = "/class";
  static const String subject = "/subject";

  static const String assignments = "/assignments";

  static const String studyMaterials = "/studyMaterials";

  static const String assignment = "/assignment";

  static const String addAssignment = "/addAssignment";

  static const String uploadVideos = "/uploadVideos";

  static const String uploadFiles = "/uploadFiles";

  static String currentRoute = splash;

  static Route<dynamic> onGenerateRouted(RouteSettings routeSettings) {
    currentRoute = routeSettings.name ?? "";
    switch (routeSettings.name) {
      case splash:
        {
          return CupertinoPageRoute(builder: (_) => SplashScreen());
        }
      case login:
        {
          return CupertinoPageRoute(builder: (_) => LoginScreen());
        }
      case home:
        {
          return CupertinoPageRoute(builder: (_) => HomeScreen());
        }
      case classScreen:
        {
          return CupertinoPageRoute(builder: (_) => ClassScreen());
        }
      case subject:
        {
          return CupertinoPageRoute(builder: (_) => SubjectScreen());
        }
      case assignments:
        {
          return CupertinoPageRoute(builder: (_) => AssignmentsScreen());
        }
      case assignment:
        {
          return CupertinoPageRoute(builder: (_) => AssignmentScreen());
        }
      case addAssignment:
        {
          return CupertinoPageRoute(builder: (_) => AddAssignmentScreen());
        }

      case studyMaterials:
        {
          return CupertinoPageRoute(builder: (_) => StudyMaterialsScreen());
        }
      case uploadVideos:
        {
          return CupertinoPageRoute(builder: (_) => UploadVideosScreen());
        }
      case uploadFiles:
        {
          return CupertinoPageRoute(builder: (_) => UploadFilesScreen());
        }
      default:
        {
          return CupertinoPageRoute(builder: (context) => const Scaffold());
        }
    }
  }
}
