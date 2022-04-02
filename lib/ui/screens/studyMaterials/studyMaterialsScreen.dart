import 'package:eschool_teacher/app/routes.dart';
import 'package:eschool_teacher/ui/screens/studyMaterials/widgets/filesContainer.dart';
import 'package:eschool_teacher/ui/screens/studyMaterials/widgets/videosContainer.dart';
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
            CustomDropDownMenu(
                onChanged: (value) {
                  setState(() {
                    _selectedClass = value ?? _selectedClass;
                  });
                },
                width: boxConstraints.maxWidth,
                menu: _classes,
                currentSelectedItem: _selectedClass),
            CustomDropDownMenu(
                onChanged: (value) {
                  setState(() {
                    _selectedSubject = value ?? _selectedSubject;
                  });
                },
                width: boxConstraints.maxWidth,
                menu: _subjects,
                currentSelectedItem: _selectedSubject),
            CustomDropDownMenu(
                onChanged: (value) {
                  setState(() {
                    _selectedChapters = value ?? _selectedChapters;
                  });
                },
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
      floatingActionButton: FloatingActionAddButton(onTap: () {
        Navigator.of(context).pushNamed(_selectedTabTitle == videosKey
            ? Routes.uploadVideos
            : Routes.uploadFiles);
      }),
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
                _buildAssignmentFilters(),
                SizedBox(
                  height: 20,
                ),
                _selectedTabTitle == videosKey
                    ? VideosContainer()
                    : FilesContainer(),
              ],
            ),
          ),
          _buildAppBar(),
        ],
      ),
    );
  }
}
