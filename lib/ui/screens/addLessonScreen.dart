import 'package:eschool_teacher/cubits/myClassesCubit.dart';
import 'package:eschool_teacher/cubits/subjectsOfClassSectionCubit.dart';
import 'package:eschool_teacher/data/repositories/teacherRepository.dart';
import 'package:eschool_teacher/ui/widgets/classSubjectsDropDownMenu.dart';
import 'package:eschool_teacher/ui/widgets/customAppbar.dart';
import 'package:eschool_teacher/ui/widgets/customDropDownMenu.dart';
import 'package:eschool_teacher/ui/widgets/myClassesDropDownMenu.dart';
import 'package:eschool_teacher/utils/labelKeys.dart';
import 'package:eschool_teacher/utils/uiUtils.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class AddLessonScreen extends StatefulWidget {
  AddLessonScreen({Key? key}) : super(key: key);

  static Route<dynamic> route(RouteSettings routeSettings) {
    return CupertinoPageRoute(
        builder: (_) => BlocProvider(
              create: (context) =>
                  SubjectsOfClassSectionCubit(TeacherRepository()),
              child: AddLessonScreen(),
            ));
  }

  @override
  State<AddLessonScreen> createState() => _AddLessonScreenState();
}

class _AddLessonScreenState extends State<AddLessonScreen> {
  late String currentSelectedClassSection =
      context.read<MyClassesCubit>().getClassSectionName().first;

  late String currentSelectedSubject =
      UiUtils.getTranslatedLabel(context, selectSubjectKey);

  Widget _buildAppbar() {
    return Align(
      alignment: Alignment.topCenter,
      child: CustomAppBar(
          title: UiUtils.getTranslatedLabel(context, addLessonKey)),
    );
  }

  Widget _buildAddLessonForm() {
    return SingleChildScrollView(
      padding: EdgeInsets.only(
          right: UiUtils.screenContentHorizontalPaddingPercentage *
              MediaQuery.of(context).size.width,
          left: UiUtils.screenContentHorizontalPaddingPercentage *
              MediaQuery.of(context).size.width,
          top: UiUtils.getScrollViewTopPadding(
              context: context,
              appBarHeightPercentage: UiUtils.appBarSmallerHeightPercentage)),
      child: LayoutBuilder(builder: (context, boxConstraints) {
        return Column(
          children: [
            MyClassesDropDownMenu(
                currentSelectedItem: currentSelectedClassSection,
                width: boxConstraints.maxWidth,
                changeSelectedItem: (result) {
                  setState(() {
                    currentSelectedClassSection = result;
                  });
                }),
            ClassSubjectsDropDownMenu(
                changeSelectedItem: (result) {
                  setState(() {
                    currentSelectedSubject = result;
                  });
                },
                currentSelectedItem: currentSelectedSubject,
                width: boxConstraints.maxWidth),
          ],
        );
      }),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Stack(
      children: [
        _buildAddLessonForm(),
        _buildAppbar(),
      ],
    ));
  }
}
