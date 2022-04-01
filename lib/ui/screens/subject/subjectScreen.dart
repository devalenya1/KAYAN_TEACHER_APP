import 'package:eschool_teacher/ui/screens/subject/widgets/announcementContainer.dart';
import 'package:eschool_teacher/ui/screens/subject/widgets/chaptersContainer.dart';
import 'package:eschool_teacher/ui/screens/subject/widgets/createAnnouncementBottomsheetContainer.dart';
import 'package:eschool_teacher/ui/screens/subject/widgets/createChapterBottomsheetContainer.dart';
import 'package:eschool_teacher/ui/widgets/customFloatingActionButton.dart';
import 'package:eschool_teacher/ui/widgets/customTabBarContainer.dart';
import 'package:eschool_teacher/ui/widgets/screenTopBackgroundContainer.dart';
import 'package:eschool_teacher/ui/widgets/svgButton.dart';
import 'package:eschool_teacher/ui/widgets/tabBarBackgroundContainer.dart';
import 'package:eschool_teacher/utils/labelKeys.dart';
import 'package:eschool_teacher/utils/uiUtils.dart';
import 'package:flutter/material.dart';

class SubjectScreen extends StatefulWidget {
  SubjectScreen({Key? key}) : super(key: key);

  @override
  State<SubjectScreen> createState() => _SubjectScreenState();
}

class _SubjectScreenState extends State<SubjectScreen> {
  late String _selectedTabTitle = chaptersKey;

  void _onTapFloatingActionAddButton() {
    UiUtils.showBottomSheet(
        child: _selectedTabTitle == chaptersKey
            ? CreateChapterBottomsheetContainer()
            : CreateAnnouncementBottomsheetContainer(),
        context: context);
  }

  Widget _buildAppBar() {
    return Align(
      alignment: Alignment.topCenter,
      child: ScreenTopBackgroundContainer(
        child: LayoutBuilder(builder: (context, boxConstraints) {
          return Stack(
            children: [
              Align(
                alignment: Alignment.topLeft,
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
                  "Science",
                  style: TextStyle(
                      color: Theme.of(context).scaffoldBackgroundColor,
                      fontSize: UiUtils.screenTitleFontSize),
                ),
              ),
              Align(
                alignment: Alignment.topCenter,
                child: Padding(
                  padding: EdgeInsets.only(
                      top: boxConstraints.maxHeight * (0.08) +
                          UiUtils.screenTitleFontSize),
                  child: Text(
                    "${UiUtils.getTranslatedLabel(context, classKey)} 10 - A",
                    style: TextStyle(
                        color: Theme.of(context).scaffoldBackgroundColor,
                        fontSize: UiUtils.screenSubTitleFontSize),
                  ),
                ),
              ),
              AnimatedAlign(
                curve: UiUtils.tabBackgroundContainerAnimationCurve,
                duration: UiUtils.tabBackgroundContainerAnimationDuration,
                alignment: _selectedTabTitle == chaptersKey
                    ? Alignment.centerLeft
                    : Alignment.centerRight,
                child:
                    TabBatBackgroundContainer(boxConstraints: boxConstraints),
              ),
              CustomTabBarContainer(
                  boxConstraints: boxConstraints,
                  alignment: Alignment.centerLeft,
                  isSelected: _selectedTabTitle == chaptersKey,
                  onTap: () {
                    setState(() {
                      _selectedTabTitle = chaptersKey;
                    });
                  },
                  titleKey: chaptersKey),
              CustomTabBarContainer(
                  boxConstraints: boxConstraints,
                  alignment: Alignment.centerRight,
                  isSelected: _selectedTabTitle == announcementKey,
                  onTap: () {
                    setState(() {
                      _selectedTabTitle = announcementKey;
                    });
                  },
                  titleKey: announcementKey)
            ],
          );
        }),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton:
          FloatingActionAddButton(onTap: _onTapFloatingActionAddButton),
      body: Stack(
        children: [
          Align(
            alignment: Alignment.topCenter,
            child: SingleChildScrollView(
              padding: EdgeInsets.only(
                  bottom: UiUtils.getScrollViewBottomPadding(context),
                  top: UiUtils.getScrollViewTopPadding(
                      context: context,
                      appBarHeightPercentage:
                          UiUtils.appBarBiggerHeightPercentage)),
              child: Column(
                children: [
                  _selectedTabTitle == chaptersKey
                      ? ChaptersContainer()
                      : AnnouncementContainer()
                ],
              ),
            ),
          ),
          _buildAppBar(),
        ],
      ),
    );
  }
}
