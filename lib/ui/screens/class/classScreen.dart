import 'package:eschool_teacher/app/routes.dart';
import 'package:eschool_teacher/ui/screens/class/widgets/studentsContainer.dart';
import 'package:eschool_teacher/ui/screens/class/widgets/subjectsContainer.dart';
import 'package:eschool_teacher/ui/widgets/customAppbar.dart';
import 'package:eschool_teacher/ui/widgets/customTabBarContainer.dart';
import 'package:eschool_teacher/ui/widgets/screenTopBackgroundContainer.dart';
import 'package:eschool_teacher/ui/widgets/svgButton.dart';
import 'package:eschool_teacher/ui/widgets/tabBarBackgroundContainer.dart';
import 'package:eschool_teacher/utils/labelKeys.dart';
import 'package:eschool_teacher/utils/uiUtils.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/parser.dart';
import 'package:flutter_svg/svg.dart';

class ClassScreen extends StatefulWidget {
  final bool isClassTeacher;
  ClassScreen({Key? key, required this.isClassTeacher}) : super(key: key);

  @override
  State<ClassScreen> createState() => _ClassScreenState();

  static Route<ClassScreen> route(RouteSettings routeSettings) {
    return CupertinoPageRoute(
        builder: (_) => ClassScreen(
              isClassTeacher: routeSettings.arguments as bool,
            ));
  }
}

class _ClassScreenState extends State<ClassScreen> {
  late String _selectedTabTitle = subjectsKey;
  Widget _buildAppbar() {
    return widget.isClassTeacher
        ? Align(
            alignment: Alignment.topCenter,
            child: ScreenTopBackgroundContainer(
              child: LayoutBuilder(builder: (context, boxConstraints) {
                return Stack(
                  children: [
                    Align(
                      alignment: AlignmentDirectional.topStart,
                      child: Padding(
                        child: SvgButton(
                            onTap: () {
                              Navigator.of(context).pop();
                            },
                            svgIconUrl: UiUtils.getImagePath("back_icon.svg")),
                        padding: EdgeInsets.only(
                            left: UiUtils.screenContentHorizontalPadding),
                      ),
                    ),
                    Align(
                      alignment: Alignment.topCenter,
                      child: Text(
                        "${UiUtils.getTranslatedLabel(context, classKey)} 10 - A",
                        style: TextStyle(
                            color: Theme.of(context).scaffoldBackgroundColor,
                            fontSize: UiUtils.screenTitleFontSize),
                      ),
                    ),
                    AnimatedAlign(
                      curve: UiUtils.tabBackgroundContainerAnimationCurve,
                      duration: UiUtils.tabBackgroundContainerAnimationDuration,
                      alignment: _selectedTabTitle == subjectsKey
                          ? AlignmentDirectional.centerStart
                          : AlignmentDirectional.centerEnd,
                      child: TabBackgroundContainer(
                          boxConstraints: boxConstraints),
                    ),
                    CustomTabBarContainer(
                        boxConstraints: boxConstraints,
                        alignment: AlignmentDirectional.centerStart,
                        isSelected: _selectedTabTitle == subjectsKey,
                        onTap: () {
                          setState(() {
                            _selectedTabTitle = subjectsKey;
                          });
                        },
                        titleKey: subjectsKey),
                    CustomTabBarContainer(
                        boxConstraints: boxConstraints,
                        alignment: AlignmentDirectional.centerEnd,
                        isSelected: _selectedTabTitle == studentsKey,
                        onTap: () {
                          setState(() {
                            _selectedTabTitle = studentsKey;
                          });
                        },
                        titleKey: studentsKey)
                  ],
                );
              }),
            ),
          )
        : Align(
            alignment: Alignment.topCenter,
            child: CustomAppBar(
                subTitle: UiUtils.getTranslatedLabel(context, subjectsKey),
                title:
                    "${UiUtils.getTranslatedLabel(context, classKey)} 10 - A"),
          );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: widget.isClassTeacher
          ? FloatingActionButton(
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: SvgPicture.asset(
                  UiUtils.getImagePath("take_attendance.svg"),
                  color: Theme.of(context).scaffoldBackgroundColor,
                ),
              ),
              onPressed: () {
                Navigator.of(context).pushNamed(Routes.takeAttendance);
              },
              backgroundColor: Theme.of(context).colorScheme.primary,
            )
          : SizedBox(),
      body: Stack(
        children: [
          Align(
            alignment: Alignment.topCenter,
            child: widget.isClassTeacher
                ? _selectedTabTitle == subjectsKey
                    ? SubjectsContainer(
                        topPadding: UiUtils.getScrollViewTopPadding(
                            context: context,
                            appBarHeightPercentage:
                                UiUtils.appBarBiggerHeightPercentage))
                    : StudentsContainer()
                : SubjectsContainer(
                    topPadding: UiUtils.getScrollViewTopPadding(
                        context: context,
                        appBarHeightPercentage:
                            UiUtils.appBarSmallerHeightPercentage)),
          ),
          _buildAppbar(),
        ],
      ),
    );
  }
}
