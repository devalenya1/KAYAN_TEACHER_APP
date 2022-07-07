import 'package:dio/dio.dart';
import 'package:eschool_teacher/utils/api.dart';

class CreateAssignmentRepository {
  Future<void> createAssignment({
    required int classsId,
    required int subjectId,
    required String name,
    String? instruction,
    required String datetime,
    String? points,
    required int resubmission,
    String? extraDayForResubmission,
    List<String>? filePaths,
  }) async {
    try {
      List<MultipartFile> files = [];
      for (var filePath in filePaths!) {
        files.add(await MultipartFile.fromFile(filePath));
      }
      var body = {
        "class_section_id": classsId,
        "subject_id": subjectId,
        "name": name,
        "instructions": instruction,
        "due_date": datetime,
        "points": points,
        "resubmission": resubmission,
        "extra_days_for_resubmission": extraDayForResubmission,
        "file": files
      };
      if (instruction!.isEmpty) {
        body.remove("instructions");
      }
      if (points!.isEmpty) {
        body.remove("points");
      }

      // if (file.isEmpty) {
      //   body.remove("file");
      // }

      final result = await Api.post(
        url: Api.createassignment,
        body: body,
        useAuthToken: true,
      );
      print(result);
      print(files);
    } catch (e) {
      throw ApiException(e.toString());
    }
  }
}
