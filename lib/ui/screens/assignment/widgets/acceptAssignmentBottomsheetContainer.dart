import 'package:eschool_teacher/ui/widgets/bottomSheetTextFiledContainer.dart';
import 'package:eschool_teacher/ui/widgets/bottomSheetTopBarMenu.dart';
import 'package:eschool_teacher/ui/widgets/customRoundedButton.dart';
import 'package:eschool_teacher/utils/labelKeys.dart';
import 'package:eschool_teacher/utils/uiUtils.dart';
import 'package:flutter/material.dart';

class AcceptAssignmentBottomsheetContainer extends StatefulWidget {
  AcceptAssignmentBottomsheetContainer({Key? key}) : super(key: key);

  @override
  State<AcceptAssignmentBottomsheetContainer> createState() =>
      _AcceptAssignmentBottomsheetContainerState();
}

class _AcceptAssignmentBottomsheetContainerState
    extends State<AcceptAssignmentBottomsheetContainer> {
  late TextEditingController _remarkTextEditingController =
      TextEditingController();

  late TextEditingController _pointsTextEditingController =
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
                  title: UiUtils.getTranslatedLabel(context, acceptKey)),
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
                    BottomSheetTextFieldContainer(
                        hintText:
                            UiUtils.getTranslatedLabel(context, pointsKey),
                        maxLines: 1,
                        textEditingController: _pointsTextEditingController),
                    SizedBox(
                      height: MediaQuery.of(context).size.height * (0.025),
                    ),
                    CustomRoundedButton(
                        height: 50,
                        radius: 10,
                        widthPercentage: 0.7,
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
