import 'package:eschool_teacher/cubits/createLessonCubit.dart';
import 'package:eschool_teacher/cubits/editLessonCubit.dart';
import 'package:eschool_teacher/cubits/myClassesCubit.dart';
import 'package:eschool_teacher/cubits/subjectsOfClassSectionCubit.dart';
import 'package:eschool_teacher/data/models/lesson.dart';
import 'package:eschool_teacher/data/models/pickedStudyMaterial.dart';
import 'package:eschool_teacher/data/models/subject.dart';
import 'package:eschool_teacher/data/repositories/lessonRepository.dart';
import 'package:eschool_teacher/data/repositories/teacherRepository.dart';
import 'package:eschool_teacher/ui/widgets/addStudyMaterialBottomSheet.dart';
import 'package:eschool_teacher/ui/widgets/addedFileContainer.dart';
import 'package:eschool_teacher/ui/widgets/bottomSheetTextFiledContainer.dart';
import 'package:eschool_teacher/ui/widgets/bottomsheetAddFilesDottedBorderContainer.dart';
import 'package:eschool_teacher/ui/widgets/classSubjectsDropDownMenu.dart';
import 'package:eschool_teacher/ui/widgets/customAppbar.dart';
import 'package:eschool_teacher/ui/widgets/customCircularProgressIndicator.dart';
import 'package:eschool_teacher/ui/widgets/customRoundedButton.dart';
import 'package:eschool_teacher/ui/widgets/defaultDropDownLabelContainer.dart';
import 'package:eschool_teacher/ui/widgets/myClassesDropDownMenu.dart';
import 'package:eschool_teacher/ui/widgets/studyMaterialContainer.dart';
import 'package:eschool_teacher/utils/labelKeys.dart';
import 'package:eschool_teacher/utils/uiUtils.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class AddOrEditLessonScreen extends StatefulWidget {
  final bool editLesson;
  final Lesson? lesson;
  final Subject? subject;

  AddOrEditLessonScreen(
      {Key? key, required this.editLesson, this.lesson, this.subject})
      : super(key: key);

  static Route<bool?> route(RouteSettings routeSettings) {
    final arguments = routeSettings.arguments as Map<String, dynamic>;

    return CupertinoPageRoute(
        builder: (_) => MultiBlocProvider(
              providers: [
                BlocProvider(
                  create: (context) =>
                      SubjectsOfClassSectionCubit(TeacherRepository()),
                ),
                BlocProvider(
                  create: (context) => CreateLessonCubit(LessonRepository()),
                ),
                BlocProvider(
                  create: (context) => EditLessonCubit(LessonRepository()),
                ),
              ],
              child: AddOrEditLessonScreen(
                editLesson: arguments['editLesson'],
                lesson: arguments['lesson'],
                subject: arguments['subject'],
              ),
            ));
  }

  @override
  State<AddOrEditLessonScreen> createState() => _AddOrEditLessonScreenState();
}

class _AddOrEditLessonScreenState extends State<AddOrEditLessonScreen> {
  late String currentSelectedClassSection = widget.editLesson
      ? context
          .read<MyClassesCubit>()
          .getClassSectionDetailsById(widget.lesson!.classSectionId)
          .getClassSectionName()
      : context.read<MyClassesCubit>().getClassSectionName().first;

  late String currentSelectedSubject =
      UiUtils.getTranslatedLabel(context, fetchingSubjectsKey);

  late TextEditingController _lessonNameTextEditingController =
      TextEditingController(
          text: widget.editLesson ? widget.lesson!.name : null);
  late TextEditingController _lessonDescriptionTextEditingController =
      TextEditingController(
          text: widget.editLesson ? widget.lesson!.description : null);

  List<PickedStudyMaterial> _addedStudyMaterials = [];

  @override
  void initState() {
    if (!widget.editLesson) {
      context.read<SubjectsOfClassSectionCubit>().fetchSubjects(context
          .read<MyClassesCubit>()
          .getClassSectionDetails(classSectionName: currentSelectedClassSection)
          .id);
    }

    super.initState();
  }

  void _addStudyMaterial(PickedStudyMaterial pickedStudyMaterial) {
    setState(() {
      _addedStudyMaterials.add(pickedStudyMaterial);
    });
  }

  void showErrorMessage(String errorMessageKey) {
    UiUtils.showErrorMessageContainer(
        context: context,
        errorMessage: errorMessageKey,
        backgroundColor: Theme.of(context).colorScheme.error);
  }

  void editLesson() {
    if (_lessonNameTextEditingController.text.trim().isEmpty) {
      showErrorMessage(pleaseEnterLessonNameKey);
      return;
    }

    if (_lessonNameTextEditingController.text.trim().isEmpty) {
      showErrorMessage(pleaseEnterLessonDescriptionKey);
      return;
    }

    context.read<EditLessonCubit>().editLesson(
        lessonDescription: _lessonDescriptionTextEditingController.text.trim(),
        lessonName: _lessonNameTextEditingController.text.trim(),
        lessonId: widget.lesson!.id,
        classSectionId: widget.lesson!.classSectionId,
        subjectId: widget.subject!.id,
        files: _addedStudyMaterials);
  }

  void createLesson() {
    //
    if (_lessonNameTextEditingController.text.trim().isEmpty) {
      showErrorMessage(pleaseEnterLessonNameKey);
      return;
    }

    if (_lessonNameTextEditingController.text.trim().isEmpty) {
      showErrorMessage(pleaseEnterLessonDescriptionKey);
      return;
    }

    final selectedSubjectId = context
        .read<SubjectsOfClassSectionCubit>()
        .getSubjectIdByName(currentSelectedSubject);

    //
    if (selectedSubjectId == -1) {
      showErrorMessage(pleasefetchingSubjectsKey);
      return;
    }

    context.read<CreateLessonCubit>().createLesson(
        classSectionId: context
            .read<MyClassesCubit>()
            .getClassSectionDetails(
                classSectionName: currentSelectedClassSection)
            .id,
        files: _addedStudyMaterials,
        subjectId: selectedSubjectId,
        lessonDescription: _lessonDescriptionTextEditingController.text.trim(),
        lessonName: _lessonNameTextEditingController.text.trim());
  }

  Widget _buildAppbar() {
    return Align(
      alignment: Alignment.topCenter,
      child: CustomAppBar(
          title: UiUtils.getTranslatedLabel(
              context, widget.editLesson ? editLessonKey : addLessonKey)),
    );
  }

  Widget _buildAddOrEditLessonForm() {
    return SingleChildScrollView(
      padding: EdgeInsets.only(
          bottom: 25,
          right: UiUtils.screenContentHorizontalPaddingPercentage *
              MediaQuery.of(context).size.width,
          left: UiUtils.screenContentHorizontalPaddingPercentage *
              MediaQuery.of(context).size.width,
          top: UiUtils.getScrollViewTopPadding(
              context: context,
              appBarHeightPercentage: UiUtils.appBarSmallerHeightPercentage)),
      child: LayoutBuilder(builder: (context, boxConstraints) {
        return Column(
          children: [
            widget.editLesson
                ? DefaultDropDownLabelContainer(
                    titleLabelKey: currentSelectedClassSection,
                    width: boxConstraints.maxWidth)
                : MyClassesDropDownMenu(
                    currentSelectedItem: currentSelectedClassSection,
                    width: boxConstraints.maxWidth,
                    changeSelectedItem: (result) {
                      setState(() {
                        currentSelectedClassSection = result;
                        _addedStudyMaterials = [];
                      });
                    }),

            //
            widget.editLesson
                ? DefaultDropDownLabelContainer(
                    titleLabelKey: widget.subject!.name,
                    width: boxConstraints.maxWidth)
                : ClassSubjectsDropDownMenu(
                    changeSelectedItem: (result) {
                      setState(() {
                        currentSelectedSubject = result;
                        _addedStudyMaterials = [];
                      });
                    },
                    currentSelectedItem: currentSelectedSubject,
                    width: boxConstraints.maxWidth),

            BottomSheetTextFieldContainer(
                hintText: UiUtils.getTranslatedLabel(context, chapterNameKey),
                margin: EdgeInsets.only(bottom: 20),
                maxLines: 1,
                contentPadding: EdgeInsetsDirectional.only(start: 15),
                textEditingController: _lessonNameTextEditingController),
            BottomSheetTextFieldContainer(
                margin: EdgeInsets.only(bottom: 20),
                hintText:
                    UiUtils.getTranslatedLabel(context, chapterDescriptionKey),
                maxLines: 3,
                contentPadding: EdgeInsetsDirectional.only(start: 15),
                textEditingController: _lessonDescriptionTextEditingController),

            //
            widget.editLesson
                ? Column(
                    children: widget.lesson!.studyMaterials
                        .map((studyMaterial) => StudyMaterialContainer(
                            studyMaterial: studyMaterial))
                        .toList(),
                  )
                : SizedBox(),

            BottomsheetAddFilesDottedBorderContainer(
                onTap: () async {
                  FocusScope.of(context).unfocus();
                  UiUtils.showBottomSheet(
                      child: AddStudyMaterialBottomsheet(
                          editFileDetails: false,
                          onTapSubmit: _addStudyMaterial),
                      context: context);
                },
                title: UiUtils.getTranslatedLabel(context, studyMaterialsKey)),
            SizedBox(
              height: 20,
            ),

            ...List.generate(_addedStudyMaterials.length, (index) => index)
                .map((index) => AddedFileContainer(
                    onDelete: (index) {
                      _addedStudyMaterials.removeAt(index);
                      setState(() {});
                    },
                    onEdit: (index, file) {
                      _addedStudyMaterials[index] = file;
                      setState(() {});
                    },
                    file: _addedStudyMaterials[index],
                    fileIndex: index))
                .toList(),

            widget.editLesson
                ? BlocConsumer<EditLessonCubit, EditLessonState>(
                    listener: (context, state) {
                      if (state is EditLessonSuccess) {
                        Navigator.of(context).pop(true);
                      } else if (state is EditLessonFailure) {
                        UiUtils.showErrorMessageContainer(
                            context: context,
                            errorMessage: UiUtils.getErrorMessageFromErrorCode(
                                context, state.errorMessage),
                            backgroundColor:
                                Theme.of(context).colorScheme.error);
                      }
                    },
                    builder: (context, state) {
                      return Padding(
                        padding: EdgeInsets.symmetric(
                            horizontal: boxConstraints.maxWidth * (0.25)),
                        child: CustomRoundedButton(
                            onTap: () {
                              if (state is EditLessonInProgress) {
                                return;
                              }
                              editLesson();
                            },
                            child: state is EditLessonInProgress
                                ? CustomCircularProgressIndicator(
                                    strokeWidth: 2,
                                    widthAndHeight: 20,
                                  )
                                : null,
                            height: 45,
                            widthPercentage: boxConstraints.maxWidth * (0.45),
                            backgroundColor:
                                Theme.of(context).colorScheme.primary,
                            buttonTitle: UiUtils.getTranslatedLabel(
                                context, editLessonKey),
                            showBorder: false),
                      );
                    },
                  )
                : BlocConsumer<CreateLessonCubit, CreateLessonState>(
                    listener: (context, state) {
                      if (state is CreateLessonSuccess) {
                        _lessonDescriptionTextEditingController.text = "";
                        _lessonNameTextEditingController.text = "";
                        _addedStudyMaterials = [];
                        setState(() {});
                        UiUtils.showErrorMessageContainer(
                            context: context,
                            errorMessage: UiUtils.getTranslatedLabel(
                                context, lessonAddedKey),
                            backgroundColor:
                                Theme.of(context).colorScheme.onPrimary);
                      } else if (state is CreateLessonFailure) {
                        UiUtils.showErrorMessageContainer(
                            context: context,
                            errorMessage: UiUtils.getErrorMessageFromErrorCode(
                                context, state.errorMessage),
                            backgroundColor:
                                Theme.of(context).colorScheme.error);
                      }
                    },
                    builder: (context, state) {
                      return Padding(
                        padding: EdgeInsets.symmetric(
                            horizontal: boxConstraints.maxWidth * (0.25)),
                        child: CustomRoundedButton(
                            onTap: () {
                              //
                              if (state is CreateLessonInProgress) {
                                return;
                              }
                              createLesson();
                            },
                            child: state is CreateLessonInProgress
                                ? CustomCircularProgressIndicator(
                                    strokeWidth: 2,
                                    widthAndHeight: 20,
                                  )
                                : null,
                            height: 45,
                            widthPercentage: boxConstraints.maxWidth * (0.45),
                            backgroundColor:
                                Theme.of(context).colorScheme.primary,
                            buttonTitle: UiUtils.getTranslatedLabel(
                                context, addLessonKey),
                            showBorder: false),
                      );
                    },
                  ),
          ],
        );
      }),
    );
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () {
        if (context.read<CreateLessonCubit>().state is CreateLessonInProgress) {
          return Future.value(false);
        }
        if (context.read<EditLessonCubit>().state is EditLessonInProgress) {
          return Future.value(false);
        }
        return Future.value(true);
      },
      child: Scaffold(
          body: Stack(
        children: [
          _buildAddOrEditLessonForm(),
          _buildAppbar(),
        ],
      )),
    );
  }
}
