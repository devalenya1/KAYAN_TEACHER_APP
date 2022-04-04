import 'package:eschool_teacher/app/routes.dart';
import 'package:flutter/material.dart';

class SubjectsContainer extends StatelessWidget {
  final double topPadding;
  const SubjectsContainer({Key? key, required this.topPadding})
      : super(key: key);

  Widget _buildSubjectContainer(
      {required String subjectName, required BuildContext context}) {
    return Padding(
      padding: EdgeInsets.only(bottom: 20),
      child: InkWell(
        borderRadius: BorderRadius.circular(10),
        onTap: () {
          Navigator.of(context).pushNamed(Routes.subject);
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

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      padding: EdgeInsets.only(
        top: topPadding,
      ),
      child: Column(
        children: [
          _buildSubjectContainer(subjectName: "Maths", context: context),
          _buildSubjectContainer(
              subjectName: "Socia Science & Technology", context: context),
          _buildSubjectContainer(subjectName: "English", context: context),
        ],
      ),
    );
  }
}
