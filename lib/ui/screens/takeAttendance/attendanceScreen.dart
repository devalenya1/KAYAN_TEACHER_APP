import 'package:eschool_teacher/cubits/appConfigurationCubit.dart';
import 'package:eschool_teacher/data/models/student.dart';
import 'package:eschool_teacher/ui/widgets/customBackButton.dart';
import 'package:eschool_teacher/ui/widgets/customRoundedButton.dart';
import 'package:eschool_teacher/ui/widgets/screenTopBackgroundContainer.dart';
import 'package:eschool_teacher/ui/widgets/searchButton.dart';
import 'package:eschool_teacher/utils/labelKeys.dart';
import 'package:eschool_teacher/utils/uiUtils.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class AttendanceScreen extends StatefulWidget {
  final List<Student> students;
  AttendanceScreen({Key? key, required this.students}) : super(key: key);

  @override
  State<AttendanceScreen> createState() => _AttendanceScreenState();

  static Route route(RouteSettings routeSettings) {
    return CupertinoPageRoute(
        builder: (_) => AttendanceScreen(
            students: routeSettings.arguments as List<Student>));
  }
}

class _AttendanceScreenState extends State<AttendanceScreen> {
  late List<Map<int, bool>> _listOfAttendance = [];

  late DateTime _selectedAttendanceDate = DateTime.now();

  @override
  void initState() {
    super.initState();
    //Fetch get attendance
  }

  void _updateAttendance(int studentId) {
    final index = _listOfAttendance
        .indexWhere((element) => element.keys.first == studentId);
    _listOfAttendance[index][studentId] = !_listOfAttendance[index][studentId]!;
    setState(() {});
  }

  String _buildAttendanceDate() {
    return "${_selectedAttendanceDate.day.toString().padLeft(2, '0')}-${_selectedAttendanceDate.month.toString().padLeft(2, '0')}-${_selectedAttendanceDate.year}";
  }

  void _changeAttendanceDate() async {
    final pickedDate = await showDatePicker(
      lastDate: DateTime.now(),
      builder: (context, child) {
        return Theme(
          data: Theme.of(context).copyWith(
              colorScheme: Theme.of(context).colorScheme.copyWith(
                  onPrimary: Theme.of(context).scaffoldBackgroundColor)),
          child: child!,
        );
      },
      context: context,
      initialDate: _selectedAttendanceDate,
      firstDate: context
          .read<AppConfigurationCubit>()
          .getAppConfiguration()
          .academicYear
          .startDate,
    );

    if (pickedDate != null) {
      setState(() {
        _selectedAttendanceDate = pickedDate;
      });
    }
  }

  Widget _buildAppbar() {
    return ScreenTopBackgroundContainer(
      padding: EdgeInsets.all(0),
      child: LayoutBuilder(builder: (context, boxConstraints) {
        return Stack(
          children: [
            CustomBackButton(
              onTap: () {
                Navigator.of(context).pop();
              },
              alignmentDirectional: AlignmentDirectional.centerStart,
            ),
            Align(
              alignment: AlignmentDirectional.centerEnd,
              child: SearchButton(onTap: () {}),
            ),
            Align(
              alignment: Alignment.center,
              child: Container(
                alignment: Alignment.center,
                width: boxConstraints.maxWidth * (0.6),
                child: Text(
                  UiUtils.getTranslatedLabel(context, takeAttendanceKey),
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  textAlign: TextAlign.center,
                  style: TextStyle(
                      fontSize: UiUtils.screenTitleFontSize,
                      color: Theme.of(context).scaffoldBackgroundColor),
                ),
              ),
            ),
            Align(
              alignment: Alignment.center,
              child: Container(
                alignment: Alignment.center,
                width: boxConstraints.maxWidth * (0.6),
                margin: EdgeInsets.only(
                    top: boxConstraints.maxHeight * (0.25) +
                        UiUtils.screenTitleFontSize),
                child: GestureDetector(
                  onTap: () {
                    _changeAttendanceDate();
                  },
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Transform.translate(
                        offset: Offset(0.0, -0.75),
                        child: Icon(
                          Icons.calendar_month,
                          size: 14,
                          color: Theme.of(context).colorScheme.background,
                        ),
                      ),
                      SizedBox(
                        width: boxConstraints.maxWidth * (0.015),
                      ),
                      Text(
                        _buildAttendanceDate(),
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                        style: TextStyle(
                            fontSize: UiUtils.screenSubTitleFontSize,
                            color: Theme.of(context).scaffoldBackgroundColor),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ],
        );
      }),
      heightPercentage: UiUtils.appBarSmallerHeightPercentage,
    );
  }

  Widget _buildSubmitAttendanceButton() {
    return Align(
      alignment: Alignment.bottomCenter,
      child: Padding(
        padding: const EdgeInsets.only(bottom: 25),
        child: CustomRoundedButton(
            onTap: () {
              print("Attendance submitted");
            },
            elevation: 10.0,
            height: UiUtils.bottomSheetButtonHeight,
            widthPercentage: UiUtils.bottomSheetButtonWidthPercentage,
            backgroundColor: Theme.of(context).colorScheme.primary,
            buttonTitle: UiUtils.getTranslatedLabel(context, submitKey),
            showBorder: false),
      ),
    );
  }

  Widget _buildStudents() {
    final List<Widget> children = [];

    return Align(
      alignment: Alignment.topCenter,
      child: SingleChildScrollView(
        padding: EdgeInsets.only(
            bottom: UiUtils.bottomSheetButtonHeight + 40.0,
            top: UiUtils.getScrollViewTopPadding(
                context: context,
                appBarHeightPercentage: UiUtils.appBarSmallerHeightPercentage)),
        child: Column(
          children: children,
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          _buildStudents(),
          _buildAppbar(),
          _buildSubmitAttendanceButton()
        ],
      ),
    );
  }
}
