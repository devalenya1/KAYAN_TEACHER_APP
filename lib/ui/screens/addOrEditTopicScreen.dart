import 'package:eschool_teacher/cubits/lessonsCubit.dart';
import 'package:eschool_teacher/cubits/myClassesCubit.dart';
import 'package:eschool_teacher/cubits/subjectsOfClassSectionCubit.dart';
import 'package:eschool_teacher/data/models/lesson.dart';
import 'package:eschool_teacher/data/models/pickedStudyMaterial.dart';
import 'package:eschool_teacher/data/models/studyMaterial.dart';
import 'package:eschool_teacher/data/models/subject.dart';
import 'package:eschool_teacher/data/models/topic.dart';
import 'package:eschool_teacher/data/repositories/lessonRepository.dart';
import 'package:eschool_teacher/data/repositories/teacherRepository.dart';
import 'package:eschool_teacher/ui/widgets/classSubjectsDropDownMenu.dart';
import 'package:eschool_teacher/ui/widgets/customAppbar.dart';
import 'package:eschool_teacher/ui/widgets/customDropDownMenu.dart';
import 'package:eschool_teacher/ui/widgets/defaultDropDownLabelContainer.dart';
import 'package:eschool_teacher/ui/widgets/myClassesDropDownMenu.dart';
import 'package:eschool_teacher/utils/labelKeys.dart';
import 'package:eschool_teacher/utils/uiUtils.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class AddOrEditTopicScreen extends StatefulWidget {
  final bool editTopic;
  final Lesson? lesson;
  final Subject? subject;
  final Topic? topic;

  AddOrEditTopicScreen(
      {Key? key,
      required this.editTopic,
      this.lesson,
      required this.subject,
      this.topic})
      : super(key: key);

  static Route<dynamic> route(RouteSettings routeSettings) {
    final arguments = routeSettings.arguments as Map<String, dynamic>;
    return CupertinoPageRoute(
        builder: (_) => MultiBlocProvider(
                providers: [
                  BlocProvider(
                    create: (context) => LessonsCubit(LessonRepository()),
                  ),
                  BlocProvider(
                    create: (context) =>
                        SubjectsOfClassSectionCubit(TeacherRepository()),
                  ),
                ],
                child: AddOrEditTopicScreen(
                  editTopic: arguments['editTopic'],
                  subject: arguments['subject'],
                  lesson: arguments['lesson'],
                  topic: arguments['topic'],
                )));
  }

  @override
  State<AddOrEditTopicScreen> createState() => _AddOrEditTopicScreenState();
}

class _AddOrEditTopicScreenState extends State<AddOrEditTopicScreen> {
  late String currentSelectedClassSection = widget.editTopic
      ? context
          .read<MyClassesCubit>()
          .getClassSectionDetailsById(widget.lesson!.classSectionId)
          .getClassSectionName()
      : context.read<MyClassesCubit>().getClassSectionName().first;

  late String currentSelectedSubject =
      UiUtils.getTranslatedLabel(context, fetchingSubjectsKey);

  late String currentSelectedLesson =
      UiUtils.getTranslatedLabel(context, fetchingLessonsKey);

  late TextEditingController _topicNameTextEditingController =
      TextEditingController(
          text: widget.editTopic ? widget.lesson!.name : null);
  late TextEditingController _topicDescriptionTextEditingController =
      TextEditingController(
          text: widget.editTopic ? widget.lesson!.description : null);

  List<PickedStudyMaterial> _addedStudyMaterials = [];

  late List<StudyMaterial> studyMaterials =
      widget.editTopic ? widget.topic!.studyMaterials : [];

  //This will determine if need to refresh the previous page
  //topics data. If teacher remove the the any study material
  //so we need to fetch the list again
  late bool refreshLessonsInPreviousPage = false;

  @override
  void initState() {
    if (!widget.editTopic) {
      context.read<SubjectsOfClassSectionCubit>().fetchSubjects(context
          .read<MyClassesCubit>()
          .getClassSectionDetails(classSectionName: currentSelectedClassSection)
          .id);
    }

    super.initState();
  }

  Widget _buildClassSubjectAndLessonDropDowns() {
    return LayoutBuilder(builder: (context, boxConstraints) {
      return Column(
        children: [
          MyClassesDropDownMenu(
              currentSelectedItem: currentSelectedClassSection,
              width: boxConstraints.maxWidth,
              changeSelectedItem: (value) {
                currentSelectedClassSection = value;
                context.read<LessonsCubit>().updateState(LessonsInitial());
                setState(() {});
              }),
          ClassSubjectsDropDownMenu(
              changeSelectedItem: (result) {
                setState(() {
                  currentSelectedSubject = result;
                });
                final subjectId = context
                    .read<SubjectsOfClassSectionCubit>()
                    .getSubjectIdByName(currentSelectedSubject);
                if (subjectId != -1) {
                  context.read<LessonsCubit>().fetchLessons(
                      classSectionId: context
                          .read<MyClassesCubit>()
                          .getClassSectionDetails(
                              classSectionName: currentSelectedClassSection)
                          .id,
                      subjectId: subjectId);
                }
              },
              currentSelectedItem: currentSelectedSubject,
              width: boxConstraints.maxWidth),
          //

          BlocConsumer<LessonsCubit, LessonsState>(builder: (context, state) {
            return state is LessonsFetchSuccess
                ? state.lessons.isEmpty
                    ? DefaultDropDownLabelContainer(
                        titleLabelKey:
                            UiUtils.getTranslatedLabel(context, noLessonsKey),
                        width: boxConstraints.maxWidth)
                    : CustomDropDownMenu(
                        width: boxConstraints.maxWidth,
                        onChanged: (value) {
                          currentSelectedLesson = value!;
                          setState(() {});
                        },
                        menu: state.lessons.map((e) => e.name).toList(),
                        currentSelectedItem: currentSelectedLesson)
                : DefaultDropDownLabelContainer(
                    titleLabelKey: fetchingLessonsKey,
                    width: boxConstraints.maxWidth);
          }, listener: (context, state) {
            if (state is LessonsFetchSuccess) {
              if (state.lessons.isNotEmpty) {
                setState(() {
                  currentSelectedLesson = state.lessons.first.name;
                });
              }
            }
          }),
        ],
      );
    });
  }

  Widget _buildAppbar() {
    return Align(
      alignment: Alignment.topCenter,
      child: CustomAppBar(
          onPressBackButton: () {
            Navigator.of(context).pop(refreshLessonsInPreviousPage);
          },
          title: UiUtils.getTranslatedLabel(
              context, widget.editTopic ? editTopicKey : addTopicKey)),
    );
  }

  Widget _buildAddOrEditTopicForm() {
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
      child: Column(
        children: [_buildClassSubjectAndLessonDropDowns()],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Stack(
      children: [
        _buildAddOrEditTopicForm(),
        _buildAppbar(),
      ],
    ));
  }
}
