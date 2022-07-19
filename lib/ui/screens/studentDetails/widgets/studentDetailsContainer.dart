import 'package:eschool_teacher/data/models/student.dart';
import 'package:eschool_teacher/utils/labelKeys.dart';
import 'package:eschool_teacher/utils/uiUtils.dart';
import 'package:flutter/material.dart';

//TODO: address is not showing
//and fix the width of address key
class StudentDetailsContainer extends StatefulWidget {
  final Student student;
  const StudentDetailsContainer({Key? key, required this.student})
      : super(key: key);

  @override
  State<StudentDetailsContainer> createState() =>
      _StudentDetailsContainerState();
}

class _StudentDetailsContainerState extends State<StudentDetailsContainer> {
  final double _detailsInBetweenPadding = 8.5;

  TextStyle _getLabelValueTextStyle() {
    return TextStyle(
        color: Theme.of(context).colorScheme.secondary,
        fontSize: 14,
        fontWeight: FontWeight.w600);
  }

  TextStyle _getLabelTextStyle() {
    return TextStyle(
        color: Theme.of(context).colorScheme.onBackground,
        fontSize: 11,
        fontWeight: FontWeight.w400);
  }

  Widget _buildDetailBackgroundContainer(Widget child) {
    return Center(
      child: Container(
        margin: EdgeInsets.only(bottom: 20.0),
        width: MediaQuery.of(context).size.width,
        child: child,
        padding: EdgeInsets.symmetric(horizontal: 12.50, vertical: 15.0),
        decoration: BoxDecoration(
            color: Theme.of(context).colorScheme.background,
            borderRadius: BorderRadius.circular(10.0)),
      ),
    );
  }

  Widget _buildValueWithTitle(
      {required String title,
      required String value,
      required double titleWidthPercentage,
      required double width,
      required valueWidthPercentage}) {
    return Row(
      children: [
        SizedBox(
          width: width * titleWidthPercentage,
          child: Text(
            UiUtils.getTranslatedLabel(context, title),
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
            style: _getLabelTextStyle(),
          ),
        ),
        SizedBox(
          width: width * valueWidthPercentage,
          child: Text(
            ":  $value",
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
            style: _getLabelTextStyle(),
            textAlign: TextAlign.start,
          ),
        ),
      ],
    );
  }

  Widget _buildStudentInformationContainer() {
    return _buildDetailBackgroundContainer(Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        CircleAvatar(
          radius: 25,
          backgroundColor: Theme.of(context).colorScheme.primary,
        ),
        SizedBox(
          width: 10,
        ),
        Flexible(
          child: LayoutBuilder(builder: (context, boxConstraints) {
            final leftSideTitleWidthPercentage = 0.37;
            final rightSideTitleWidthPercentage = 0.5;
            final widthOfDetialsContainer = boxConstraints.maxWidth * (0.5);

            return Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  widget.student.getFullName(),
                  style: _getLabelValueTextStyle(),
                ),
                Row(
                  children: [
                    Column(
                      children: [
                        _buildValueWithTitle(
                            title: rollNoKey,
                            value: widget.student.rollNumber.toString(),
                            width: widthOfDetialsContainer,
                            titleWidthPercentage: leftSideTitleWidthPercentage,
                            valueWidthPercentage:
                                1.0 - leftSideTitleWidthPercentage),
                        _buildValueWithTitle(
                            title: classKey,
                            value: widget.student.classSectionName,
                            width: widthOfDetialsContainer,
                            titleWidthPercentage: leftSideTitleWidthPercentage,
                            valueWidthPercentage:
                                1.0 - leftSideTitleWidthPercentage),
                        _buildValueWithTitle(
                            width: widthOfDetialsContainer,
                            title: dobKey,
                            value: UiUtils.formattedDate(widget.student.dob),
                            titleWidthPercentage: leftSideTitleWidthPercentage,
                            valueWidthPercentage:
                                1.0 - leftSideTitleWidthPercentage),
                      ],
                    ),
                    Column(
                      children: [
                        _buildValueWithTitle(
                            title: genderKey,
                            value: widget.student.gender,
                            width: widthOfDetialsContainer,
                            titleWidthPercentage: rightSideTitleWidthPercentage,
                            valueWidthPercentage:
                                1.0 - rightSideTitleWidthPercentage),
                        _buildValueWithTitle(
                            title: bloodGrpKey,
                            value: widget.student.bloodGroup,
                            width: widthOfDetialsContainer,
                            titleWidthPercentage: rightSideTitleWidthPercentage,
                            valueWidthPercentage:
                                1.0 - rightSideTitleWidthPercentage),
                        _buildValueWithTitle(
                            title: grNoKey,
                            value: widget.student.admissionNo,
                            width: widthOfDetialsContainer,
                            titleWidthPercentage: rightSideTitleWidthPercentage,
                            valueWidthPercentage:
                                1.0 - rightSideTitleWidthPercentage),
                      ],
                    ),
                  ],
                ),
                Row(
                  children: [
                    SizedBox(
                      width: widthOfDetialsContainer *
                          leftSideTitleWidthPercentage,
                      child: Text(
                        UiUtils.getTranslatedLabel(context, addressKey),
                        style: _getLabelTextStyle(),
                      ),
                    ),
                    Text(
                      widget.student.currentAddress,
                      style: _getLabelTextStyle(),
                    )
                  ],
                ),
              ],
            );
          }),
        ),
      ],
    ));
  }

  Widget _buildGuardianDetailsContainer({required String guardianRole}) {
    return _buildDetailBackgroundContainer(
      Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          CircleAvatar(
            radius: 25,
            backgroundColor: Theme.of(context).colorScheme.primary,
          ),
          SizedBox(
            width: 10,
          ),
          Flexible(
            child: LayoutBuilder(builder: (context, boxConstraints) {
              final titleWidthPercentage = 0.28;
              return Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "Parent name",
                    style: _getLabelValueTextStyle(),
                  ),
                  Text(
                    guardianRole,
                    style: _getLabelTextStyle(),
                  ),
                  _buildValueWithTitle(
                      title: UiUtils.getTranslatedLabel(context, occupationKey),
                      value: "CEO",
                      titleWidthPercentage: titleWidthPercentage,
                      width: boxConstraints.maxWidth,
                      valueWidthPercentage: 1.0 - titleWidthPercentage),
                  _buildValueWithTitle(
                      title: UiUtils.getTranslatedLabel(context,
                          UiUtils.getTranslatedLabel(context, phoneKey)),
                      value: "1234567890",
                      titleWidthPercentage: titleWidthPercentage,
                      width: boxConstraints.maxWidth,
                      valueWidthPercentage: 1.0 - titleWidthPercentage),
                  _buildValueWithTitle(
                      title: UiUtils.getTranslatedLabel(context, emailKey),
                      value: "1234567890",
                      titleWidthPercentage: titleWidthPercentage,
                      width: boxConstraints.maxWidth,
                      valueWidthPercentage: 1.0 - titleWidthPercentage),
                  _buildValueWithTitle(
                      title: UiUtils.getTranslatedLabel(context,
                          UiUtils.getTranslatedLabel(context, addressKey)),
                      value: "1234567890",
                      titleWidthPercentage: titleWidthPercentage,
                      width: boxConstraints.maxWidth,
                      valueWidthPercentage: 1.0 - titleWidthPercentage),
                ],
              );
            }),
          ),
        ],
      ),
    );
  }

  Widget _buildAttendanceSummaryContainer() {
    return _buildDetailBackgroundContainer(
        LayoutBuilder(builder: (context, boxConstraints) {
      return Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Text(
                "Today's attendance",
                style: _getLabelValueTextStyle(),
              ),
              Padding(
                padding: EdgeInsets.symmetric(
                    horizontal: boxConstraints.maxWidth * (0.04)),
                child: CircleAvatar(
                  backgroundColor: Theme.of(context).colorScheme.primary,
                  radius: 3,
                ),
              ),
              Text(
                "Present",
                style: TextStyle(
                    color: Theme.of(context).colorScheme.onPrimary,
                    fontSize: 14,
                    fontWeight: FontWeight.w500),
              ),
            ],
          ),
          SizedBox(
            height: _detailsInBetweenPadding * (2),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Container(
                padding: EdgeInsets.symmetric(vertical: 4.0),
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    border: Border.all(
                      width: 2,
                      color: Theme.of(context).colorScheme.primary,
                    )),
                width: boxConstraints.maxWidth * (0.47),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text("Present", style: _getLabelTextStyle()),
                    Text("80", style: _getLabelValueTextStyle()),
                  ],
                ),
              ),
              Container(
                padding: EdgeInsets.symmetric(vertical: 4.0),
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    border: Border.all(
                      width: 2,
                      color: Theme.of(context).colorScheme.primary,
                    )),
                width: boxConstraints.maxWidth * (0.47),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text("Absent", style: _getLabelTextStyle()),
                    Text("80", style: _getLabelValueTextStyle()),
                  ],
                ),
              ),
            ],
          ),
        ],
      );
    }));
  }

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment.topCenter,
      child: SingleChildScrollView(
        child: Column(
          children: [
            //
            _buildStudentInformationContainer(),
            _buildGuardianDetailsContainer(
                guardianRole: UiUtils.getTranslatedLabel(context, fatherKey)),
            //_buildGuardianDetailsContainer(),
            _buildAttendanceSummaryContainer(),
          ],
        ),
        padding: EdgeInsets.only(
            left: MediaQuery.of(context).size.width * (0.075),
            right: MediaQuery.of(context).size.width * (0.075),
            top: UiUtils.getScrollViewTopPadding(
                context: context,
                appBarHeightPercentage: UiUtils.appBarSmallerHeightPercentage)),
      ),
    );
  }
}
