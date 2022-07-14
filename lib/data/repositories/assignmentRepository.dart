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

  Future<void> uploadassignment(
      {required int assignmentId,
      required int classSelectionId,
      required int subjectId,
      required String name,
      required String dateTime,
      String? instruction,
      int? points,
      bool? resubmission,
      int? extraDayForResubmission,
      List? files}) async {
    try {
      var body = {
        "assignment_id": assignmentId,
        "class_section_id": classSelectionId,
        "subject_id": subjectId,
        "name": name,
        "due_date": dateTime,
        "instructions": instruction,
        "points": points,
        "resubmission": resubmission,
        "extra_days_for_resubmission": extraDayForResubmission,
        "file": files,
      };
      if (instruction!.isEmpty) {
        body.remove("instructions");
      }
      if (points == 0) {
        body.remove("points");
      }
      if (resubmission == false) {
        body.remove("extra_days_for_resubmission");
      }
      if (files!.isEmpty) {
        body.remove("file");
      }
      await Api.post(body: body, url: Api.uploadassignment, useAuthToken: true);
    } catch (e) {
      ApiException(e.toString());
    }
  }

  //

  //complete assignment

  //

}
