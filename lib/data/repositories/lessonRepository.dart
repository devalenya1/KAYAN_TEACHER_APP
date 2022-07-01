import 'package:eschool_teacher/utils/api.dart';

class LessonRepository {
  Future<void> createLesson(
      {required String lessonName,
      required int classSectionId,
      required int subjectId,
      required String lessonDescription,
      required List<Map<String, dynamic>> files}) async {
    try {
      Map<String, dynamic> body = {
        "class_section_id": classSectionId,
        "subject_id": subjectId,
        "name": lessonName,
        "lessonDescription": lessonDescription
      };

      if (files.isNotEmpty) {
        body['file'] = files;
      }

      print(body);

      //await Api.post(body: body, url: Api.createLesson, useAuthToken: true);
    } catch (e) {
      throw ApiException(e.toString());
    }
  }
}
