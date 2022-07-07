import 'package:dio/dio.dart';
import 'package:eschool_teacher/utils/api.dart';

class SubjectRepository {
  Future<void> downloadStudyMaterialFile(
      {required String url,
      required String savePath,
      required CancelToken cancelToken,
      required Function updateDownloadedPercentage}) async {
    try {
      await Api.download(
          cancelToken: cancelToken,
          url: url,
          savePath: savePath,
          updateDownloadedPercentage: updateDownloadedPercentage);
    } catch (e) {
      throw ApiException(e.toString());
    }
  }
}
