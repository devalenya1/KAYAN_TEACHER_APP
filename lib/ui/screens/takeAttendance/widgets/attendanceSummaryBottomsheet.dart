import 'package:eschool_teacher/ui/widgets/bottomSheetTopBarMenu.dart';
import 'package:eschool_teacher/utils/labelKeys.dart';
import 'package:eschool_teacher/utils/uiUtils.dart';
import 'package:flutter/material.dart';

class AttendanceSummaryBottomsheet extends StatefulWidget {
  AttendanceSummaryBottomsheet({Key? key}) : super(key: key);

  @override
  State<AttendanceSummaryBottomsheet> createState() =>
      _AttendanceSummaryBottomsheetState();
}

class _AttendanceSummaryBottomsheetState
    extends State<AttendanceSummaryBottomsheet> {
  @override
  Widget build(BuildContext context) {
    return WillPopScope(
        child: Padding(
          padding: MediaQuery.of(context).viewInsets,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              //
              BottomSheetTopBarMenu(
                  onTapCloseButton: () {},
                  title:
                      UiUtils.getTranslatedLabel(context, attendanceSummaryKey))
            ],
          ),
        ),
        onWillPop: () => Future.value(true));
  }
}
