import 'package:eschool_teacher/app/routes.dart';
import 'package:eschool_teacher/cubits/assignmentCubit.dart';
import 'package:eschool_teacher/cubits/deleteassignmentcubit.dart';
import 'package:eschool_teacher/data/repositories/assignmentRepository.dart';
import 'package:eschool_teacher/ui/widgets/deleteButton.dart';
import 'package:eschool_teacher/ui/widgets/editButton.dart';
import 'package:eschool_teacher/utils/labelKeys.dart';
import 'package:flutter/material.dart';

import 'package:eschool_teacher/data/models/assignment.dart';
import 'package:eschool_teacher/ui/screens/assignments/widgets/assignmentDetailsBottomsheetContainer.dart';

import 'package:eschool_teacher/utils/uiUtils.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

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
        child: AssignmentDetailsBottomsheetContainer(
            assignment: widget.assignment),
        context: context);
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider<DeleteAssignmentCubit>(
      create: (context) => DeleteAssignmentCubit(
        AssignmentRepository(),
      ),
      child: Builder(builder: (context) {
        return BlocConsumer<DeleteAssignmentCubit, DeleteAssignmentState>(
          listener: (context, state) {
            if (state is DeleteAssignmentFetchSuccess) {
              context
                  .read<AssignmentCubit>()
                  .deleteAssignment(widget.assignment.id);
            } else if (state is DeleteAssignmentFetchFailure) {
              UiUtils.showBottomToastOverlay(
                  context: context,
                  errorMessage:
                      "${UiUtils.getTranslatedLabel(context, unableToDeleteAssignmentKey)}",
                  backgroundColor: Theme.of(context).colorScheme.error);
            }
          },
          builder: (context, state) {
            return Padding(
                padding: EdgeInsets.only(bottom: 20),
                child: GestureDetector(
                    onTap: () {
                      showAssignmentBottomSheet();
                    },
                    child: Opacity(
                      opacity:
                          state is DeleteAssignmentFetchInProgress ? 0.5 : 1.0,
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
                        padding: EdgeInsets.symmetric(
                            horizontal: 17.5, vertical: 17.5),
                        child:
                            LayoutBuilder(builder: (context, boxConstraints) {
                          return Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Row(
                                children: [
                                  Text(
                                    widget.assignment.name.toString(),
                                    maxLines: 1,
                                    overflow: TextOverflow.ellipsis,
                                    style: TextStyle(
                                        color: Theme.of(context)
                                            .colorScheme
                                            .secondary,
                                        fontWeight: FontWeight.w400,
                                        fontSize: 14.0),
                                  ),
                                  Spacer(),
                                  EditButton(onTap: () {
                                    Navigator.of(context).pushNamed<bool?>(
                                      Routes.addAssignment,
                                      arguments: {
                                        "editAssignment": true,
                                        "assignment": widget.assignment,
                                      },
                                    ).then((value) {
                                      if (value != null && value) {
                                        context
                                            .read<AssignmentCubit>()
                                            .fetchassignment(
                                              classSectionId: widget
                                                  .assignment.classSectionId,
                                              subjectId:
                                                  widget.assignment.subjectId,
                                            );
                                      }
                                    });
                                  }),
                                  SizedBox(
                                    width: 10,
                                  ),
                                  DeleteButton(
                                    onTap: () {
                                      if (state
                                          is DeleteAssignmentFetchInProgress) {
                                        return;
                                      }
                                      context
                                          .read<DeleteAssignmentCubit>()
                                          .deleteAssignment(
                                              assignmentId:
                                                  widget.assignment.id);
                                    },
                                  ),
                                ],
                              ),
                              SizedBox(
                                height: 10.0,
                              ),
                              Text(widget.assignment.dueDate.toString(),
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
                    )));
          },
        );
      }),
    );
  }
}
