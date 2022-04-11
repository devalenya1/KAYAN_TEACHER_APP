import 'package:eschool_teacher/ui/screens/monthWiseAttendance/cubits/calendarMonthCubit.dart';
import 'package:eschool_teacher/ui/widgets/appBarSubTitleContainer.dart';
import 'package:eschool_teacher/ui/widgets/appBarTitleContainer.dart';
import 'package:eschool_teacher/ui/widgets/screenTopBackgroundContainer.dart';
import 'package:eschool_teacher/ui/widgets/svgButton.dart';
import 'package:eschool_teacher/utils/labelKeys.dart';
import 'package:eschool_teacher/utils/uiUtils.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:table_calendar/table_calendar.dart';

class MonthWiseAttendanceScreen extends StatefulWidget {
  const MonthWiseAttendanceScreen({Key? key}) : super(key: key);

  @override
  State<MonthWiseAttendanceScreen> createState() =>
      _MonthWiseAttendanceScreenState();

  static Route<MonthWiseAttendanceScreen> route(RouteSettings routeSettings) {
    return CupertinoPageRoute(
        builder: (_) => BlocProvider(
              create: (_) => CalendarMonthCubit(),
              child: MonthWiseAttendanceScreen(),
            ));
  }
}

class _MonthWiseAttendanceScreenState extends State<MonthWiseAttendanceScreen> {
  late DateTime firstDay =
      DateTime.utc(DateTime.now().year - 1, DateTime.june, 1);
  late DateTime lastDay = DateTime.utc(DateTime.now().year, DateTime.may, 30);

  PageController? calendarPageController;

  void changeMonthInCalendarListener() {
    //currentSelectedMonthIndex = calendarPageController!.page!.toInt();
    context
        .read<CalendarMonthCubit>()
        .updateMonthIndex(calendarPageController!.page!.toInt());
  }

  Widget _buildAttendanceCounterContainer(
      {required String title,
      required String value,
      required Color backgroundColor}) {
    return Container(
      height: 140,
      width: 140,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Text(
            title,
            style: TextStyle(
                color: Theme.of(context).scaffoldBackgroundColor,
                fontWeight: FontWeight.w600),
          ),
          SizedBox(
            height: 20.0,
          ),
          CircleAvatar(
            radius: 25,
            backgroundColor: Theme.of(context).scaffoldBackgroundColor,
            child: Center(
                child: Text(
              value,
              style: TextStyle(
                  color: backgroundColor, fontWeight: FontWeight.w600),
            )),
          ),
        ],
      ),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10),
        color: backgroundColor,
        boxShadow: [
          BoxShadow(
              color: backgroundColor.withOpacity(0.25),
              offset: Offset(5, 5),
              blurRadius: 10,
              spreadRadius: 0)
        ],
      ),
    );
  }

  Widget _buildAppBar() {
    return ScreenTopBackgroundContainer(
      heightPercentage: UiUtils.appBarMediumtHeightPercentage,
      child: LayoutBuilder(builder: (context, boxConstraints) {
        return Stack(
          clipBehavior: Clip.none,
          children: [
            Align(
              alignment: AlignmentDirectional.topStart,
              child: Padding(
                padding: EdgeInsets.only(
                    left: UiUtils.screenContentHorizontalPadding),
                child: SvgButton(
                    onTap: () {
                      Navigator.of(context).pop();
                    },
                    svgIconUrl: UiUtils.getImagePath("back_icon.svg")),
              ),
            ),
            AppBarTitleContainer(
                boxConstraints: boxConstraints, title: "Student name"),
            AppBarSubTitleContainer(
                boxConstraints: boxConstraints,
                topPaddingPercentage: 0.1,
                subTitle: UiUtils.getTranslatedLabel(context, attendanceKey)),
            Positioned(
                bottom: -20,
                left: MediaQuery.of(context).size.width * (0.075),
                child: Container(
                  child: Stack(
                    children: [
                      BlocBuilder<CalendarMonthCubit, CalendarMonthState>(
                        builder: (context, state) {
                          return Align(
                            alignment: Alignment.center,
                            child: Text(
                              UiUtils.buildMonthYearsBetweenTwoDates(
                                  firstDay, lastDay)[state.monthIndex],
                              style: TextStyle(
                                  color:
                                      Theme.of(context).colorScheme.secondary,
                                  fontWeight: FontWeight.w600),
                            ),
                          );
                        },
                      ),
                      Align(
                        alignment: Alignment.centerLeft,
                        child: InkWell(
                          borderRadius: BorderRadius.circular(7.5),
                          onTap: () {
                            calendarPageController?.previousPage(
                                duration: Duration(milliseconds: 400),
                                curve: Curves.easeInOut);
                          },
                          child: Container(
                            child: Icon(
                              Icons.chevron_left,
                              size: 26,
                              color: Theme.of(context).scaffoldBackgroundColor,
                            ),
                            margin: EdgeInsets.only(left: 15.0),
                            width: 30.0,
                            height: 30.0,
                            decoration: BoxDecoration(
                                color: Theme.of(context).colorScheme.primary,
                                borderRadius: BorderRadius.circular(7.5)),
                          ),
                        ),
                      ),
                      Align(
                        alignment: Alignment.centerRight,
                        child: InkWell(
                          onTap: () {
                            calendarPageController?.nextPage(
                                duration: Duration(milliseconds: 400),
                                curve: Curves.easeInOut);
                          },
                          borderRadius: BorderRadius.circular(7.5),
                          child: Container(
                            child: Icon(
                              Icons.chevron_right,
                              size: 26,
                              color: Theme.of(context).scaffoldBackgroundColor,
                            ),
                            margin: EdgeInsets.only(right: 15.0),
                            width: 30.0,
                            height: 30.0,
                            decoration: BoxDecoration(
                                color: Theme.of(context).colorScheme.primary,
                                borderRadius: BorderRadius.circular(7.5)),
                          ),
                        ),
                      ),
                    ],
                  ),
                  height: 50,
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                      boxShadow: [
                        BoxShadow(
                            color: Theme.of(context)
                                .colorScheme
                                .secondary
                                .withOpacity(0.075),
                            offset: Offset(2.5, 2.5),
                            blurRadius: 5,
                            spreadRadius: 0)
                      ],
                      color: Theme.of(context).scaffoldBackgroundColor),
                  width: MediaQuery.of(context).size.width * (0.85),
                )),
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
          SingleChildScrollView(
              padding: EdgeInsets.only(
                  bottom: UiUtils.getScrollViewBottomPadding(context),
                  top: UiUtils.getScrollViewTopPadding(
                      context: context,
                      appBarHeightPercentage:
                          UiUtils.appBarMediumtHeightPercentage)),
              child: Column(
                children: [
                  SizedBox(
                    height: MediaQuery.of(context).size.height * (0.025),
                  ),
                  Container(
                    padding: EdgeInsets.all(5),
                    decoration: BoxDecoration(
                        color: Theme.of(context).scaffoldBackgroundColor,
                        boxShadow: [
                          BoxShadow(
                              color: Theme.of(context)
                                  .colorScheme
                                  .secondary
                                  .withOpacity(0.075),
                              offset: Offset(5.0, 5),
                              blurRadius: 10,
                              spreadRadius: 0)
                        ],
                        borderRadius: BorderRadius.circular(15.0)),
                    margin: EdgeInsets.symmetric(
                        horizontal:
                            MediaQuery.of(context).size.width * (0.075)),
                    child: TableCalendar(
                      calendarFormat: CalendarFormat.month,
                      headerVisible: false,
                      daysOfWeekHeight: 40,

                      //selected date will be in use to mark absent dates
                      // selectedDayPredicate: (dateTime) {
                      //   return dateTime.day < 10 && dateTime.month == DateTime.now().month;
                      // },
                      onCalendarCreated: (contoller) {
                        calendarPageController = contoller;
                        calendarPageController
                            ?.addListener(changeMonthInCalendarListener);

                        Future.delayed(Duration.zero, () {
                          context.read<CalendarMonthCubit>().updateMonthIndex(
                              calendarPageController!.initialPage);
                        });
                      },

                      //holiday date will be in use to make present dates
                      // holidayPredicate: (dateTime) {
                      //   return (dateTime.day > 10 &&
                      //           dateTime.month == DateTime.now().month) &&
                      //       (dateTime.day < 15 && dateTime.month == DateTime.now().month);
                      // },
                      calendarStyle: CalendarStyle(
                          holidayTextStyle: TextStyle(
                              color: Theme.of(context).scaffoldBackgroundColor),
                          holidayDecoration: BoxDecoration(
                              shape: BoxShape.circle,
                              color: Theme.of(context).colorScheme.onPrimary),
                          selectedDecoration: BoxDecoration(
                              shape: BoxShape.circle,
                              color: Theme.of(context).colorScheme.error),
                          todayDecoration: BoxDecoration(
                              shape: BoxShape.circle,
                              color: Theme.of(context).colorScheme.primary)),
                      daysOfWeekStyle: DaysOfWeekStyle(
                          weekendStyle: TextStyle(
                              color: Theme.of(context).colorScheme.primary,
                              fontWeight: FontWeight.bold),
                          weekdayStyle: TextStyle(
                              color: Theme.of(context).colorScheme.primary,
                              fontWeight: FontWeight.bold)),
                      headerStyle: HeaderStyle(
                          titleCentered: true, formatButtonVisible: false),
                      firstDay: firstDay, //start education year
                      lastDay: lastDay, //end education year
                      focusedDay: DateTime.now(),
                    ),
                  ),
                  SizedBox(
                    height: MediaQuery.of(context).size.height * (0.05),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      _buildAttendanceCounterContainer(
                          title: UiUtils.getTranslatedLabel(
                              context, totalPresentKey), //
                          value: "20",
                          backgroundColor:
                              Theme.of(context).colorScheme.onPrimary),
                      SizedBox(
                        width: 40,
                      ),
                      _buildAttendanceCounterContainer(
                          title: UiUtils.getTranslatedLabel(
                              context, totalAbsentKey), //
                          value: "20",
                          backgroundColor: Theme.of(context).colorScheme.error),
                    ],
                  ),
                ],
              )),
          _buildAppBar(),
        ],
      ),
    );
  }
}
