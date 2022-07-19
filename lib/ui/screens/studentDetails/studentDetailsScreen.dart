import 'package:eschool_teacher/ui/screens/studentDetails/widgets/studentDetailsContainer.dart';

import 'package:eschool_teacher/ui/widgets/customAppbar.dart';
import 'package:eschool_teacher/utils/labelKeys.dart';
import 'package:eschool_teacher/utils/uiUtils.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class StudentDetailsScreen extends StatefulWidget {
  StudentDetailsScreen({Key? key}) : super(key: key);

  @override
  State<StudentDetailsScreen> createState() => _StudentDetailsScreenState();

  static Route<StudentDetailsScreen> route(RouteSettings routeSettings) {
    return CupertinoPageRoute(builder: (_) => StudentDetailsScreen());
  }
}

class _StudentDetailsScreenState extends State<StudentDetailsScreen> {
  Widget _buildAppBar() {
    return Align(
      alignment: Alignment.topCenter,
      child: CustomAppBar(
          title: UiUtils.getTranslatedLabel(context, studentDetailsKey)),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          StudentDetailsContainer(),
          _buildAppBar(),
        ],
      ),
    );
  }
}
