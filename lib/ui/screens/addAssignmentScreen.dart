import 'package:eschool_teacher/ui/styles/colors.dart';
import 'package:eschool_teacher/ui/widgets/bottomSheetTextFiledContainer.dart';
import 'package:eschool_teacher/ui/widgets/bottomsheetAddFilesDottedBorderContainer.dart';
import 'package:eschool_teacher/ui/widgets/customAppbar.dart';
import 'package:eschool_teacher/ui/widgets/customCupertinoSwitch.dart';
import 'package:eschool_teacher/ui/widgets/customDropDownMenu.dart';
import 'package:eschool_teacher/ui/widgets/customRoundedButton.dart';
import 'package:eschool_teacher/utils/labelKeys.dart';
import 'package:eschool_teacher/utils/uiUtils.dart';

import 'package:flutter/material.dart';

class AddAssignmentScreen extends StatefulWidget {
  AddAssignmentScreen({Key? key}) : super(key: key);

  @override
  State<AddAssignmentScreen> createState() => _AddAssignmentScreenState();
}

class _AddAssignmentScreenState extends State<AddAssignmentScreen> {
  List<String> _classes = ["Class"];

  late String _selectedClass = _classes.first;

  List<String> _subjects = ["Subject"];

  late String _selectedSubject = _subjects.first;

  late TextEditingController _assignmentNameTextEditingController =
      TextEditingController();

  late TextEditingController _assignmentInstructionTextEditingController =
      TextEditingController();

  late TextEditingController _assignmentPointsTextEditingController =
      TextEditingController();

  late TextEditingController _extraResubmissionDaysTextEditingController =
      TextEditingController();

  final double _textFieldBottomPadding = 25;

  late bool _allowedLateSubmission = true;
  late bool _allowedReSubmissionOfRejectedAssignment = true;

  void changeAllowdLateSubmission(bool value) {
    setState(() {
      _allowedLateSubmission = value;
    });
  }

  void changeAllowedReSubmissionOfRejectedAssignment(bool value) {
    setState(() {
      _allowedReSubmissionOfRejectedAssignment = value;
    });
  }

  late DateTime? dueDate;

  void openDatePicker() async {
    dueDate = await showDatePicker(
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
        firstDate: DateTime.now(),
        lastDate: DateTime.now().add(Duration(days: 30)));

    setState(() {});
  }

  void openTimePicker() async {
    await showTimePicker(
        builder: (context, child) {
          return Theme(
            data: Theme.of(context).copyWith(
                colorScheme: Theme.of(context).colorScheme.copyWith(
                    onPrimary: Theme.of(context).scaffoldBackgroundColor)),
            child: child!,
          );
        },
        context: context,
        initialTime: TimeOfDay.now());
  }

  Widget _buildAppBar() {
    return Align(
      alignment: Alignment.topCenter,
      child: CustomAppBar(
          title: UiUtils.getTranslatedLabel(context, createAssignmentKey)),
    );
  }

  Widget _buildAssignmentClassDropdownButtons() {
    return LayoutBuilder(builder: (context, boxConstraints) {
      return Column(
        children: [
          CustomDropDownMenu(
              onChanged: (value) {
                setState(() {
                  _selectedClass = value ?? _selectedClass;
                });
              },
              width: boxConstraints.maxWidth,
              menu: _classes,
              currentSelectedItem: _selectedClass),
          CustomDropDownMenu(
              onChanged: (value) {
                setState(() {
                  _selectedSubject = value ?? _selectedSubject;
                });
              },
              width: boxConstraints.maxWidth,
              menu: _subjects,
              currentSelectedItem: _selectedSubject),
        ],
      );
    });
  }

  Widget _buildAddDueDateAndTimeContainer() {
    return Padding(
      padding: EdgeInsets.only(bottom: _textFieldBottomPadding),
      child: LayoutBuilder(builder: (context, boxConstraints) {
        return Row(
          children: [
            InkWell(
              borderRadius: BorderRadius.circular(10),
              onTap: () {
                openDatePicker();
              },
              child: Container(
                alignment: AlignmentDirectional.centerStart,
                child: Text(
                  UiUtils.getTranslatedLabel(context, dueDateKey),
                  style: TextStyle(
                      color: hintTextColor,
                      fontSize: UiUtils.textFieldFontSize),
                ),
                padding: EdgeInsetsDirectional.only(start: 20.0),
                decoration: BoxDecoration(
                  color: Theme.of(context).colorScheme.background,
                  borderRadius: BorderRadius.circular(10),
                  border: Border.all(
                    color: Theme.of(context)
                        .colorScheme
                        .onBackground
                        .withOpacity(0.5),
                  ),
                ),
                width: boxConstraints.maxWidth * (0.475),
                height: 50,
              ),
            ),
            Spacer(),
            InkWell(
              onTap: () {
                openTimePicker();
              },
              borderRadius: BorderRadius.circular(10),
              child: Container(
                alignment: AlignmentDirectional.centerStart,
                child: Text(
                  UiUtils.getTranslatedLabel(context, dueTimeKey),
                  style: TextStyle(
                      color: hintTextColor,
                      fontSize: UiUtils.textFieldFontSize),
                ),
                padding: EdgeInsetsDirectional.only(start: 20.0),
                decoration: BoxDecoration(
                  color: Theme.of(context).colorScheme.background,
                  borderRadius: BorderRadius.circular(10),
                  border: Border.all(
                    color: Theme.of(context)
                        .colorScheme
                        .onBackground
                        .withOpacity(0.5),
                  ),
                ),
                width: boxConstraints.maxWidth * (0.475),
                height: 50,
              ),
            ),
          ],
        );
      }),
    );
  }

  Widget _buildLateSubmissionToggleContainer() {
    return Padding(
      padding: EdgeInsets.only(bottom: _textFieldBottomPadding),
      child: LayoutBuilder(builder: (context, boxConstraints) {
        return Container(
          height: 50,
          padding: EdgeInsets.symmetric(horizontal: 20),
          decoration: BoxDecoration(
            color: Theme.of(context).colorScheme.background,
            borderRadius: BorderRadius.circular(10),
            border: Border.all(
              color:
                  Theme.of(context).colorScheme.onBackground.withOpacity(0.5),
            ),
          ),
          child: Row(
            children: [
              Flexible(
                child: SizedBox(
                  width: boxConstraints.maxWidth * (0.8),
                  child: Text(
                    UiUtils.getTranslatedLabel(context, lateSubmissionKey),
                    style: TextStyle(
                        color: hintTextColor,
                        fontSize: UiUtils.textFieldFontSize),
                  ),
                ),
              ),
              Spacer(),
              SizedBox(
                width: 30,
                child: CustomCupertinoSwitch(
                    onChanged: changeAllowdLateSubmission,
                    value: _allowedLateSubmission),
              )
            ],
          ),
        );
      }),
    );
  }

  Widget _buildReSubmissionOfRejectedAssignmentToggleContainer() {
    return Padding(
      padding: EdgeInsets.only(bottom: _textFieldBottomPadding),
      child: LayoutBuilder(builder: (context, boxConstraints) {
        return Container(
          height: 70,
          padding: EdgeInsets.symmetric(horizontal: 20),
          decoration: BoxDecoration(
            color: Theme.of(context).colorScheme.background,
            borderRadius: BorderRadius.circular(10),
            border: Border.all(
              color:
                  Theme.of(context).colorScheme.onBackground.withOpacity(0.5),
            ),
          ),
          child: Row(
            children: [
              Flexible(
                child: SizedBox(
                  width: boxConstraints.maxWidth * (0.85),
                  child: Text(
                    UiUtils.getTranslatedLabel(
                        context, resubmissionOfRejectedAssignmentKey),
                    style: TextStyle(
                        color: hintTextColor,
                        fontSize: UiUtils.textFieldFontSize),
                  ),
                ),
              ),
              SizedBox(
                width: boxConstraints.maxWidth * (0.075),
              ),
              Container(
                alignment: Alignment.centerRight,
                width: boxConstraints.maxWidth * (0.1),
                child: CustomCupertinoSwitch(
                    onChanged: changeAllowedReSubmissionOfRejectedAssignment,
                    value: _allowedReSubmissionOfRejectedAssignment),
              )
            ],
          ),
        );
      }),
    );
  }

  Widget _buildAssignmentDetailsFormContaienr() {
    return SingleChildScrollView(
      padding: EdgeInsets.only(
          left: MediaQuery.of(context).size.width * (0.075),
          right: MediaQuery.of(context).size.width * (0.075),
          top: UiUtils.getScrollViewTopPadding(
              context: context,
              appBarHeightPercentage: UiUtils.appBarSmallerHeightPercentage)),
      child: Column(
        children: [
          //
          _buildAssignmentClassDropdownButtons(),
          BottomSheetTextFieldContainer(
              margin:
                  EdgeInsetsDirectional.only(bottom: _textFieldBottomPadding),
              hintText: UiUtils.getTranslatedLabel(context, assignmentNameKey),
              maxLines: 1,
              textEditingController: _assignmentNameTextEditingController),

          BottomSheetTextFieldContainer(
              margin:
                  EdgeInsetsDirectional.only(bottom: _textFieldBottomPadding),
              hintText: UiUtils.getTranslatedLabel(context, instructionsKey),
              maxLines: 3,
              textEditingController:
                  _assignmentInstructionTextEditingController),

          _buildAddDueDateAndTimeContainer(),

          BottomSheetTextFieldContainer(
              margin:
                  EdgeInsetsDirectional.only(bottom: _textFieldBottomPadding),
              hintText: UiUtils.getTranslatedLabel(context, pointsKey),
              maxLines: 1,
              textEditingController: _assignmentPointsTextEditingController),

          _buildLateSubmissionToggleContainer(),

          _buildReSubmissionOfRejectedAssignmentToggleContainer(),

          _allowedReSubmissionOfRejectedAssignment
              ? BottomSheetTextFieldContainer(
                  margin: EdgeInsetsDirectional.only(
                      bottom: _textFieldBottomPadding),
                  hintText: UiUtils.getTranslatedLabel(
                      context, extraDaysForRejectedAssignmentKey),
                  maxLines: 2,
                  textEditingController:
                      _extraResubmissionDaysTextEditingController)
              : SizedBox(),

          Padding(
            padding: EdgeInsets.only(bottom: _textFieldBottomPadding),
            child: BottomsheetAddFilesDottedBorderContainer(
                onTap: () {},
                title:
                    UiUtils.getTranslatedLabel(context, referenceMaterialsKey)),
          ),

          CustomRoundedButton(
              height: 45,
              radius: 10,
              widthPercentage: 0.65,
              backgroundColor: Theme.of(context).colorScheme.primary,
              buttonTitle:
                  UiUtils.getTranslatedLabel(context, createAssignmentKey),
              showBorder: false),
          SizedBox(
            height: _textFieldBottomPadding,
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          _buildAssignmentDetailsFormContaienr(),
          _buildAppBar(),
        ],
      ),
    );
  }
}
