import 'package:cached_network_image/cached_network_image.dart';
import 'package:eschool_teacher/app/routes.dart';
import 'package:eschool_teacher/cubits/studentsByClassSectionCubit.dart';
import 'package:eschool_teacher/data/models/classSectionDetails.dart';
import 'package:eschool_teacher/data/models/student.dart';
import 'package:eschool_teacher/ui/widgets/customShimmerContainer.dart';
import 'package:eschool_teacher/ui/widgets/errorContainer.dart';
import 'package:eschool_teacher/ui/widgets/shimmerLoadingContainer.dart';
import 'package:eschool_teacher/utils/labelKeys.dart';
import 'package:eschool_teacher/utils/uiUtils.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class StudentsContainer extends StatelessWidget {
  final ClassSectionDetails classSectionDetails;
  const StudentsContainer({Key? key, required this.classSectionDetails})
      : super(key: key);

  Widget _buildStudentContainer({
    required Student student,
    required BuildContext context,
  }) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 20),
      child: InkWell(
        borderRadius: BorderRadius.circular(10),
        onTap: () {
          Navigator.of(context)
              .pushNamed(Routes.studentDetails, arguments: student);
        },
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
          padding: EdgeInsets.symmetric(horizontal: 15, vertical: 12.5),
          child: LayoutBuilder(builder: (context, boxConstraints) {
            return Row(
              children: [
                Container(
                  decoration: BoxDecoration(
                      image: DecorationImage(
                          image: CachedNetworkImageProvider(student.image)),
                      borderRadius: BorderRadius.circular(7.5),
                      color: Theme.of(context).colorScheme.error),
                  height: 50,
                  width: boxConstraints.maxWidth * (0.2),
                ),
                SizedBox(
                  width: boxConstraints.maxWidth * (0.05),
                ),
                SizedBox(
                  width: boxConstraints.maxWidth * (0.65),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        student.getFullName(),
                        style: TextStyle(
                            color: Theme.of(context).colorScheme.secondary,
                            fontWeight: FontWeight.w600,
                            fontSize: 14.0),
                      ),
                      Text(
                          "${UiUtils.getTranslatedLabel(context, rollNoKey)} - ${student.rollNumber}",
                          style: TextStyle(
                              color: Theme.of(context)
                                  .colorScheme
                                  .secondary
                                  .withOpacity(0.75),
                              fontWeight: FontWeight.w400,
                              fontSize: 12.5),
                          textAlign: TextAlign.left)
                    ],
                  ),
                ),
              ],
            );
          }),
        ),
      ),
    );
  }

  Widget _buildStudentShimmerLoadContainer() {
    return LayoutBuilder(builder: (context, boxConstraints) {
      return Padding(
        padding: const EdgeInsets.only(bottom: 20),
        child: Row(
          children: [
            ShimmerLoadingContainer(
                child: CustomShimmerContainer(
              height: 50,
              width: boxConstraints.maxWidth * (0.2),
              borderRadius: 10,
            )),
            SizedBox(
              width: boxConstraints.maxWidth * (0.05),
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                ShimmerLoadingContainer(
                    child: CustomShimmerContainer(
                  width: boxConstraints.maxWidth * (0.5),
                  borderRadius: 10,
                )),
                SizedBox(
                  height: 10,
                ),
                ShimmerLoadingContainer(
                    child: CustomShimmerContainer(
                  width: boxConstraints.maxWidth * (0.35),
                  borderRadius: 10,
                )),
              ],
            ),
          ],
        ),
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<StudentsByClassSectionCubit,
        StudentsByClassSectionState>(
      builder: (context, state) {
        if (state is StudentsByClassSectionFetchSuccess) {
          return Column(
            children: List.generate(state.students.length, (index) => index)
                .map((studentIndex) => _buildStudentContainer(
                      student: state.students[studentIndex],
                      context: context,
                    ))
                .toList(),
          );
        }
        if (state is StudentsByClassSectionFetchFailure) {
          return ErrorContainer(
            errorMessageCode: UiUtils.getErrorMessageFromErrorCode(
                context, state.errorMessage),
            onTapRetry: () {
              context
                  .read<StudentsByClassSectionCubit>()
                  .fetchStudents(classSectionId: classSectionDetails.id);
            },
          );
        }

        return Column(
          children: List.generate(UiUtils.defaultShimmerLoadingContentCount,
              (index) => _buildStudentShimmerLoadContainer()).toList(),
        );
      },
    );
  }
}
