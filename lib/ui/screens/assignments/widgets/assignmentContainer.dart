import 'package:eschool_teacher/cubits/assignmentCubit.dart';
import 'package:eschool_teacher/cubits/deleteassignmentcubit.dart';
import 'package:eschool_teacher/data/repositories/assignmentRepository.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:eschool_teacher/data/models/assignment.dart';
import 'package:eschool_teacher/ui/screens/assignments/widgets/assignmentDetailsBottomsheetContainer.dart';
import 'package:eschool_teacher/ui/widgets/dismissibleBackgroundContainer.dart';
import 'package:eschool_teacher/ui/widgets/dismissibleSecondaryBackgroundContainer.dart';
import 'package:eschool_teacher/utils/uiUtils.dart';

class AssignmentContainer extends StatefulWidget {
  final Assignment assignment;
  AssignmentContainer({
    Key? key,
    required this.assignment,
  }) : super(key: key);

  @override
  State<AssignmentContainer> createState() => _AssignmentContainerState();
}

class _AssignmentContainerState extends State<AssignmentContainer> {
  void showAssignmentBottomSheet() {
    UiUtils.showBottomSheet(
            enableDrag: true,
            child: BlocProvider<DeleteAssignmentCubit>(
              create: (context) =>
                  DeleteAssignmentCubit(AssignmentRepository()),
              child: AssignmentDetailsBottomsheetContainer(
                  assignment: widget.assignment),
            ),
            context: context)
        .then((value) {
      if (value != null) {
        context
            .read<AssignmentCubit>()
            .deleteAssignment(assignmentId: value["assignmentId"]);
      } else {
        print("value is null");
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(bottom: 20),
      child: GestureDetector(
        onTap: () {
          showAssignmentBottomSheet();
        },
        child: Dismissible(
          confirmDismiss: (direction) {
            if (direction == DismissDirection.endToStart) {
              print("Delete");
            } else if (direction == DismissDirection.startToEnd) {
              print("Edit");
            }
            return Future.value(false);
          },
          secondaryBackground: DismissibleSecondaryBackgroundContainer(),
          background: DismissibleBackgroundContainer(),
          key: Key("1"),
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
            width: MediaQuery.of(context).size.width * (0.85),
            padding: EdgeInsets.symmetric(horizontal: 17.5, vertical: 17.5),
            child: LayoutBuilder(builder: (context, boxConstraints) {
              return Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    widget.assignment.name.toString(),
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style: TextStyle(
                        color: Theme.of(context).colorScheme.secondary,
                        fontWeight: FontWeight.w400,
                        fontSize: 14.0),
                  ),
                  SizedBox(
                    height: 10.0,
                  ),
                  Text(widget.assignment.dueDate,
                      style: TextStyle(
                          color: Theme.of(context)
                              .colorScheme
                              .onBackground
                              .withOpacity(0.6),
                          fontWeight: FontWeight.w400,
                          fontSize: 11.0))
                ],
              );
            }),
          ),
        ),
      ),
    );
  }
}
