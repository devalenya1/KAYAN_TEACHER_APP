import 'package:eschool_teacher/data/repositories/createAssignmentRepository.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

abstract class createAssignmentState {}

class createAssignmentInitial extends createAssignmentState {}

class createAssignmentInProcess extends createAssignmentState {}

class createAssignmentSuccess extends createAssignmentState {}

class createAssignmentFailure extends createAssignmentState {
  final String errormessage;
  createAssignmentFailure({
    required this.errormessage,
  });
}

class CreateAssignmentCubit extends Cubit<createAssignmentState> {
  final CreateAssignmentRepository _createAssignmmentRepository;

  CreateAssignmentCubit(this._createAssignmmentRepository)
      : super(createAssignmentInitial());

  void createAssignment({
    required int classsId,
    required int subjectId,
    required String name,
    String? instruction,
    required String datetime,
    required String points,
    required int resubmission,
    String? extraDayForResubmission,
    List<String>? file,
  }) async {
    emit(createAssignmentInProcess());
    try {
      await _createAssignmmentRepository
          .createAssignment(
            classsId: classsId,
            subjectId: subjectId,
            name: name,
            datetime: datetime,
            resubmission: resubmission,
            extraDayForResubmission: extraDayForResubmission,
            filePaths: file,
            instruction: instruction,
            points: int.parse(points),
          )
          .then((value) => emit(createAssignmentSuccess()));
    } catch (e) {
      print(e.toString());
      emit(createAssignmentFailure(errormessage: e.toString()));
    }
  }
}
