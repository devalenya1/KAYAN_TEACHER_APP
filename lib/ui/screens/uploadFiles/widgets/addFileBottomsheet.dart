import 'package:eschool_teacher/data/studyMaterials/models/studyFile.dart';
import 'package:eschool_teacher/ui/styles/colors.dart';
import 'package:eschool_teacher/ui/widgets/bottomSheetTextFiledContainer.dart';
import 'package:eschool_teacher/ui/widgets/bottomSheetTopBarMenu.dart';
import 'package:eschool_teacher/ui/widgets/bottomsheetAddFilesDottedBorderContainer.dart';
import 'package:eschool_teacher/ui/widgets/customDropDownMenu.dart';
import 'package:eschool_teacher/ui/widgets/customRoundedButton.dart';
import 'package:eschool_teacher/utils/labelKeys.dart';
import 'package:eschool_teacher/utils/uiUtils.dart';
import 'package:flutter/material.dart';

class AddFileBottomsheet extends StatefulWidget {
  final Function onTapAddFile;
  final bool editFileDetails;
  final StudyFile? studyFile;
  final int? fileIndex;
  AddFileBottomsheet({
    Key? key,
    this.fileIndex,
    required this.editFileDetails,
    required this.onTapAddFile,
    this.studyFile,
  }) : super(key: key);

  @override
  State<AddFileBottomsheet> createState() => _AddFileBottomsheetState();
}

class _AddFileBottomsheetState extends State<AddFileBottomsheet> {
  late TextEditingController _fileNameTextEditingController =
      TextEditingController(text: widget.studyFile?.name);

  final List<String> _chapters = ["Carbon and it's bonds", "Atom Theory"];

  late String _selectedChapter =
      widget.editFileDetails ? widget.studyFile!.chapterId : _chapters.first;

  final List<String> _subjects = ["Chemistry"];

  late String _selectedSubject =
      widget.editFileDetails ? widget.studyFile!.subjectId : _subjects.first;

  final List<String> _classAndDivisions = ["Class 10 - A"];

  late String _selectedClassDivison = widget.editFileDetails
      ? widget.studyFile!.classDivisonId
      : _classAndDivisions.first;

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
        child: Padding(
          padding: MediaQuery.of(context).viewInsets,
          child: SingleChildScrollView(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                BottomSheetTopBarMenu(
                    onTapCloseButton: () {},
                    title: UiUtils.getTranslatedLabel(context, addFileKey)),
                Padding(
                  padding: EdgeInsets.symmetric(
                      horizontal: UiUtils.bottomSheetHorizontalContentPadding),
                  child: Column(
                    children: [
                      BottomSheetTextFieldContainer(
                          margin: EdgeInsets.only(bottom: 25),
                          hintText:
                              UiUtils.getTranslatedLabel(context, fileNameKey),
                          maxLines: 1,
                          textEditingController:
                              _fileNameTextEditingController),
                      LayoutBuilder(builder: (context, boxConstraints) {
                        return CustomDropDownMenu(
                            onChanged: (value) {
                              setState(() {
                                _selectedClassDivison =
                                    value ?? _selectedClassDivison;
                              });
                            },
                            textStyle: TextStyle(
                                color: hintTextColor,
                                fontSize: UiUtils.textFieldFontSize),
                            borderRadius: 10,
                            height: 50,
                            width: boxConstraints.maxWidth,
                            menu: _classAndDivisions,
                            currentSelectedItem: _selectedClassDivison);
                      }),
                      LayoutBuilder(builder: (context, boxConstraints) {
                        return CustomDropDownMenu(
                            onChanged: (value) {
                              setState(() {
                                _selectedSubject = value ?? _selectedSubject;
                              });
                            },
                            textStyle: TextStyle(
                                color: hintTextColor,
                                fontSize: UiUtils.textFieldFontSize),
                            borderRadius: 10,
                            height: 50,
                            width: boxConstraints.maxWidth,
                            menu: _subjects,
                            currentSelectedItem: _selectedSubject);
                      }),
                      LayoutBuilder(builder: (context, boxConstraints) {
                        return CustomDropDownMenu(
                            onChanged: (value) {
                              setState(() {
                                _selectedChapter = value ?? _selectedChapter;
                              });
                            },
                            textStyle: TextStyle(
                                color: hintTextColor,
                                fontSize: UiUtils.textFieldFontSize),
                            borderRadius: 10,
                            height: 50,
                            width: boxConstraints.maxWidth,
                            menu: _chapters,
                            currentSelectedItem: _selectedChapter);
                      }),
                      SizedBox(
                        height: 25,
                      ),
                      BottomsheetAddFilesDottedBorderContainer(
                          onTap: () {},
                          title:
                              UiUtils.getTranslatedLabel(context, addFileKey)),
                      SizedBox(
                        height: 25,
                      ),
                      CustomRoundedButton(
                          onTap: () {
                            StudyFile studyFile = StudyFile(
                                name:
                                    _fileNameTextEditingController.text.trim(),
                                url: "File url",
                                chapterId: _selectedChapter,
                                classDivisonId: _selectedClassDivison,
                                subjectId: _selectedSubject);
                            if (widget.editFileDetails) {
                              widget.onTapAddFile(widget.fileIndex!, studyFile);
                            } else {
                              widget.onTapAddFile(studyFile);
                            }
                            Navigator.of(context).pop();
                          },
                          height: UiUtils.bottomSheetButtonHeight,
                          widthPercentage:
                              UiUtils.bottomSheetButtonWidthPercentage,
                          backgroundColor:
                              Theme.of(context).colorScheme.primary,
                          buttonTitle:
                              UiUtils.getTranslatedLabel(context, addFileKey),
                          showBorder: false),
                    ],
                  ),
                ),
                SizedBox(
                  height: 25,
                ),
              ],
            ),
          ),
        ),
        onWillPop: () => Future.value(true));
  }
}
