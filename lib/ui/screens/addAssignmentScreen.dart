import 'package:eschool_teacher/cubits/createAssignmentCubit.dart';
import 'package:eschool_teacher/cubits/myClassesCubit.dart';
import 'package:eschool_teacher/cubits/subjectsOfClassSectionCubit.dart';
import 'package:eschool_teacher/data/repositories/createAssignmentRepository.dart';
import 'package:eschool_teacher/data/repositories/teacherRepository.dart';
import 'package:eschool_teacher/ui/styles/colors.dart';
import 'package:eschool_teacher/ui/widgets/bottomSheetTextFiledContainer.dart';
import 'package:eschool_teacher/ui/widgets/bottomsheetAddFilesDottedBorderContainer.dart';
import 'package:eschool_teacher/ui/widgets/classSubjectsDropDownMenu.dart';
import 'package:eschool_teacher/ui/widgets/customAppbar.dart';
import 'package:eschool_teacher/ui/widgets/customCupertinoSwitch.dart';
import 'package:eschool_teacher/ui/widgets/customDropDownMenu.dart';
import 'package:eschool_teacher/ui/widgets/customRoundedButton.dart';
import 'package:eschool_teacher/ui/widgets/myClassesDropDownMenu.dart';
import 'package:eschool_teacher/utils/labelKeys.dart';
import 'package:eschool_teacher/utils/uiUtils.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:permission_handler/permission_handler.dart';

import 'package:file_picker/file_picker.dart';

import 'package:flutter/material.dart';

class AddAssignmentScreen extends StatefulWidget {
  AddAssignmentScreen({Key? key}) : super(key: key);

  static Route<dynamic> Routes(RouteSettings setting) {
    return CupertinoPageRoute(builder: (context) {
      return MultiBlocProvider(providers: [
        BlocProvider<SubjectsOfClassSectionCubit>(
          create: (_) => SubjectsOfClassSectionCubit(TeacherRepository()),
        ),
        BlocProvider<CreateAssignmentCubit>(
          create: (_) => CreateAssignmentCubit(CreateAssignmentRepository()),
        )
      ], child: AddAssignmentScreen());
    });
  }

  @override
  State<AddAssignmentScreen> createState() => _AddAssignmentScreenState();
}

class _AddAssignmentScreenState extends State<AddAssignmentScreen> {
  late String currentSelectedClassSection =
      context.read<MyClassesCubit>().getClassSectionName().first;

  late String currentSelectedSubject =
      UiUtils.getTranslatedLabel(context, selectSubjectKey);
  List<String> _classes = ["Class"];

  DateTime? dueDate;

  TimeOfDay? dueTime;
  int classSectionId = 0;
  int subjectSectionId = 0;

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

  void changeAllowdLateSubmission() {
    setState(() {
      _allowedLateSubmission = !_allowedLateSubmission;
    });
  }

  void changeAllowedReSubmissionOfRejectedAssignment(bool value) {
    setState(() {
      _allowedReSubmissionOfRejectedAssignment = value;
    });
  }

  List<PlatformFile> uploadedFiles = [];

  void _pickFiles() async {
    FilePickerResult? result =
        await FilePicker.platform.pickFiles(allowMultiple: true);
    if (result != null) {
      uploadedFiles.addAll(result.files);
      setState(() {});
    }
  }

  void _addFiles() async {
    //upload files
    bool permissionGiven = (await Permission.storage.status).isGranted;
    if (permissionGiven) {
      _pickFiles();
    } else {
      permissionGiven = (await Permission.storage.request()).isGranted;
      if (permissionGiven) {
        _pickFiles();
      }
    }
  }

  Widget _buildUploadedFileContainer(int fileIndex) {
    return Container(
      margin: EdgeInsets.only(bottom: 10.0),
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(15),
          color: Theme.of(context).colorScheme.background),
      padding: EdgeInsets.symmetric(horizontal: 15, vertical: 10.0),
      child: LayoutBuilder(builder: (context, boxConstraints) {
        return Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            SizedBox(
              width: boxConstraints.maxWidth * (0.75),
              child: Text(uploadedFiles[fileIndex].name,
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                  style: TextStyle(
                    color: Theme.of(context).colorScheme.secondary,
                  )),
            ),
            Spacer(),
            IconButton(
                onPressed: () {
                  if (context.read<CreateAssignmentCubit>().state
                      is createAssignmentInProcess) {
                    return;
                  }
                  uploadedFiles.removeAt(fileIndex);
                  setState(() {});
                },
                icon: Icon(Icons.close)),
          ],
        );
      }),
    );
  }

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
    dueTime = await showTimePicker(
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
    setState(() {});
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
          MyClassesDropDownMenu(
              currentSelectedItem: currentSelectedClassSection,
              width: boxConstraints.maxWidth,
              changeSelectedItem: (result) {
                setState(() {
                  currentSelectedClassSection = result;
                  classSectionId = context
                      .read<MyClassesCubit>()
                      .getClassSectionDetails(
                          classSectionName: currentSelectedClassSection)
                      .id;
                  setState(() {});
                  print(classSectionId);
                });
              }),
          ClassSubjectsDropDownMenu(
              changeSelectedItem: (result) {
                setState(() {
                  currentSelectedSubject = result;
                  subjectSectionId = context
                      .read<SubjectsOfClassSectionCubit>()
                      .getSubjectIdByName(result);

                  print(subjectSectionId);
                });
              },
              currentSelectedItem: currentSelectedSubject,
              width: boxConstraints.maxWidth),
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
                  dueDate == null
                      ? UiUtils.getTranslatedLabel(context, dueDateKey)
                      : DateFormat('dd-MM-yyyy').format(dueDate!).toString(),
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
                  dueTime == null
                      ? UiUtils.getTranslatedLabel(context, dueTimeKey)
                      : "${dueTime!.hour}:${dueTime!.minute}",
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
            margin: EdgeInsetsDirectional.only(bottom: _textFieldBottomPadding),
            hintText: UiUtils.getTranslatedLabel(context, assignmentNameKey),
            maxLines: 1,
            textEditingController: _assignmentNameTextEditingController,
          ),

          BottomSheetTextFieldContainer(
            margin: EdgeInsetsDirectional.only(bottom: _textFieldBottomPadding),
            hintText: UiUtils.getTranslatedLabel(context, instructionsKey),
            maxLines: 3,
            textEditingController: _assignmentInstructionTextEditingController,
          ),

          _buildAddDueDateAndTimeContainer(),

          BottomSheetTextFieldContainer(
            margin: EdgeInsetsDirectional.only(bottom: _textFieldBottomPadding),
            hintText: UiUtils.getTranslatedLabel(context, pointsKey),
            maxLines: 1,
            textEditingController: _assignmentPointsTextEditingController,
          ),

          //_buildLateSubmissionToggleContainer(),

          _buildReSubmissionOfRejectedAssignmentToggleContainer(),

          _allowedReSubmissionOfRejectedAssignment
              ? BottomSheetTextFieldContainer(
                  margin: EdgeInsetsDirectional.only(
                      bottom: _textFieldBottomPadding),
                  hintText: UiUtils.getTranslatedLabel(
                      context, extraDaysForRejectedAssignmentKey),
                  maxLines: 2,
                  textEditingController:
                      _extraResubmissionDaysTextEditingController,
                )
              : SizedBox(),

          Padding(
            padding: EdgeInsets.only(bottom: _textFieldBottomPadding),
            child: BottomsheetAddFilesDottedBorderContainer(
                onTap: () async {
                  _addFiles();
                },
                title:
                    UiUtils.getTranslatedLabel(context, referenceMaterialsKey)),
          ),
          ...List.generate(uploadedFiles.length, (index) => index)
              .map((fileIndex) => _buildUploadedFileContainer(fileIndex))
              .toList(),

          BlocListener<CreateAssignmentCubit, createAssignmentState>(
            listener: (context, state) {
              if (state is createAssignmentSuccess) {
                Navigator.of(context).pop();
              }
            },
            child: CustomRoundedButton(
                height: 45,
                radius: 10,
                widthPercentage: 0.65,
                backgroundColor: Theme.of(context).colorScheme.primary,
                buttonTitle:
                    UiUtils.getTranslatedLabel(context, createAssignmentKey),
                showBorder: false,
                onTap: () {
                  print(_assignmentPointsTextEditingController.text);
                  if (_assignmentPointsTextEditingController.text != "0" ||
                      _assignmentPointsTextEditingController.text
                          .toString()
                          .isNotEmpty) {
                    context.read<CreateAssignmentCubit>().createAssignment(
                          classsId: classSectionId,
                          subjectId: subjectSectionId,
                          name: _assignmentNameTextEditingController.text,
                          datetime:
                              "${DateFormat('dd-MM-yyyy').format(dueDate!).toString()} ${dueTime!.hour}:${dueTime!.minute}",
                          extraDayForResubmission:
                              _extraResubmissionDaysTextEditingController.text,
                          instruction:
                              _assignmentInstructionTextEditingController.text,
                          points: _assignmentPointsTextEditingController.text,
                          resubmission: _allowedLateSubmission ? 1 : 0,
                          file: uploadedFiles.map((e) => e.path!).toList(),
                        );
                  } else {
                    ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                      content: Text(
                          ("Please enter a value greater than or equal to 1.")),
                    ));
                  }
                }),
          ),
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
