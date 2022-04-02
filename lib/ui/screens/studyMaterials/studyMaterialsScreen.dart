import 'package:eschool_teacher/ui/widgets/customDropDownMenu.dart';
import 'package:eschool_teacher/ui/widgets/customFloatingActionButton.dart';
import 'package:eschool_teacher/ui/widgets/customTabBarContainer.dart';
import 'package:eschool_teacher/ui/widgets/screenTopBackgroundContainer.dart';
import 'package:eschool_teacher/ui/widgets/svgButton.dart';
import 'package:eschool_teacher/ui/widgets/tabBarBackgroundContainer.dart';
import 'package:eschool_teacher/utils/labelKeys.dart';
import 'package:eschool_teacher/utils/uiUtils.dart';
import 'package:flutter/material.dart';

class StudyMaterialsScreen extends StatefulWidget {
  StudyMaterialsScreen({Key? key}) : super(key: key);

  @override
  State<StudyMaterialsScreen> createState() => _StudyMaterialsScreenState();
}

class _StudyMaterialsScreenState extends State<StudyMaterialsScreen> {
  List<String> _classes = ["Class"];

  late String _selectedClass = _classes.first;

  List<String> _divisions = ["Division"];

  late String _selectedDivision = _divisions.first;

  List<String> _subjects = ["Subject"];

  late String _selectedSubject = _subjects.first;

  List<String> _chapters = ["Chapters"];

  late String _selectedChapters = _chapters.first;

  late String _selectedTabTitle = videosKey;

  Widget _buildAssignmentFilters() {
    return Padding(
      padding: EdgeInsets.symmetric(
          horizontal: MediaQuery.of(context).size.width * (0.075)),
      child: LayoutBuilder(builder: (context, boxConstraints) {
        return Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                CustomDropDownMenu(
                    width: boxConstraints.maxWidth * (0.45),
                    menu: _classes,
                    currentSelectedItem: _selectedClass),
                CustomDropDownMenu(
                    width: boxConstraints.maxWidth * (0.45),
                    menu: _divisions,
                    currentSelectedItem: _selectedDivision),
              ],
            ),
            CustomDropDownMenu(
                width: boxConstraints.maxWidth,
                menu: _subjects,
                currentSelectedItem: _selectedSubject),
            CustomDropDownMenu(
                width: boxConstraints.maxWidth,
                menu: _chapters,
                currentSelectedItem: _selectedChapters),
          ],
        );
      }),
    );
  }

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
              Align(
                alignment: Alignment.topCenter,
                child: Text(
                  UiUtils.getTranslatedLabel(context, studyMaterialsKey),
                  style: TextStyle(
                      color: Theme.of(context).scaffoldBackgroundColor,
                      fontSize: UiUtils.screenTitleFontSize),
                ),
              ),
              AnimatedAlign(
                curve: UiUtils.tabBackgroundContainerAnimationCurve,
                duration: UiUtils.tabBackgroundContainerAnimationDuration,
                alignment: _selectedTabTitle == videosKey
                    ? AlignmentDirectional.centerStart
                    : AlignmentDirectional.centerEnd,
                child: TabBackgroundContainer(boxConstraints: boxConstraints),
              ),
              CustomTabBarContainer(
                  boxConstraints: boxConstraints,
                  alignment: AlignmentDirectional.centerStart,
                  isSelected: _selectedTabTitle == videosKey,
                  onTap: () {
                    setState(() {
                      _selectedTabTitle = videosKey;
                    });
                  },
                  titleKey: videosKey),
              CustomTabBarContainer(
                  boxConstraints: boxConstraints,
                  alignment: AlignmentDirectional.centerEnd,
                  isSelected: _selectedTabTitle == filesKey,
                  onTap: () {
                    setState(() {
                      _selectedTabTitle = filesKey;
                    });
                  },
                  titleKey: filesKey)
            ],
          );
        }),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingActionAddButton(onTap: () {}),
      body: Stack(
        children: [
          SingleChildScrollView(
            padding: EdgeInsets.only(
                top: UiUtils.getScrollViewTopPadding(
                    context: context,
                    appBarHeightPercentage:
                        UiUtils.appBarBiggerHeightPercentage)),
            child: Column(
              children: [
                //
                _buildAssignmentFilters()
              ],
            ),
          ),
          _buildAppBar(),
        ],
      ),
    );
  }
}
