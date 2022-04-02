import 'package:eschool_teacher/ui/widgets/bottomSheetTextFiledContainer.dart';
import 'package:eschool_teacher/ui/widgets/bottomSheetTopBarMenu.dart';
import 'package:eschool_teacher/ui/widgets/customRoundedButton.dart';
import 'package:eschool_teacher/utils/labelKeys.dart';
import 'package:eschool_teacher/utils/uiUtils.dart';
import 'package:flutter/material.dart';

class RejectAssignmentBottomsheetContainer extends StatefulWidget {
  RejectAssignmentBottomsheetContainer({Key? key}) : super(key: key);

  @override
  State<RejectAssignmentBottomsheetContainer> createState() =>
      _RejectAssignmentBottomsheetContainerState();
}

class _RejectAssignmentBottomsheetContainerState
    extends State<RejectAssignmentBottomsheetContainer> {
  late TextEditingController _remarkTextEditingController =
      TextEditingController();

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
        child: Padding(
          padding: MediaQuery.of(context).viewInsets,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              BottomSheetTopBarMenu(
                  onTapCloseButton: () {
                    Navigator.of(context).pop();
                  },
                  title: UiUtils.getTranslatedLabel(context, rejectKey)),
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
                            UiUtils.getTranslatedLabel(context, addRemarkKey),
                        maxLines: 2,
                        textEditingController: _remarkTextEditingController),
                    SizedBox(
                      height: MediaQuery.of(context).size.height * (0.025),
                    ),
                    CustomRoundedButton(
                        height: UiUtils.bottomSheetButtonHeight,
                        widthPercentage:
                            UiUtils.bottomSheetButtonWidthPercentage,
                        backgroundColor: Theme.of(context).colorScheme.primary,
                        buttonTitle:
                            UiUtils.getTranslatedLabel(context, submitKey),
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
        onWillPop: () {
          return Future.value(true);
        });
  }
}
