import 'package:eschool_teacher/app/routes.dart';
import 'package:eschool_teacher/ui/widgets/screenTopBackgroundContainer.dart';
import 'package:eschool_teacher/utils/labelKeys.dart';
import 'package:eschool_teacher/utils/uiUtils.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

class HomeContainer extends StatefulWidget {
  HomeContainer({Key? key}) : super(key: key);

  @override
  State<HomeContainer> createState() => _HomeContainerState();
}

class _HomeContainerState extends State<HomeContainer> {
  TextStyle _titleFontStyle() {
    return TextStyle(
        color: Theme.of(context).colorScheme.secondary,
        fontSize: 17.0,
        fontWeight: FontWeight.w600);
  }

  Widget _buildTopProfileContainer(BuildContext context) {
    return ScreenTopBackgroundContainer(
      padding: EdgeInsets.all(0),
      child: LayoutBuilder(builder: (context, boxConstraints) {
        return Stack(
          children: [
            //Bordered circles
            Positioned(
              top: MediaQuery.of(context).size.width * (-0.15),
              left: MediaQuery.of(context).size.width * (-0.225),
              child: Container(
                padding: EdgeInsets.only(right: 20.0, bottom: 20.0),
                child: Container(
                  decoration: BoxDecoration(
                      border: Border.all(
                          color: Theme.of(context)
                              .scaffoldBackgroundColor
                              .withOpacity(0.1)),
                      shape: BoxShape.circle),
                ),
                decoration: BoxDecoration(
                    border: Border.all(
                        color: Theme.of(context)
                            .scaffoldBackgroundColor
                            .withOpacity(0.1)),
                    shape: BoxShape.circle),
                width: MediaQuery.of(context).size.width * (0.6),
                height: MediaQuery.of(context).size.width * (0.6),
              ),
            ),

            //bottom fill circle
            Positioned(
              bottom: MediaQuery.of(context).size.width * (-0.15),
              right: MediaQuery.of(context).size.width * (-0.15),
              child: Container(
                decoration: BoxDecoration(
                    color: Theme.of(context)
                        .scaffoldBackgroundColor
                        .withOpacity(0.1),
                    shape: BoxShape.circle),
                width: MediaQuery.of(context).size.width * (0.4),
                height: MediaQuery.of(context).size.width * (0.4),
              ),
            ),

            Align(
              alignment: Alignment.bottomCenter,
              child: Container(
                margin: EdgeInsets.only(
                    left: boxConstraints.maxWidth * (0.075),
                    bottom: boxConstraints.maxHeight * (0.2)),
                child: Row(
                  children: [
                    Container(
                      decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          border: Border.all(
                              width: 2.0,
                              color:
                                  Theme.of(context).scaffoldBackgroundColor)),
                      width: boxConstraints.maxWidth * (0.175),
                      height: boxConstraints.maxWidth * (0.175),
                    ),
                    SizedBox(
                      width: boxConstraints.maxWidth * (0.05),
                    ),
                    Expanded(
                        child: Row(
                      children: [
                        Column(
                          mainAxisSize: MainAxisSize.min,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              "Divy M. Jani",
                              maxLines: 1,
                              overflow: TextOverflow.ellipsis,
                              style: TextStyle(
                                  fontSize: 18.0,
                                  fontWeight: FontWeight.w500,
                                  color: Theme.of(context)
                                      .scaffoldBackgroundColor),
                            ),
                          ],
                        )
                      ],
                    ))
                  ],
                ),
              ),
            ),
          ],
        );
      }),
    );
  }

  Widget _buildClassContainer(
      {required BoxConstraints boxConstraints, required int index}) {
    return InkWell(
      onTap: () {
        Navigator.of(context).pushNamed(Routes.classScreen);
      },
      borderRadius: BorderRadius.circular(10),
      child: Container(
        height: 80,
        child: Stack(
          clipBehavior: Clip.none,
          children: [
            Align(
              alignment: Alignment.center,
              child: Text(
                "10 - A",
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
                style: TextStyle(
                    color: Theme.of(context).scaffoldBackgroundColor,
                    fontSize: 15,
                    fontWeight: FontWeight.w600),
              ),
            ),
            Positioned(
                bottom: -15,
                left: (boxConstraints.maxWidth * 0.225) - 15, //0.45
                child: Container(
                  alignment: Alignment.center,
                  width: 30,
                  child: Icon(
                    Icons.arrow_forward_ios,
                    color: Theme.of(context).colorScheme.primary,
                    size: 18,
                  ),
                  height: 30,
                  decoration: BoxDecoration(
                      boxShadow: [
                        BoxShadow(
                            color: Theme.of(context)
                                .colorScheme
                                .secondary
                                .withOpacity(0.2),
                            offset: Offset(0, 4),
                            blurRadius: 20)
                      ],
                      shape: BoxShape.circle,
                      color: Theme.of(context).scaffoldBackgroundColor),
                ))
          ],
        ),
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10),
            //Diplaying different(4) class color
            color: UiUtils.getClassColor(index),
            boxShadow: [
              BoxShadow(
                  blurRadius: 10,
                  color: UiUtils.getClassColor(index).withOpacity(0.2),
                  offset: Offset(0, 2.5))
            ]),
        width: boxConstraints.maxWidth * 0.45,
      ),
    );
  }

  Widget _buildMyClasses() {
    return Column(
      children: [
        Align(
          alignment: Alignment.centerLeft,
          child: Text(
            UiUtils.getTranslatedLabel(context, myClassesKey),
            style: _titleFontStyle(),
          ),
        ),
        SizedBox(
          height: 30.0,
        ),
        LayoutBuilder(builder: (context, boxConstraints) {
          return Wrap(
            spacing: boxConstraints.maxWidth * (0.1),
            runSpacing: 40,
            direction: Axis.horizontal,
            children: [
              _buildClassContainer(boxConstraints: boxConstraints, index: 0),
              _buildClassContainer(boxConstraints: boxConstraints, index: 1),
              _buildClassContainer(boxConstraints: boxConstraints, index: 2),
              _buildClassContainer(boxConstraints: boxConstraints, index: 3),
            ],
          );
        }),
      ],
    );
  }

  Widget _buildClassTeacher() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Align(
          alignment: Alignment.centerLeft,
          child: Text(
            UiUtils.getTranslatedLabel(context, classTeacherKey),
            style: _titleFontStyle(),
          ),
        ),
        SizedBox(
          height: 30.0,
        ),
        LayoutBuilder(builder: (context, boxConstraints) {
          return _buildClassContainer(boxConstraints: boxConstraints, index: 0);
        }),
      ],
    );
  }

  Widget _buildMenuContainer(
      {required String iconPath, required String title}) {
    return Container(
      margin: EdgeInsets.only(bottom: 15.0),
      height: 80,
      child: LayoutBuilder(builder: (context, boxConstraints) {
        return Row(
          children: [
            Container(
              padding: EdgeInsets.all(14),
              margin: EdgeInsets.symmetric(horizontal: 10.0),
              height: 60,
              child: SvgPicture.asset(iconPath),
              decoration: BoxDecoration(
                  color: Theme.of(context)
                      .colorScheme
                      .onSecondary
                      .withOpacity(0.225),
                  borderRadius: BorderRadius.circular(15.0)),
              width: boxConstraints.maxWidth * (0.225),
            ),
            SizedBox(
              width: 10.0,
            ),
            Text(
              title,
              style: TextStyle(
                  color: Theme.of(context).colorScheme.secondary,
                  fontWeight: FontWeight.w500,
                  fontSize: 15),
            ),
            Spacer(),
            CircleAvatar(
              backgroundColor: Theme.of(context).colorScheme.secondary,
              radius: 17.5,
              child: Icon(
                Icons.arrow_forward,
                size: 22.5,
                color: Theme.of(context).scaffoldBackgroundColor,
              ),
            ),
            SizedBox(
              width: 15.0,
            ),
          ],
        );
      }),
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(20),
          border: Border.all(
            width: 1.0,
            color: Theme.of(context).colorScheme.secondary.withOpacity(0.25),
          )),
    );
  }

  Widget _buildInformationAndMenu() {
    return Column(
      children: [
        Align(
          alignment: Alignment.centerLeft,
          child: Text(
            UiUtils.getTranslatedLabel(context, informationKey),
            style: _titleFontStyle(),
          ),
        ),
        SizedBox(
          height: 30.0,
        ),
        //TODO : add maxWidth and overflow checker
        _buildMenuContainer(
            iconPath: UiUtils.getImagePath("assignment_icon.svg"),
            title: UiUtils.getTranslatedLabel(context, assignmentsKey)),

        _buildMenuContainer(
            iconPath: UiUtils.getImagePath("study_material_icon.svg"),
            title: UiUtils.getTranslatedLabel(context, studyMaterialsKey)),

        _buildMenuContainer(
            iconPath: UiUtils.getImagePath("announcment_icon.svg"),
            title: UiUtils.getTranslatedLabel(context, announcementsKey)),
      ],
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
                left: MediaQuery.of(context).size.width * (0.075),
                right: MediaQuery.of(context).size.width * (0.075),
                bottom: UiUtils.getScrollViewBottomPadding(context),
                top: UiUtils.getScrollViewTopPadding(
                    context: context,
                    appBarHeightPercentage:
                        UiUtils.appBarBiggerHeightPercentage)),
            child: Column(
              children: [
                _buildMyClasses(),
                SizedBox(
                  height: 50.0,
                ),
                _buildClassTeacher(),
                SizedBox(
                  height: 30.0,
                ),
                _buildInformationAndMenu()
              ],
            ),
          ),
        ),
        Align(
          alignment: Alignment.topCenter,
          child: _buildTopProfileContainer(context),
        ),
      ],
    );
  }
}
