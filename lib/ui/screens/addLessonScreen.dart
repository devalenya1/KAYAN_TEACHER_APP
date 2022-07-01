import 'package:eschool_teacher/cubits/myClassesCubit.dart';
import 'package:eschool_teacher/cubits/subjectsOfClassSectionCubit.dart';
import 'package:eschool_teacher/data/models/pickedStudyMaterial.dart';
import 'package:eschool_teacher/data/repositories/teacherRepository.dart';
import 'package:eschool_teacher/ui/styles/colors.dart';
import 'package:eschool_teacher/ui/widgets/addStudyMaterialBottomSheet.dart';
import 'package:eschool_teacher/ui/widgets/addedFileContainer.dart';
import 'package:eschool_teacher/ui/widgets/bottomSheetTextFiledContainer.dart';
import 'package:eschool_teacher/ui/widgets/classSubjectsDropDownMenu.dart';
import 'package:eschool_teacher/ui/widgets/customAppbar.dart';
import 'package:eschool_teacher/ui/widgets/customRoundedButton.dart';
import 'package:eschool_teacher/ui/widgets/myClassesDropDownMenu.dart';
import 'package:eschool_teacher/utils/labelKeys.dart';
import 'package:eschool_teacher/utils/uiUtils.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class AddLessonScreen extends StatefulWidget {
  AddLessonScreen({Key? key}) : super(key: key);

  static Route<dynamic> route(RouteSettings routeSettings) {
    return CupertinoPageRoute(
        builder: (_) => BlocProvider(
              create: (context) =>
                  SubjectsOfClassSectionCubit(TeacherRepository()),
              child: AddLessonScreen(),
            ));
  }

  @override
  State<AddLessonScreen> createState() => _AddLessonScreenState();
}

class _AddLessonScreenState extends State<AddLessonScreen> {
  late String currentSelectedClassSection =
      context.read<MyClassesCubit>().getClassSectionName().first;

  late String currentSelectedSubject =
      UiUtils.getTranslatedLabel(context, selectSubjectKey);

  TextEditingController _lessonNameTextEditingController =
      TextEditingController();
  TextEditingController _lessonDescriptionTextEditingController =
      TextEditingController();

  List<PickedStudyMaterial> _addedStudyMaterials = [];

  @override
  void initState() {
    context.read<SubjectsOfClassSectionCubit>().fetchSubjects(context
        .read<MyClassesCubit>()
        .getClassSectionDetails(classSectionName: currentSelectedClassSection)
        .id);
    super.initState();
  }

  void _addStudyMaterial(PickedStudyMaterial pickedStudyMaterial) {
    setState(() {
      _addedStudyMaterials.add(pickedStudyMaterial);
    });
  }

  Widget _buildAppbar() {
    return Align(
      alignment: Alignment.topCenter,
      child: CustomAppBar(
          title: UiUtils.getTranslatedLabel(context, addLessonKey)),
    );
  }

  Widget _buildAddLessonForm() {
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
            MyClassesDropDownMenu(
                currentSelectedItem: currentSelectedClassSection,
                width: boxConstraints.maxWidth,
                changeSelectedItem: (result) {
                  setState(() {
                    currentSelectedClassSection = result;
                    _addedStudyMaterials = [];
                  });
                }),

            //
            ClassSubjectsDropDownMenu(
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

            Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Text(
                  UiUtils.getTranslatedLabel(context, studyMaterialsKey),
                  style: TextStyle(
                      fontSize: 17,
                      color: hintTextColor,
                      fontWeight: FontWeight.w500),
                ),
                Spacer(),
                Transform.translate(
                  offset: Offset(0, 2),
                  child: GestureDetector(
                    onTap: () {
                      UiUtils.showBottomSheet(
                          child: AddStudyMaterialBottomsheet(
                              editFileDetails: false,
                              onTapSubmit: _addStudyMaterial),
                          context: context);
                    },
                    child: CircleAvatar(
                      child: Icon(
                        Icons.add,
                        color: Theme.of(context).scaffoldBackgroundColor,
                      ),
                      radius: 15,
                      backgroundColor: Theme.of(context).colorScheme.primary,
                    ),
                  ),
                )
              ],
            ),
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

            Padding(
              padding: EdgeInsets.symmetric(
                  horizontal: boxConstraints.maxWidth * (0.25)),
              child: CustomRoundedButton(
                  height: 40,
                  widthPercentage: boxConstraints.maxWidth * (0.35),
                  backgroundColor: Theme.of(context).colorScheme.primary,
                  buttonTitle: UiUtils.getTranslatedLabel(context, submitKey),
                  showBorder: false),
            ),
          ],
        );
      }),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Stack(
      children: [
        _buildAddLessonForm(),
        _buildAppbar(),
      ],
    ));
  }
}
