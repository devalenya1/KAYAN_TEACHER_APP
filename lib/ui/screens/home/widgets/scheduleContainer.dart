import 'package:eschool_teacher/ui/widgets/screenTopBackgroundContainer.dart';
import 'package:eschool_teacher/utils/labelKeys.dart';
import 'package:eschool_teacher/utils/uiUtils.dart';
import 'package:flutter/material.dart';

class ScheduleContainer extends StatefulWidget {
  ScheduleContainer({Key? key}) : super(key: key);

  @override
  State<ScheduleContainer> createState() => _ScheduleContainerState();
}

class _ScheduleContainerState extends State<ScheduleContainer> {
  final List<String> days = ["Sun", "Mon", "Tue", "Wed", "Thu", "Fri", "Sat"];

  late int _currentSelectedDayIndex = DateTime.now().weekday;

  Widget _buildAppBar() {
    return ScreenTopBackgroundContainer(
      heightPercentage: UiUtils.appBarSmallerHeightPercentage,
      padding: EdgeInsets.all(0),
      child: Stack(
        clipBehavior: Clip.none,
        children: [
          Align(
            alignment: Alignment.center,
            child: Text(
              UiUtils.getTranslatedLabel(context, scheduleKey),
              style: TextStyle(
                  color: Theme.of(context).scaffoldBackgroundColor,
                  fontSize: UiUtils.screenTitleFontSize),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildDayContainer(int index) {
    return InkWell(
      onTap: () {
        setState(() {
          _currentSelectedDayIndex = index;
        });
      },
      borderRadius: BorderRadius.circular(5.0),
      child: Container(
        alignment: Alignment.center,
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(5.0),
            color: index == _currentSelectedDayIndex
                ? Theme.of(context).colorScheme.primary
                : Colors.transparent),
        padding: const EdgeInsets.all(7.5),
        child: Text(
          days[index],
          style: TextStyle(
              fontSize: 13.0,
              fontWeight: FontWeight.w600,
              color: index == _currentSelectedDayIndex
                  ? Theme.of(context).scaffoldBackgroundColor
                  : Theme.of(context).colorScheme.primary),
        ),
      ),
    );
  }

  Widget _buildDays() {
    final List<Widget> children = [];

    for (var i = 0; i < days.length; i++) {
      children.add(_buildDayContainer(i));
    }

    return SizedBox(
      width: MediaQuery.of(context).size.width * (0.85),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: children,
      ),
    );
  }

  Widget _buildTimeTableSlotDetainsContainer(
      {required String subjectIconUrl,
      required String subjectName,
      required String classDivisionName,
      required String timeslot}) {
    return Container(
      clipBehavior: Clip.none,
      margin: EdgeInsets.only(bottom: 20),
      decoration: BoxDecoration(
          boxShadow: [
            BoxShadow(
                color:
                    Theme.of(context).colorScheme.secondary.withOpacity(0.05),
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
            SizedBox(
              width: boxConstraints.maxWidth * (0.75),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Text(
                        timeslot,
                        style: TextStyle(
                            color: Theme.of(context).colorScheme.secondary,
                            fontWeight: FontWeight.w600,
                            fontSize: 14.0),
                      ),
                      Spacer(),
                      Text(
                        classDivisionName,
                        style: TextStyle(
                            color: Theme.of(context).colorScheme.onBackground,
                            fontWeight: FontWeight.w400,
                            fontSize: 12.0),
                      ),
                    ],
                  ),
                  SizedBox(
                    height: 5,
                  ),
                  Text(
                    "$subjectName",
                    style: TextStyle(
                        color: Theme.of(context).colorScheme.onBackground,
                        fontWeight: FontWeight.w400,
                        fontFamily: "Poppins",
                        fontSize: 12.0),
                  )
                ],
              ),
            ),
          ],
        );
      }),
    );
  }

  Widget _buildTimeTable() {
    //TODO : Also make changes in e-school app time-table
    return SizedBox(
      width: MediaQuery.of(context).size.width,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          _buildTimeTableSlotDetainsContainer(
              subjectIconUrl: "",
              subjectName: "Hindi",
              classDivisionName: "Class 10 - A",
              timeslot: "08 - 09 AM"),
          _buildTimeTableSlotDetainsContainer(
            subjectIconUrl: "",
            subjectName: "Hindi",
            timeslot: "08 - 09 AM",
            classDivisionName: "Class 10 - A",
          ),
          _buildTimeTableSlotDetainsContainer(
            subjectIconUrl: "",
            subjectName: "Hindi",
            timeslot: "08 - 09 AM",
            classDivisionName: "Class 10 - A",
          ),
          _buildTimeTableSlotDetainsContainer(
            subjectIconUrl: "",
            subjectName: "Hindi",
            timeslot: "08 - 09 AM",
            classDivisionName: "Class 10 - A",
          ),
          _buildTimeTableSlotDetainsContainer(
            subjectIconUrl: "",
            subjectName: "Hindi",
            timeslot: "08 - 09 AM",
            classDivisionName: "Class 10 - A",
          ),
          _buildTimeTableSlotDetainsContainer(
            subjectIconUrl: "",
            subjectName: "Hindi",
            timeslot: "08 - 09 AM",
            classDivisionName: "Class 10 - A",
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Align(
          alignment: Alignment.topCenter,
          child: SingleChildScrollView(
            padding: EdgeInsets.only(
                bottom: UiUtils.getScrollViewBottomPadding(context),
                top: UiUtils.getScrollViewTopPadding(
                    context: context,
                    appBarHeightPercentage:
                        UiUtils.appBarSmallerHeightPercentage)),
            child: Column(
              children: [
                _buildDays(),
                SizedBox(
                  height: MediaQuery.of(context).size.height * (0.025),
                ),
                _buildTimeTable(),
              ],
            ),
          ),
        ),
        Align(
          alignment: Alignment.topCenter,
          child: _buildAppBar(),
        ),
      ],
    );
  }
}
