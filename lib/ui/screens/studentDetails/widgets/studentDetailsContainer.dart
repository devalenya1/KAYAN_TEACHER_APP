import 'package:eschool_teacher/app/routes.dart';
import 'package:eschool_teacher/utils/uiUtils.dart';
import 'package:flutter/material.dart';

class StudentDetailsContainer extends StatelessWidget {
  const StudentDetailsContainer({Key? key}) : super(key: key);

  final double _detailsInBetweenPadding = 8.5;

  TextStyle _getLabelValueTextStyle(BuildContext context) {
    return TextStyle(
        color: Theme.of(context).colorScheme.secondary,
        fontSize: 14,
        fontWeight: FontWeight.w600);
  }

  TextStyle _getLabelTextStyle(BuildContext context) {
    return TextStyle(
        color: Theme.of(context).colorScheme.onBackground,
        fontSize: 11,
        fontWeight: FontWeight.w400);
  }

  Widget _buildDetailBackgroundContainer(Widget child, BuildContext context) {
    return Center(
      child: Container(
        margin: EdgeInsets.only(bottom: 20.0),
        width: MediaQuery.of(context).size.width,
        child: child,
        padding: EdgeInsets.symmetric(horizontal: 20.0, vertical: 15.0),
        decoration: BoxDecoration(
            color: Theme.of(context).colorScheme.background,
            borderRadius: BorderRadius.circular(10.0)),
      ),
    );
  }

  Widget _buildStudentInformationContainer(BuildContext context) {
    return _buildDetailBackgroundContainer(
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            LayoutBuilder(builder: (context, boxConstraints) {
              return Row(
                children: [
                  CircleAvatar(
                    radius: 25,
                    backgroundColor: Theme.of(context).colorScheme.primary,
                  ),
                  SizedBox(
                    width: boxConstraints.maxWidth * (0.05),
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "Virati Kohli",
                        style: _getLabelValueTextStyle(context),
                      ),
                      Text(
                        "Class 10 - A",
                        style: _getLabelTextStyle(context),
                      ),
                      Text(
                        "01-01-1990",
                        style: _getLabelTextStyle(context),
                      ),
                    ],
                  ),
                ],
              );
            }),
            SizedBox(
              height: _detailsInBetweenPadding,
            ),
            Padding(
              padding: const EdgeInsets.only(left: 10),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "Full address",
                    style: _getLabelTextStyle(context),
                  ),
                  Text(
                    "GR-1234",
                    style: _getLabelTextStyle(context),
                  ),
                ],
              ),
            ),
          ],
        ),
        context);
  }

  Widget _buildGuardianDetailsContainer(BuildContext context) {
    return _buildDetailBackgroundContainer(
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            LayoutBuilder(builder: (context, boxConstraints) {
              return Row(
                children: [
                  CircleAvatar(
                    radius: 25,
                    backgroundColor: Theme.of(context).colorScheme.primary,
                  ),
                  SizedBox(
                    width: boxConstraints.maxWidth * (0.05),
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "Virat Kohli",
                        style: _getLabelValueTextStyle(context),
                      ),
                      Text(
                        "Father",
                        style: _getLabelTextStyle(context),
                      ),
                      Text(
                        "+91 1234567890",
                        style: _getLabelTextStyle(context),
                      ),
                    ],
                  ),
                ],
              );
            }),
            SizedBox(
              height: _detailsInBetweenPadding,
            ),
            Padding(
              padding: const EdgeInsets.only(left: 10),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "Full address",
                    style: _getLabelTextStyle(context),
                  ),
                  Text(
                    "Cricketer",
                    style: _getLabelTextStyle(context),
                  ),
                ],
              ),
            ),
          ],
        ),
        context);
  }

  Widget _buildAttendanceSummaryContainer(BuildContext context) {
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
                style: _getLabelValueTextStyle(context),
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
                    Text("Present", style: _getLabelTextStyle(context)),
                    Text("80", style: _getLabelValueTextStyle(context)),
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
                    Text("Absent", style: _getLabelTextStyle(context)),
                    Text("80", style: _getLabelValueTextStyle(context)),
                  ],
                ),
              ),
            ],
          ),
          SizedBox(
            height: _detailsInBetweenPadding,
          ),
          Center(
            child: TextButton(
                onPressed: () {
                  Navigator.of(context).pushNamed(Routes.monthWiseAttendance);
                },
                child: Text("View month-wise attendance")),
          )
        ],
      );
    }), context);
  }

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment.topCenter,
      child: SingleChildScrollView(
        child: Column(
          children: [
            //
            _buildStudentInformationContainer(context),
            _buildGuardianDetailsContainer(context),
            _buildGuardianDetailsContainer(context),
            _buildAttendanceSummaryContainer(context),
          ],
        ),
        padding: EdgeInsets.only(
            left: MediaQuery.of(context).size.width * (0.075),
            right: MediaQuery.of(context).size.width * (0.075),
            top: UiUtils.getScrollViewTopPadding(
                context: context,
                appBarHeightPercentage: UiUtils.appBarBiggerHeightPercentage)),
      ),
    );
  }
}
