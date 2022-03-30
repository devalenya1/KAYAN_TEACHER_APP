import 'package:eschool_teacher/ui/widgets/customCloseButton.dart';
import 'package:eschool_teacher/ui/widgets/customRoundedButton.dart';
import 'package:eschool_teacher/utils/labelKeys.dart';
import 'package:eschool_teacher/utils/uiUtils.dart';
import 'package:flutter/material.dart';

class DownloadFileBottomsheetContainer extends StatelessWidget {
  const DownloadFileBottomsheetContainer({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () {
        return Future.value(false);
      },
      child: Container(
        padding: EdgeInsets.symmetric(
            horizontal: MediaQuery.of(context).size.width * (0.075),
            vertical: MediaQuery.of(context).size.height * (0.04)),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  UiUtils.getTranslatedLabel(context, fileDownloadKey),
                  style: TextStyle(
                      fontSize: 16.0,
                      color: Theme.of(context).colorScheme.secondary,
                      fontWeight: FontWeight.w600),
                ),
                Spacer(),
                CustomCloseButton(
                  onTapCloseButton: () {
                    Navigator.of(context).pop();
                  },
                )
              ],
            ),
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 10.0),
              child: Divider(
                color: Theme.of(context).colorScheme.onBackground,
              ),
            ),
            SizedBox(
              height: MediaQuery.of(context).size.height * (0.0125),
            ),
            Text(
              "Test paper.pdf",
              style: TextStyle(
                  fontSize: 18.0,
                  color: Theme.of(context).colorScheme.primary,
                  fontWeight: FontWeight.w600),
            ),
            SizedBox(
              height: MediaQuery.of(context).size.height * (0.025),
            ),
            CustomRoundedButton(
                height: 40,
                textSize: 16.0,
                widthPercentage: 0.35,
                titleColor: Theme.of(context).scaffoldBackgroundColor,
                backgroundColor: Theme.of(context).colorScheme.primary,
                buttonTitle: UiUtils.getTranslatedLabel(context, downloadKey),
                showBorder: false)
          ],
        ),
        decoration: BoxDecoration(
            color: Theme.of(context).scaffoldBackgroundColor,
            borderRadius: BorderRadius.only(
              topLeft: Radius.circular(UiUtils.bottomSheetTopRadius),
              topRight: Radius.circular(UiUtils.bottomSheetTopRadius),
            )),
      ),
    );
  }
}
