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
}
