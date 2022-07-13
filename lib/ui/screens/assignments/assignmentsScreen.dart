import 'package:eschool_teacher/app/routes.dart';
import 'package:eschool_teacher/cubits/assignmentCubit.dart';
import 'package:eschool_teacher/cubits/myClassesCubit.dart';
import 'package:eschool_teacher/cubits/subjectsOfClassSectionCubit.dart';
import 'package:eschool_teacher/data/repositories/assignmentRepository.dart';
import 'package:eschool_teacher/data/repositories/teacherRepository.dart';
import 'package:eschool_teacher/ui/screens/addAssignmentScreen.dart';
import 'package:eschool_teacher/ui/screens/assignments/widgets/assignmentContainer.dart';
import 'package:eschool_teacher/ui/widgets/classSubjectsDropDownMenu.dart';
import 'package:eschool_teacher/ui/widgets/customAppbar.dart';
import 'package:eschool_teacher/ui/widgets/customFloatingActionButton.dart';
import 'package:eschool_teacher/ui/widgets/customShimmerContainer.dart';
import 'package:eschool_teacher/ui/widgets/errorContainer.dart';
import 'package:eschool_teacher/ui/widgets/myClassesDropDownMenu.dart';
import 'package:eschool_teacher/ui/widgets/shimmerLoadingContainer.dart';
import 'package:eschool_teacher/utils/labelKeys.dart';
import 'package:eschool_teacher/utils/uiUtils.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class AssignmentsScreen extends StatefulWidget {
  AssignmentsScreen({Key? key}) : super(key: key);

  static Route<dynamic> route(RouteSettings routeSettings) {
    return CupertinoPageRoute(
        builder: (_) => MultiBlocProvider(providers: [
              BlocProvider<SubjectsOfClassSectionCubit>(
                create: (context) => SubjectsOfClassSectionCubit(
                  TeacherRepository(),
                ),
              ),
              BlocProvider<AssignmentCubit>(
                  create: (context) => AssignmentCubit(
                        AssignmentRepository(),
                      )),
            ], child: AssignmentsScreen()));
  }

  @override
  State<AssignmentsScreen> createState() => _AssignmentsScreenState();
}

class _AssignmentsScreenState extends State<AssignmentsScreen> {
  late ScrollController _scrollController = ScrollController()
    ..addListener(_subjectAnnouncementScrollListener);

  void _subjectAnnouncementScrollListener() {
    if (_scrollController.offset ==
        _scrollController.position.maxScrollExtent) {
      if (context.read<AssignmentCubit>().hasMore()) {
        context.read<AssignmentCubit>().fetchMoreAssignment(
              classSectionId: context
                  .read<MyClassesCubit>()
                  .getClassSectionDetails(classSectionName: selectClassId)
                  .id
                  .toString(),
              subjectId: context
                  .read<SubjectsOfClassSectionCubit>()
                  .getSubjectIdByName(selectSubjectId)
                  .toString(),
            );
      }
    }
  }

  late String currentSelectedClassSection =
      context.read<MyClassesCubit>().getClassSectionName().first;

  late String currentSelectedSubject =
      UiUtils.getTranslatedLabel(context, selectSubjectKey);

  late var selectClassId = "";
  late var selectSubjectId = "";
  Widget _buildAppbar() {
    return Align(
      alignment: Alignment.topCenter,
      child: CustomAppBar(
          title: UiUtils.getTranslatedLabel(context, assignmentsKey)),
    );
  }

  Widget _buildAssignmentFilters() {
    return LayoutBuilder(builder: (context, boxConstraints) {
      return Column(
        children: [
          MyClassesDropDownMenu(
              currentSelectedItem: currentSelectedClassSection,
              width: boxConstraints.maxWidth,
              changeSelectedItem: (result) {
                setState(() {
                  currentSelectedClassSection = result;
                  print(currentSelectedClassSection);
                });
              }),
          ClassSubjectsDropDownMenu(
            changeSelectedItem: (result) {
              if (currentSelectedSubject != subjectNameKey)
                setState(() {
                  currentSelectedSubject = result;
                  print(currentSelectedSubject);
                });
            },
            currentSelectedItem: currentSelectedSubject,
            width: boxConstraints.maxWidth,
            SelectedClassId: currentSelectedClassSection,
          )
        ],
      );
    });
  }

  Widget _buildInformationShimmerLoadingContainer() {
    return Container(
      margin: EdgeInsets.only(
        bottom: 15,
      ),
      height: 80,
      child: LayoutBuilder(builder: (context, boxConstraints) {
        return Row(
          children: [
            ShimmerLoadingContainer(
                child: CustomShimmerContainer(
              height: 60,
              width: boxConstraints.maxWidth * (0.225),
            )),
            SizedBox(
              width: boxConstraints.maxWidth * (0.05),
            ),
            ShimmerLoadingContainer(
                child: CustomShimmerContainer(
              width: boxConstraints.maxWidth * (0.475),
            )),
            Spacer(),
            ShimmerLoadingContainer(
                child: CustomShimmerContainer(
              borderRadius: boxConstraints.maxWidth * (0.035),
              height: boxConstraints.maxWidth * (0.07),
              width: boxConstraints.maxWidth * (0.07),
            )),
          ],
        );
      }),
    );
  }

  Widget _buildAssignmentList() {
    return SingleChildScrollView(
      controller: _scrollController,
      padding: EdgeInsets.only(
          left: MediaQuery.of(context).size.width * (0.075),
          right: MediaQuery.of(context).size.width * (0.075),
          top: UiUtils.getScrollViewTopPadding(
              context: context,
              appBarHeightPercentage: UiUtils.appBarSmallerHeightPercentage)),
      child: Column(
        children: [
          _buildAssignmentFilters(),
          SizedBox(
            height: 10,
          ),
          BlocBuilder<AssignmentCubit, AssignmentState>(
            builder: (context, state) {
              if (state is AssignmentsFetchSuccess) {
                if ((state).assignment.isEmpty) {
                  return Center(
                    child: Text("Assignment No Found"),
                  );
                }

                return SingleChildScrollView(
                  child: Column(
                    children: List.generate(
                      state.assignment.length,
                      (index) => AssignmentContainer(
                        assignment: state.assignment[index],
                      ),
                    ),
                  ),
                );
              }

              if (state is AssignmentFetchInProgress) {
                return Column(
                    children: List.generate(5, (index) {
                  return _buildInformationShimmerLoadingContainer();
                }));
              }
              if (state is AssignmentFetchFailure) {
                return ErrorContainer(errorMessageCode: state.errorMessage);
              }
              return Container();
            },
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingActionAddButton(
        onTap: () {
          Navigator.of(context).pushNamed(Routes.addAssignment);
        },
      ),
      body: Stack(
        children: [
          _buildAssignmentList(),
          _buildAppbar(),
        ],
      ),
    );
  }
}
