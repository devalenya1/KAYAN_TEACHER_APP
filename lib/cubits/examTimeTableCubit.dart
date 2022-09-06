import 'package:eschool_teacher/data/models/exam.dart';
import 'package:flutter_bloc/flutter_bloc.dart';


import '../data/repositories/studentRepository.dart';
abstract class ExamTimeTableState {}

class ExamTimeTableInitial extends ExamTimeTableState {}

class ExamTimeTableFetchSuccess extends ExamTimeTableState {
  final List<ExamTimeTable> examTimeTableList;

  ExamTimeTableFetchSuccess({required this.examTimeTableList});
}

class ExamTimeTableFetchFailure extends ExamTimeTableState {
  final String errorMessage;

  ExamTimeTableFetchFailure(this.errorMessage);
}

class ExamTimeTableFetchInProgress extends ExamTimeTableState {}

class ExamTimeTableCubit extends Cubit<ExamTimeTableState> {
  final StudentRepository _studentRepository;

  ExamTimeTableCubit(this._studentRepository) : super(ExamTimeTableInitial());

  void fetchStudentExamsList(
      {required int examID}) {
    emit(ExamTimeTableFetchInProgress());
    _studentRepository
        .fetchExamTimeTable(
        examId: examID, )
        .then((value) =>
        emit(ExamTimeTableFetchSuccess(examTimeTableList: value)))
        .catchError((e) => emit(ExamTimeTableFetchFailure(e.toString())));
  }
}
