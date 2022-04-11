import 'package:eschool_teacher/ui/screens/studentDetails/widgets/studentDetailsContainer.dart';
import 'package:eschool_teacher/ui/widgets/customTabBarContainer.dart';
import 'package:eschool_teacher/ui/widgets/screenTopBackgroundContainer.dart';
import 'package:eschool_teacher/ui/widgets/svgButton.dart';
import 'package:eschool_teacher/ui/widgets/tabBarBackgroundContainer.dart';
import 'package:eschool_teacher/utils/labelKeys.dart';
import 'package:eschool_teacher/utils/uiUtils.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class StudentDetailsScreen extends StatefulWidget {
  StudentDetailsScreen({Key? key}) : super(key: key);

  @override
  State<StudentDetailsScreen> createState() => _StudentDetailsScreenState();

  static Route<StudentDetailsScreen> route(RouteSettings routeSettings) {
    return CupertinoPageRoute(builder: (_) => StudentDetailsScreen());
  }
}

class _StudentDetailsScreenState extends State<StudentDetailsScreen> {
  String _selectedTabTitle = detailsKey;

  Widget _buildAppBar() {
    return Align(
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

              //TODO: Add width check for title
              Align(
                alignment: Alignment.topCenter,
                child: Container(
                  width: boxConstraints.maxWidth * (0.6),
                  child: Text(
                    "Student name",
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    textAlign: TextAlign.center,
                    style: TextStyle(
                        color: Theme.of(context).scaffoldBackgroundColor,
                        fontSize: UiUtils.screenTitleFontSize),
                  ),
                ),
              ),

              Align(
                alignment: Alignment.topCenter,
                child: Padding(
                  padding: EdgeInsets.only(
                      top: boxConstraints.maxHeight * (0.08) +
                          UiUtils.screenTitleFontSize),
                  child: Text(
                    "Roll No - 1",
                    style: TextStyle(
                        fontSize: UiUtils.screenSubTitleFontSize,
                        color: Theme.of(context).scaffoldBackgroundColor),
                  ),
                ),
              ),
              AnimatedAlign(
                curve: UiUtils.tabBackgroundContainerAnimationCurve,
                duration: UiUtils.tabBackgroundContainerAnimationDuration,
                alignment: _selectedTabTitle == detailsKey
                    ? AlignmentDirectional.centerStart
                    : AlignmentDirectional.centerEnd,
                child: TabBackgroundContainer(boxConstraints: boxConstraints),
              ),
              CustomTabBarContainer(
                  boxConstraints: boxConstraints,
                  alignment: AlignmentDirectional.centerStart,
                  isSelected: _selectedTabTitle == detailsKey,
                  onTap: () {
                    setState(() {
                      _selectedTabTitle = detailsKey;
                    });
                  },
                  titleKey: detailsKey),
              CustomTabBarContainer(
                  boxConstraints: boxConstraints,
                  alignment: AlignmentDirectional.centerEnd,
                  isSelected: _selectedTabTitle == resultsKey,
                  onTap: () {
                    setState(() {
                      _selectedTabTitle = resultsKey;
                    });
                  },
                  titleKey: resultsKey),
            ],
          );
        }),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          //
          _selectedTabTitle == detailsKey
              ? StudentDetailsContainer()
              : SizedBox(),
          _buildAppBar(),
        ],
      ),
    );
  }
}
