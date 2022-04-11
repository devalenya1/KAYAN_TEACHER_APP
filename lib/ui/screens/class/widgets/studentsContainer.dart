import 'package:eschool_teacher/app/routes.dart';
import 'package:eschool_teacher/ui/styles/colors.dart';
import 'package:eschool_teacher/utils/labelKeys.dart';
import 'package:eschool_teacher/utils/uiUtils.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class StudentsContainer extends StatelessWidget {
  const StudentsContainer({Key? key}) : super(key: key);

  Widget _buildSerchBar(BuildContext context) {
    return InkWell(
      onTap: () {
        Navigator.of(context).pushNamed(Routes.searchStudent);
      },
      borderRadius: BorderRadius.circular(15),
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: 15),
        alignment: AlignmentDirectional.centerStart,
        child: Row(
          children: [
            Text(
              UiUtils.getTranslatedLabel(context, searchStudentKey),
              style: TextStyle(color: hintTextColor, fontSize: 14),
            ),
            Spacer(),
            Icon(
              CupertinoIcons.search,
              color: hintTextColor,
            )
          ],
        ),
        decoration: BoxDecoration(
            color: Theme.of(context).colorScheme.background,
            borderRadius: BorderRadius.circular(15),
            border: Border.all(
                color: Theme.of(context)
                    .colorScheme
                    .onBackground
                    .withOpacity(0.5))),
        width: MediaQuery.of(context).size.width,
        height: 45,
      ),
    );
  }

  Widget _buildStudentContainer(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 20),
      child: InkWell(
        borderRadius: BorderRadius.circular(10),
        onTap: () {
          Navigator.of(context).pushNamed(Routes.studentDetails);
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
          width: MediaQuery.of(context).size.width * (0.85),
          padding: EdgeInsets.symmetric(horizontal: 15, vertical: 12.5),
          child: LayoutBuilder(builder: (context, boxConstraints) {
            return Row(
              children: [
                Container(
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(7.5),
                      color: Theme.of(context).colorScheme.error),
                  height: 50,
                  width: boxConstraints.maxWidth * (0.2),
                ),
                SizedBox(
                  width: boxConstraints.maxWidth * (0.05),
                ),
                SizedBox(
                  width: boxConstraints.maxWidth * (0.65),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "Student name",
                        style: TextStyle(
                            color: Theme.of(context).colorScheme.secondary,
                            fontWeight: FontWeight.w600,
                            fontSize: 14.0),
                      ),
                      Text("Roll No - 18",
                          style: TextStyle(
                              color: Theme.of(context)
                                  .colorScheme
                                  .secondary
                                  .withOpacity(0.75),
                              fontWeight: FontWeight.w400,
                              fontSize: 10.0),
                          textAlign: TextAlign.left)
                    ],
                  ),
                ),
              ],
            );
          }),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      padding: EdgeInsets.only(
          left: MediaQuery.of(context).size.width * (0.075),
          right: MediaQuery.of(context).size.width * (0.075),
          top: UiUtils.getScrollViewTopPadding(
              context: context,
              appBarHeightPercentage: UiUtils.appBarBiggerHeightPercentage)),
      child: Column(
        children: [
          _buildSerchBar(context),
          SizedBox(
            height: 25,
          ),
          _buildStudentContainer(context)
        ],
      ),
    );
  }
}
