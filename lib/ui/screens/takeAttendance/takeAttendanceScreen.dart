import 'package:eschool_teacher/ui/widgets/customAppbar.dart';
import 'package:eschool_teacher/ui/widgets/customRoundedButton.dart';
import 'package:eschool_teacher/utils/labelKeys.dart';
import 'package:eschool_teacher/utils/uiUtils.dart';
import 'package:flutter/material.dart';

class TakeAttendanceScreen extends StatefulWidget {
  TakeAttendanceScreen({Key? key}) : super(key: key);

  @override
  State<TakeAttendanceScreen> createState() => _TakeAttendanceScreenState();
}

class _TakeAttendanceScreenState extends State<TakeAttendanceScreen> {
  late int totalStudent = 15;

  late List<bool> _listOfAttendance = [];

  late DateTime _selectedAttendanceDate = DateTime.now();

  @override
  void initState() {
    super.initState();
    for (var i = 0; i < totalStudent; i++) {
      _listOfAttendance.add(true);
    }
  }

  void _updateAttendance(int index) {
    _listOfAttendance[index] = !_listOfAttendance[index];
    setState(() {});
  }

  String _buildAttendanceDate() {
    return "${_selectedAttendanceDate.day.toString().padLeft(2, '0')}-${_selectedAttendanceDate.month.toString().padLeft(2, '0')}-${_selectedAttendanceDate.year}";
  }

  void _changeAttendanceDate() async {
    final pickedDate = await showDatePicker(
      lastDate: DateTime.now().add(Duration(days: 30)),
      builder: (context, child) {
        return Theme(
          data: Theme.of(context).copyWith(
              colorScheme: Theme.of(context).colorScheme.copyWith(
                  onPrimary: Theme.of(context).scaffoldBackgroundColor)),
          child: child!,
        );
      },
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime.now().subtract(Duration(days: 30)),
    );

    if (pickedDate != null) {
      setState(() {
        _selectedAttendanceDate = pickedDate;
      });
    }
  }

  Widget _buildAppbar() {
    return Align(
      alignment: Alignment.topCenter,
      child: CustomAppBar(
          subTitle: _buildAttendanceDate(),
          trailingWidget: GestureDetector(
            onTap: () {
              _changeAttendanceDate();
            },
            child: Container(
              decoration:
                  BoxDecoration(border: Border.all(color: Colors.transparent)),
              width: 25,
              height: 25,
              child: Icon(
                Icons.calendar_month,
                size: 26,
                color: Theme.of(context).scaffoldBackgroundColor,
              ),
            ),
          ),
          title: UiUtils.getTranslatedLabel(context, takeAttendanceKey)),
    );
  }

  Widget _buildSubmitAttendanceButton() {
    return Align(
      alignment: Alignment.bottomCenter,
      child: Padding(
        padding: const EdgeInsets.only(bottom: 25.0),
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

  Widget _buildStudentContainer(int studentIndex) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 20),
      child: InkWell(
        borderRadius: BorderRadius.circular(10),
        onTap: () {
          _updateAttendance(studentIndex);
        },
        child: Container(
          clipBehavior: Clip.none,
          decoration: BoxDecoration(
              boxShadow: [
                BoxShadow(
                    color: Theme.of(context)
                        .colorScheme
                        .secondary
                        .withOpacity(0.05),
                    offset: Offset(2.5, 2.5),
                    blurRadius: 10,
                    spreadRadius: 0)
              ],
              color: Theme.of(context).scaffoldBackgroundColor,
              borderRadius: BorderRadius.circular(10)),
          width: MediaQuery.of(context).size.width * (0.88),
          padding: EdgeInsets.symmetric(horizontal: 15, vertical: 12.5),
          child: LayoutBuilder(builder: (context, boxConstraints) {
            return Row(
              children: [
                Stack(
                  children: [
                    Container(
                      decoration: BoxDecoration(
                        image: DecorationImage(
                            fit: BoxFit.cover,
                            image:
                                AssetImage(UiUtils.getImagePath("panda.jpeg"))),
                        borderRadius: BorderRadius.circular(7.5),
                      ),
                      height: 50,
                      width: boxConstraints.maxWidth * (0.175),
                    ),
                    _listOfAttendance[studentIndex]
                        ? SizedBox()
                        : Container(
                            child: Icon(
                              Icons.close,
                              color: Theme.of(context).scaffoldBackgroundColor,
                            ),
                            alignment: Alignment.center,
                            decoration: BoxDecoration(
                              color: Theme.of(context)
                                  .colorScheme
                                  .error
                                  .withOpacity(0.85),
                              borderRadius: BorderRadius.circular(7.5),
                            ),
                            height: 50,
                            width: boxConstraints.maxWidth * (0.175),
                          ),
                  ],
                ),
                SizedBox(
                  width: boxConstraints.maxWidth * (0.045),
                ),
                SizedBox(
                  width: boxConstraints.maxWidth * (0.58),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "Student name",
                        style: TextStyle(
                            color: Theme.of(context).colorScheme.secondary,
                            fontWeight: FontWeight.w600,
                            fontSize: 13.0),
                      ),
                      Text("Roll No - 18",
                          style: TextStyle(
                              color: Theme.of(context)
                                  .colorScheme
                                  .secondary
                                  .withOpacity(0.75),
                              fontWeight: FontWeight.w400,
                              fontSize: 10.5),
                          textAlign: TextAlign.left)
                    ],
                  ),
                ),
                Container(
                  alignment: Alignment.center,
                  padding: EdgeInsets.symmetric(horizontal: 7.5, vertical: 2.5),
                  child: Text(
                    UiUtils.getTranslatedLabel(
                        context,
                        _listOfAttendance[studentIndex]
                            ? presentKey
                            : absentKey),
                    style: TextStyle(
                        fontSize: 11,
                        color: Theme.of(context).scaffoldBackgroundColor),
                  ),
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(5),
                      border: Border.all(color: Colors.transparent),
                      color: _listOfAttendance[studentIndex]
                          ? Theme.of(context).colorScheme.primary
                          : Theme.of(context).colorScheme.error),
                  width: boxConstraints.maxWidth * (0.2),
                )
              ],
            );
          }),
        ),
      ),
    );
  }

  Widget _buildStudents() {
    final List<Widget> children = [];
    for (var i = 0; i < totalStudent; i++) {
      children.add(_buildStudentContainer(i));
    }
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
