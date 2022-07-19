import 'package:dio/dio.dart';
import 'package:eschool_teacher/data/models/assignment.dart';
import 'package:eschool_teacher/utils/api.dart';

class AssignmentRepository {
  AssignmentRepository() {
    dio = Dio();
  }
  late Dio dio;

  //fetch assignments
  Future<Map<String, dynamic>> fetchassignment(
      {required int classSectionId, required int subjectId, int? page}) async {
    try {
      final result = await Api.get(
          url: Api.getassignment,
          useAuthToken: true,
          queryParameters: {
            "class_section_id": classSectionId,
            "subject_id": subjectId,
            "page": page ?? 0
          });
      print(result["data"]['data']);
      return {
        "assignment": (result['data']['data'] as List).map((e) {
          return Assignment.fromJson(e);
        }).toList(),
        "currentPage": (result["data"]["current_page"] as int),
        "lastPage": (result["data"]["last_page"] as int)
      };
    } catch (e) {
      throw ApiException(e.toString());
    }
  }

  Future<void> deleteAssignment({required int assignmentId}) async {
    try {
      final body = {"assignment_id": assignmentId};

      await Api.post(url: Api.deleteassignment, useAuthToken: true, body: body);
    } catch (e) {
      print(e.toString());
      throw ApiException(e.toString());
    }
  }

  Future<void> editassignment({
    required int assignmentId,
    required int classSelectionId,
    required int subjectId,
    String? name,
    String? dateTime,
    String? instruction,
    int? points,
    int? resubmission,
    String? extraDayForResubmission,
    List<String>? filePaths,
  }) async {
    try {
      List<MultipartFile> files = [];
      for (var filePath in filePaths!) {
        files.add(await MultipartFile.fromFile(filePath));
      }
      var body = {
        "class_section_id": classSelectionId,
        "assignment_id": assignmentId,
        "subject_id": subjectId,
        "name": name,
        "instructions": instruction,
        "due_date": dateTime,
        "points": points,
        "resubmission": resubmission,
        "extra_days_for_resubmission": extraDayForResubmission,
        "file": files
      };
      if (instruction!.isEmpty) {
        body.remove("instructions");
      }
      if (points == 0) {
        body.remove("points");
      }
      if (filePaths.isEmpty) {
        body.remove("file");
      }
      print("bodyyyyy$body");
      await Api.post(body: body, url: Api.uploadassignment, useAuthToken: true);
    } catch (e) {
      ApiException(e.toString());
    }
  }

  Future<void> createAssignment({
    required int classsId,
    required int subjectId,
    required String name,
    String? instruction,
    required String datetime,
    required int points,
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
      if (points == 0) {
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

  //

  //complete assignment

  //

}
