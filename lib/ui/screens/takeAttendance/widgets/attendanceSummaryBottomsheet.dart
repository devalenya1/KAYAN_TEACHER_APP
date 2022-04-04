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
            ],
          ),
        ),
        onWillPop: () => Future.value(true));
  }
}
