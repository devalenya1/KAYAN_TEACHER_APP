import 'package:eschool_teacher/ui/widgets/bottomSheetTextFiledContainer.dart';
import 'package:eschool_teacher/ui/widgets/bottomSheetTopBarMenu.dart';
import 'package:eschool_teacher/ui/widgets/customRoundedButton.dart';
import 'package:eschool_teacher/utils/labelKeys.dart';
import 'package:eschool_teacher/utils/uiUtils.dart';
import 'package:flutter/material.dart';

class CreateChapterBottomsheetContainer extends StatefulWidget {
  CreateChapterBottomsheetContainer({Key? key}) : super(key: key);

  @override
  State<CreateChapterBottomsheetContainer> createState() =>
      _CreateChapterBottomsheetContainerState();
}

class _CreateChapterBottomsheetContainerState
    extends State<CreateChapterBottomsheetContainer> {
  late TextEditingController _chapterNameTextEditingController =
      TextEditingController();

  late TextEditingController _chapterDescriptionEditingController =
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
                title: UiUtils.getTranslatedLabel(context, createChapterKey)),
            Padding(
              padding: EdgeInsets.symmetric(
                  horizontal: UiUtils.bottomSheetHorizontalContentPadding),
              child: Column(
                children: [
                  SizedBox(
                    height: MediaQuery.of(context).size.height * (0.0125),
                  ),
                  BottomSheetTextFieldContainer(
                      hintText:
                          UiUtils.getTranslatedLabel(context, chapterNameKey),
                      maxLines: 1,
                      textEditingController: _chapterNameTextEditingController),
                  SizedBox(
                    height: MediaQuery.of(context).size.height * (0.025),
                  ),
                  BottomSheetTextFieldContainer(
                      contentAlignment: AlignmentDirectional.topStart,
                      height: MediaQuery.of(context).size.height * (0.12),
                      hintText: UiUtils.getTranslatedLabel(
                          context, chapterDescriptionKey),
                      maxLines: null,
                      textEditingController:
                          _chapterDescriptionEditingController),
                  SizedBox(
                    height: MediaQuery.of(context).size.height * (0.025),
                  ),
                  CustomRoundedButton(
                      height: UiUtils.bottomSheetButtonHeight,
                      widthPercentage: UiUtils.bottomSheetButtonWidthPercentage,
                      backgroundColor: Theme.of(context).colorScheme.primary,
                      buttonTitle:
                          UiUtils.getTranslatedLabel(context, createChapterKey),
                      showBorder: false),
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
