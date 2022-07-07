import 'package:flutter_bloc/flutter_bloc.dart';

abstract class UploadFileState {}

class UploadFileInitial extends UploadFileState {}

class UploadFileInProgress extends UploadFileState {
  final double uploadedPercentage;

  UploadFileInProgress(this.uploadedPercentage);
}

class UploadFileSuccess extends UploadFileState {
  //Add returned data
  //ex. file url
  final String uploadedFileUrl;

  UploadFileSuccess(this.uploadedFileUrl);
}

class UploadFileFailure extends UploadFileState {
  final String errorMessage;

  UploadFileFailure(this.errorMessage);
}

class UploadFileCubit extends Cubit<UploadFileState> {
  UploadFileCubit() : super(UploadFileInitial());

  /*
  void _updateFileUploadPercentage(double percentage) {
    emit(UploadFileInProgress(percentage));
  }
  */

  void uploadFile({required String filePath}) async {
    emit(UploadFileInProgress(0.0));
    try {
      // await UploadFileRepository.uploadFile(
      //     filePath: filePath,
      //     onSendProgressCallback: _updateFileUploadPercentage);
      emit(UploadFileSuccess(""));
    } catch (e) {
      emit(UploadFileFailure(e.toString()));
    }
  }

  //   void uploadassignment({
  //   required int assignmentId,
  //   required int classSelectionId,
  //   required int subjectId,
  //   required String name,
  //   required String dateTime,
  //   String? instruction,
  //   int? points,
  //   bool? resubmission,
  //   int? extraDayForResubmission,
  //   List<dynamic>? files,
  // }) {
  //   try {
  //     emit(AssignmentFetchInProgress());
  //     _assignmentRepository.uploadassignment(
  //         assignmentId: assignmentId,
  //         classSelectionId: classSelectionId,
  //         subjectId: subjectId,
  //         name: name,
  //         dateTime: dateTime);
  //     emit(AssignmentFetchSuccess(assignment: []));
  //   } catch (e) {
  //     print(e.toString());
  //     emit(AssignmentFetchFailure(e.toString()));
  //   }
  // }
}
