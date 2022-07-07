import 'package:eschool_teacher/cubits/assignmentCubit.dart';
import 'package:eschool_teacher/cubits/myClassesCubit.dart';
import 'package:eschool_teacher/cubits/subjectsOfClassSectionCubit.dart';
import 'package:eschool_teacher/ui/widgets/customDropDownMenu.dart';
import 'package:eschool_teacher/utils/labelKeys.dart';
import 'package:eschool_teacher/utils/uiUtils.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ClassSubjectsDropDownMenu extends StatelessWidget {
  final String currentSelectedItem;
  final String? SelectedClassId;
  final Function(String) changeSelectedItem;

  final double width;
  const ClassSubjectsDropDownMenu(
      {Key? key,
      this.SelectedClassId,
      required this.changeSelectedItem,
      required this.currentSelectedItem,
      required this.width})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<SubjectsOfClassSectionCubit,
        SubjectsOfClassSectionState>(
      listener: (context, state) {
        if (state is SubjectsOfClassSectionFetchSuccess) {
          changeSelectedItem(state.subjects.first.name);
        } else if (state is SubjectsOfClassSectionFetchInProgress) {
          changeSelectedItem(
              UiUtils.getTranslatedLabel(context, selectSubjectKey));
        }
      },
      builder: (context, state) {
        return CustomDropDownMenu(
            width: width,
            onChanged: (result) {
              changeSelectedItem(result!);

              //TODO: Fetch chapters if based on condition
              if (SelectedClassId!.isNotEmpty) {
                print(context
                    .read<MyClassesCubit>()
                    .getClassSectionDetails(classSectionName: SelectedClassId!)
                    .id
                    .toString());
                print(context
                    .read<SubjectsOfClassSectionCubit>()
                    .getSubjectIdByName(result)
                    .toString());
                var classid = context
                    .read<MyClassesCubit>()
                    .getClassSectionDetails(classSectionName: SelectedClassId!)
                    .id
                    .toString();
                var sujectid = context
                    .read<SubjectsOfClassSectionCubit>()
                    .getSubjectIdByName(result)
                    .toString();
                context.read<AssignmentCubit>().fetchassignment(
                      classSectionId: classid,
                      subjectId: sujectid,
                    );
              }
              ;
            },
            menu: state is SubjectsOfClassSectionFetchSuccess
                ? state.subjects.map((e) => e.name).toList()
                : [UiUtils.getTranslatedLabel(context, selectSubjectKey)],
            currentSelectedItem: currentSelectedItem);
      },
    );
  }
}
