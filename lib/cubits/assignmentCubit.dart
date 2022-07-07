import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:eschool_teacher/data/models/assignment.dart';
import 'package:eschool_teacher/data/repositories/assignmentRepository.dart';

abstract class AssignmentState {}

class AssignmentInitial extends AssignmentState {}

class AssignmentFetchInProgress extends AssignmentState {}

class AssignmentFetchSuccess extends AssignmentState {
  final List<Assignment> assignment;
  final int totalPage;
  final int currentPage;
  final bool moreAssignmentsFetchError;
  final bool fetchMoreAssignmentsInProgress;
  AssignmentFetchSuccess({
    required this.assignment,
    required this.totalPage,
    required this.currentPage,
    required this.moreAssignmentsFetchError,
    required this.fetchMoreAssignmentsInProgress,
  });
  AssignmentFetchSuccess copywith({
    final List<Assignment>? newAssignment,
    final int? newTotalPage,
    final int? newCurrentPage,
    final bool? newMoreAssignmentsFetchError,
    final bool? NewFetchMoreAssignmentsInProgress,
  }) {
    return AssignmentFetchSuccess(
        assignment: newAssignment ?? assignment,
        totalPage: newTotalPage ?? totalPage,
        currentPage: newCurrentPage ?? currentPage,
        moreAssignmentsFetchError:
            newMoreAssignmentsFetchError ?? moreAssignmentsFetchError,
        fetchMoreAssignmentsInProgress: NewFetchMoreAssignmentsInProgress ??
            fetchMoreAssignmentsInProgress);
  }
}

class AssignmentFetchFailure extends AssignmentState {
  final String errorMessage;
  AssignmentFetchFailure(this.errorMessage);
}

class AssignmentCubit extends Cubit<AssignmentState> {
  final AssignmentRepository _assignmentRepository;

  AssignmentCubit(this._assignmentRepository) : super(AssignmentInitial());

  void fetchassignment({
    required String classSectionId,
    required String subjectId,
    int? page,
  }) async {
    try {
      emit(AssignmentFetchInProgress());
      await _assignmentRepository
          .fetchassignment(
            classSectionId: classSectionId,
            subjectId: subjectId,
            page: page,
          )
          .then((result) => emit(
                AssignmentFetchSuccess(
                    assignment: result['assignment'],
                    currentPage: result["currentPage"],
                    totalPage: result["lastPage"],
                    moreAssignmentsFetchError: false,
                    fetchMoreAssignmentsInProgress: false),
              ))
          .catchError((e) {});
    } catch (e) {
      return emit(
        AssignmentFetchFailure(e.toString()),
      );
    }
    ;
  }

  bool hasMore() {
    if (state is AssignmentFetchSuccess) {
      return (state as AssignmentFetchSuccess).currentPage <
          (state as AssignmentFetchSuccess).totalPage;
    }
    return false;
  }

  void fetchMoreAssignment({
    required String classSectionId,
    required String subjectId,
  }) async {
    try {
      emit((state as AssignmentFetchSuccess)
          .copywith(NewFetchMoreAssignmentsInProgress: true));

      final fetchMoreAssignment = await _assignmentRepository.fetchassignment(
        classSectionId: classSectionId,
        subjectId: subjectId,
        //page: (state as AssignmentFetchSuccess).currentPage + 1,
      );

      final currentState = (state as AssignmentFetchSuccess);

      List<Assignment> assignments = currentState.assignment;

      assignments.addAll(fetchMoreAssignment['assignment']);

      emit(AssignmentFetchSuccess(
          assignment: assignments,
          totalPage: fetchMoreAssignment['lastPage'],
          currentPage: fetchMoreAssignment["currentPage"],
          moreAssignmentsFetchError: false,
          fetchMoreAssignmentsInProgress: false));
    } catch (e) {
      emit((state as AssignmentFetchSuccess).copywith(
          newMoreAssignmentsFetchError: true,
          NewFetchMoreAssignmentsInProgress: false));
      // throw ApiException(e.toString());
    }
  }

  // void deleteAssignment({
  //   required int assignmentId,
  // }) async {
  //   try {
  //     emit(AssignmentFetchInProgress());
  //     await _assignmentRepository.deleteAssignment(assignmentId: assignmentId);

  //     emit(AssignmentFetchSuccess(
  //         assignment: [],
  //         currentPage: 0,
  //         fetchMoreAssignmentsInProgress: false,
  //         moreAssignmentsFetchError: false,
  //         totalPage: 0));
  //   } catch (e) {
  //     emit(AssignmentFetchFailure(e.toString()));
  //   }
  // }
}
