import 'package:eschool_teacher/app/routes.dart';
import 'package:eschool_teacher/ui/widgets/customAppbar.dart';
import 'package:eschool_teacher/ui/widgets/customFloatingActionButton.dart';
import 'package:eschool_teacher/utils/labelKeys.dart';
import 'package:eschool_teacher/utils/uiUtils.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class LessonsScreen extends StatefulWidget {
  const LessonsScreen({Key? key}) : super(key: key);

  static Route<dynamic> route(RouteSettings routeSettings) {
    return CupertinoPageRoute(builder: (_) => const LessonsScreen());
  }

  @override
  State<LessonsScreen> createState() => _LessonsScreenState();
}

class _LessonsScreenState extends State<LessonsScreen> {
  Widget _buildAppbar() {
    return Align(
      alignment: Alignment.topCenter,
      child:
          CustomAppBar(title: UiUtils.getTranslatedLabel(context, lessonsKey)),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        floatingActionButton: FloatingActionAddButton(onTap: () {
          Navigator.of(context).pushNamed(Routes.addLesson);
        }),
        body: Stack(
          children: [_buildAppbar()],
        ));
  }
}
