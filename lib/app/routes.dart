import 'package:eschool_teacher/ui/screens/aboutUsScreen.dart';
import 'package:eschool_teacher/ui/screens/add&editAssignmentScreen.dart';
import 'package:eschool_teacher/ui/screens/addOrEditAnnouncement/addOrEditAnnouncementScreen.dart';
import 'package:eschool_teacher/ui/screens/addOrEditLessonScreen.dart';
import 'package:eschool_teacher/ui/screens/addOrEditTopicScreen.dart';
import 'package:eschool_teacher/ui/screens/addResultScreen.dart';
import 'package:eschool_teacher/ui/screens/announcementsScreen.dart';

import 'package:eschool_teacher/ui/screens/assignment/assignmentScreen.dart';
import 'package:eschool_teacher/ui/screens/assignments/assignmentsScreen.dart';
import 'package:eschool_teacher/ui/screens/class/classScreen.dart';
import 'package:eschool_teacher/ui/screens/contactUsScreen.dart';
import 'package:eschool_teacher/ui/screens/home/homeScreen.dart';
import 'package:eschool_teacher/ui/screens/lessonsScreen.dart';
import 'package:eschool_teacher/ui/screens/login/loginScreen.dart';
import 'package:eschool_teacher/ui/screens/monthWiseAttendance/monthWiseAttendanceScreen.dart';
import 'package:eschool_teacher/ui/screens/privacyPolicyScreen.dart';
import 'package:eschool_teacher/ui/screens/resultScreen.dart';
import 'package:eschool_teacher/ui/screens/searchStudentScreen.dart';
import 'package:eschool_teacher/ui/screens/splashScreen.dart';
import 'package:eschool_teacher/ui/screens/studentDetails/studentDetailsScreen.dart';
import 'package:eschool_teacher/ui/screens/subject/subjectScreen.dart';
import 'package:eschool_teacher/ui/screens/termsAndConditionScreen.dart';
import 'package:eschool_teacher/ui/screens/topicsScreen.dart';
import 'package:eschool_teacher/ui/screens/takeAttendance/takeAttendanceScreen.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class Routes {
  static const String splash = "splash";
  static const String home = "/";
  static const String login = "login";
  static const String classScreen = "/class";
  static const String subject = "/subject";

  static const String assignments = "/assignments";

  static const String announcements = "/announcements";

  static const String topics = "/topics";

  static const String assignment = "/assignment";

  static const String addAssignment = "/addAssignment";

  static const String takeAttendance = "/takeAttendance";

  static const String searchStudent = "/searchStudent";

  static const String studentDetails = "/studentDetails";

  static const String result = "/result";

  static const String addResult = "/addResult";

  static const String lessons = "/lessons";

  static const String addOrEditLesson = "/addOrEditLesson";

  static const String addOrEditTopic = "/addOrEditTopic";

  static const String addOrEditAnnouncement = "/addOrEditAnnouncement";

  static const String monthWiseAttendance = "/monthWiseAttendance";

  static const String termsAndCondition = "/termsAndCondition";

  static const String aboutUs = "/aboutUs";
  static const String privacyPolicy = "/privacyPolicy";

  static const String contactUs = "/contactUs";

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
          return LoginScreen.route(routeSettings);
        }
      case home:
        {
          return HomeScreen.route(routeSettings);
        }
      case classScreen:
        {
          return ClassScreen.route(routeSettings);
        }
      case subject:
        {
          return SubjectScreen.route(routeSettings);
        }
      case assignments:
        {
          return AssignmentsScreen.route(routeSettings);
        }
      case assignment:
        {
          return CupertinoPageRoute(builder: (_) => AssignmentScreen());
        }
      case addAssignment:
        {
          return AddAssignmentScreen.Routes(routeSettings);
        }

      case takeAttendance:
        {
          return CupertinoPageRoute(builder: (_) => TakeAttendanceScreen());
        }
      case searchStudent:
        {
          return SearchStudentScreen.route(routeSettings);
        }
      case studentDetails:
        {
          return StudentDetailsScreen.route(routeSettings);
        }
      case result:
        {
          return CupertinoPageRoute(builder: (context) => const ResultScreen());
        }
      case addResult:
        {
          return CupertinoPageRoute(
              builder: (context) => const AddResultScreen());
        }
      case monthWiseAttendance:
        {
          return MonthWiseAttendanceScreen.route(routeSettings);
        }
      case announcements:
        {
          return AnnouncementsScreen.route(routeSettings);
        }
      case lessons:
        {
          return LessonsScreen.route(routeSettings);
        }
      case topics:
        {
          return TopicsScreen.route(routeSettings);
        }
      case addOrEditLesson:
        {
          return AddOrEditLessonScreen.route(routeSettings);
        }
      case addOrEditTopic:
        {
          return AddOrEditTopicScreen.route(routeSettings);
        }
      case aboutUs:
        {
          return AboutUsScreen.route(routeSettings);
        }
      case privacyPolicy:
        {
          return PrivacyPolicyScreen.route(routeSettings);
        }

      case contactUs:
        {
          return ContactUsScreen.route(routeSettings);
        }
      case termsAndCondition:
        {
          return TermsAndConditionScreen.route(routeSettings);
        }
      case addOrEditAnnouncement:
        {
          return AddOrEditAnnouncementScreen.route(routeSettings);
        }

      default:
        {
          return CupertinoPageRoute(builder: (context) => const Scaffold());
        }
    }
  }
}
