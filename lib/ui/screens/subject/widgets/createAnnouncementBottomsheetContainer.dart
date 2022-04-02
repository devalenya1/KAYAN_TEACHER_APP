import 'package:eschool_teacher/ui/widgets/bottomSheetTextFiledContainer.dart';
import 'package:eschool_teacher/ui/widgets/bottomSheetTopBarMenu.dart';
import 'package:eschool_teacher/ui/widgets/bottomsheetAddFilesDottedBorderContainer.dart';
import 'package:eschool_teacher/ui/widgets/customRoundedButton.dart';
import 'package:eschool_teacher/ui/widgets/uploadFileContainer.dart';
import 'package:eschool_teacher/utils/labelKeys.dart';
import 'package:eschool_teacher/utils/uiUtils.dart';
import 'package:flutter/material.dart';

class CreateAnnouncementBottomsheetContainer extends StatefulWidget {
  CreateAnnouncementBottomsheetContainer({Key? key}) : super(key: key);

  @override
  State<CreateAnnouncementBottomsheetContainer> createState() =>
      _CreateAnnouncementBottomsheetContainerState();
}

class _CreateAnnouncementBottomsheetContainerState
    extends State<CreateAnnouncementBottomsheetContainer> {
  late TextEditingController _announcementTextEditingController =
      TextEditingController();

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () {
        return Future.value(true);
      },
      child: Padding(
        padding: MediaQuery.of(context).viewInsets,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            BottomSheetTopBarMenu(
                onTapCloseButton: () {
                  Navigator.of(context).pop();
                },
                title:
                    UiUtils.getTranslatedLabel(context, createAnnouncementKey)),
            Padding(
              padding: EdgeInsets.symmetric(
                  horizontal: UiUtils.bottomSheetHorizontalContentPadding),
              child: Column(
                children: [
                  SizedBox(
                    height: MediaQuery.of(context).size.height * (0.0125),
                  ),
                  BottomSheetTextFieldContainer(
                      contentAlignment: AlignmentDirectional.topStart,
                      height: MediaQuery.of(context).size.height * (0.12),
                      maxLines: null,
                      textEditingController: _announcementTextEditingController,
                      hintText: UiUtils.getTranslatedLabel(
                          context, announcementDescriptionKey)),
                  SizedBox(
                    height: MediaQuery.of(context).size.height * (0.03),
                  ),
                  BottomsheetAddFilesDottedBorderContainer(
                      onTap: () {},
                      title: UiUtils.getTranslatedLabel(
                          context, addAttatchmentsKey)),
                  SizedBox(
                    height: MediaQuery.of(context).size.height * (0.03),
                  ),
                  CustomRoundedButton(
                      height: UiUtils.bottomSheetButtonHeight,
                      widthPercentage: UiUtils.bottomSheetButtonWidthPercentage,
                      maxLines: 1,
                      backgroundColor: Theme.of(context).colorScheme.primary,
                      buttonTitle: UiUtils.getTranslatedLabel(
                          context, createAnnouncementKey),
                      showBorder: false),
                  SizedBox(
                    height: MediaQuery.of(context).size.height * (0.03),
                  ),
                  UploadFileContainer(),
                  SizedBox(
                    height: MediaQuery.of(context).size.height * (0.05),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
