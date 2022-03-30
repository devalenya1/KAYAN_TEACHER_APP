import 'package:eschool_teacher/app/routes.dart';
import 'package:eschool_teacher/ui/widgets/customAppbar.dart';
import 'package:eschool_teacher/utils/labelKeys.dart';
import 'package:eschool_teacher/utils/uiUtils.dart';
import 'package:flutter/material.dart';

class ClassScreen extends StatefulWidget {
  ClassScreen({Key? key}) : super(key: key);

  @override
  State<ClassScreen> createState() => _ClassScreenState();
}

class _ClassScreenState extends State<ClassScreen> {
  Widget _buildAppbar() {
    return Align(
      alignment: Alignment.topCenter,
      child: CustomAppBar(
          subTitle: "Subjects",
          title: "${UiUtils.getTranslatedLabel(context, classKey)} 10 - A"),
    );
  }

  Widget _buildSubjectContainer({required String subjectName}) {
    return Padding(
      padding: EdgeInsets.only(bottom: 20),
      child: InkWell(
        borderRadius: BorderRadius.circular(10),
        onTap: () {
          Navigator.of(context).pushNamed(Routes.subjectScreen);
        },
        child: Container(
          clipBehavior: Clip.none,
          decoration: BoxDecoration(
              boxShadow: [
                BoxShadow(
                    color: Theme.of(context)
                        .colorScheme
                        .secondary
                        .withOpacity(0.05),
                    offset: Offset(2.5, 2.5),
                    blurRadius: 10,
                    spreadRadius: 0)
              ],
              color: Theme.of(context).scaffoldBackgroundColor,
              borderRadius: BorderRadius.circular(10)),
          height: 80,
          width: MediaQuery.of(context).size.width * (0.85),
          padding: EdgeInsets.symmetric(horizontal: 12.5, vertical: 10.0),
          child: LayoutBuilder(builder: (context, boxConstraints) {
            return Row(
              children: [
                Container(
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(7.5),
                      color: Theme.of(context).colorScheme.error),
                  height: 60,
                  width: boxConstraints.maxWidth * (0.2),
                ),
                SizedBox(
                  width: boxConstraints.maxWidth * (0.05),
                ),
                Text(
                  subjectName,
                  style: TextStyle(
                      color: Theme.of(context).colorScheme.secondary,
                      fontWeight: FontWeight.w600,
                      fontSize: 14.0),
                )
              ],
            );
          }),
        ),
      ),
    );
  }

  Widget _buildSubjects() {
    return Align(
      alignment: Alignment.topCenter,
      child: SingleChildScrollView(
        padding: EdgeInsets.only(
            top: UiUtils.getScrollViewTopPadding(
                context: context,
                appBarHeightPercentage: UiUtils.appBarSmallerHeightPercentage)),
        child: Column(
          children: [
            _buildSubjectContainer(subjectName: "Maths"),
            _buildSubjectContainer(subjectName: "Socia Science & Technology"),
            _buildSubjectContainer(subjectName: "English"),
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          _buildSubjects(),
          _buildAppbar(),
        ],
      ),
    );
  }
}
