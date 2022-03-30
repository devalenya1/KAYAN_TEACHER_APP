import 'package:eschool_teacher/ui/widgets/screenTopBackgroundContainer.dart';
import 'package:eschool_teacher/ui/widgets/svgButton.dart';
import 'package:eschool_teacher/utils/uiUtils.dart';
import 'package:flutter/material.dart';

class CustomAppBar extends StatelessWidget {
  final String title;
  final Function? onPressBackButton;
  CustomAppBar({Key? key, this.onPressBackButton, required this.title})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ScreenTopBackgroundContainer(
      padding: EdgeInsets.all(0),
      child: Stack(
        children: [
          Align(
            alignment: Alignment.centerLeft,
            child: Padding(
                child: SvgButton(
                    onTap: () {
                      if (onPressBackButton != null) {
                        onPressBackButton!.call();
                      } else {
                        Navigator.of(context).pop();
                      }
                    },
                    svgIconUrl: UiUtils.getImagePath("back_icon.svg")),
                padding: EdgeInsets.only(
                  left: UiUtils.screenContentHorizontalPadding,
                )),
          ),
          Align(
            alignment: Alignment.center,
            child: Text(
              title,
              style: TextStyle(
                  fontSize: UiUtils.screenTitleFontSize,
                  color: Theme.of(context).scaffoldBackgroundColor),
            ),
          ),
        ],
      ),
      heightPercentage: UiUtils.appBarSmallerHeightPercentage,
    );
  }
}
