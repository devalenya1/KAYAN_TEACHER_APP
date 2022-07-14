import 'package:eschool_teacher/cubits/assignmentCubit.dart';
import 'package:eschool_teacher/cubits/myClassesCubit.dart';
import 'package:eschool_teacher/cubits/subjectsOfClassSectionCubit.dart';
import 'package:eschool_teacher/ui/widgets/customDropDownMenu.dart';
import 'package:eschool_teacher/ui/widgets/defaultDropDownLabelContainer.dart';
import 'package:eschool_teacher/utils/labelKeys.dart';
import 'package:eschool_teacher/utils/uiUtils.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ClassSubjectsDropDownMenu extends StatelessWidget {
  final String currentSelectedItem;

  final Function(String) changeSelectedItem;

  final double width;
  const ClassSubjectsDropDownMenu(
      {Key? key,
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
        }
      },
      builder: (context, state) {
        return CustomDropDownMenu(
            width: width,
            onChanged: (result) {
              changeSelectedItem(result!);

              //TODO: Fetch chapters if based on condition
            },
            menu: state is SubjectsOfClassSectionFetchSuccess
                ? state.subjects.map((e) => e.name).toList()
                : [UiUtils.getTranslatedLabel(context, fetchingSubjectsKey)],
            currentSelectedItem: currentSelectedItem);
      },
    );
  }
}
