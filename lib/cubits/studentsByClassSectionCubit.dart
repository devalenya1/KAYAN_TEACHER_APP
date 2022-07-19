import 'package:eschool_teacher/data/models/student.dart';
import 'package:eschool_teacher/data/repositories/studentRepository.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

abstract class StudentsByClassSectionState {}

class StudentsByClassSectionInitial extends StudentsByClassSectionState {}

class StudentsByClassSectionFetchInProgress
    extends StudentsByClassSectionState {}

class StudentsByClassSectionFetchSuccess extends StudentsByClassSectionState {
  final int totalPage;
  final int currentPage;
  final bool moreStudentsFetchError;
  final bool fetchMoreStudentsInProgress;
  final List<Student> students;

  StudentsByClassSectionFetchSuccess(
      {required this.currentPage,
      required this.fetchMoreStudentsInProgress,
      required this.moreStudentsFetchError,
      required this.students,
      required this.totalPage});

  StudentsByClassSectionFetchSuccess copyWith(
      {List<Student>? newStudents,
      bool? newFetchMoreStudentsInProgress,
      bool? newMoreStudentsFetchError,
      int? newCurrentPage,
      int? newTotalPage}) {
    return StudentsByClassSectionFetchSuccess(
        fetchMoreStudentsInProgress:
            newFetchMoreStudentsInProgress ?? fetchMoreStudentsInProgress,
        moreStudentsFetchError:
            newMoreStudentsFetchError ?? moreStudentsFetchError,
        students: newStudents ?? students,
        currentPage: newCurrentPage ?? currentPage,
        totalPage: newTotalPage ?? totalPage);
  }
}

class StudentsByClassSectionFetchFailure extends StudentsByClassSectionState {
  final String errorMessage;

  StudentsByClassSectionFetchFailure(this.errorMessage);
}

class StudentsByClassSectionCubit extends Cubit<StudentsByClassSectionState> {
  final StudentRepository _studentRepository;

  StudentsByClassSectionCubit(this._studentRepository)
      : super(StudentsByClassSectionInitial());

  void fetchStudents({required int classSectionId}) async {
    emit(StudentsByClassSectionFetchInProgress());
    try {
      final result = await _studentRepository.getStudentsByClassSection(
          classSectionId: classSectionId);

      emit(StudentsByClassSectionFetchSuccess(
          students: result['students'],
          fetchMoreStudentsInProgress: false,
          moreStudentsFetchError: false,
          currentPage: result['currentPage'],
          totalPage: result['totalPage']));
    } catch (e) {
      emit(StudentsByClassSectionFetchFailure(e.toString()));
    }
  }

  bool hasMore() {
    if (state is StudentsByClassSectionFetchSuccess) {
      return (state as StudentsByClassSectionFetchSuccess).currentPage <
          (state as StudentsByClassSectionFetchSuccess).totalPage;
    }
    return false;
  }

  void fetchMoreStudents({required int classSectionId}) async {
    if (state is StudentsByClassSectionFetchSuccess) {
      if ((state as StudentsByClassSectionFetchSuccess)
          .fetchMoreStudentsInProgress) {
        return;
      }
      try {
        emit((state as StudentsByClassSectionFetchSuccess)
            .copyWith(newFetchMoreStudentsInProgress: true));

        final moreStudentsResult =
            await _studentRepository.getStudentsByClassSection(
          classSectionId: classSectionId,
          page: (state as StudentsByClassSectionFetchSuccess).currentPage + 1,
        );

        final currentState = (state as StudentsByClassSectionFetchSuccess);
        List<Student> students = currentState.students;

        students.addAll(moreStudentsResult['students']);

        emit(StudentsByClassSectionFetchSuccess(
            fetchMoreStudentsInProgress: false,
            students: students,
            moreStudentsFetchError: false,
            currentPage: moreStudentsResult['currentPage'],
            totalPage: moreStudentsResult['totalPage']));
      } catch (e) {
        emit((state as StudentsByClassSectionFetchSuccess).copyWith(
            newFetchMoreStudentsInProgress: false,
            newMoreStudentsFetchError: true));
      }
    }
  }
}
