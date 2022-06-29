import 'package:eschool_teacher/data/models/classSectionDetails.dart';
import 'package:eschool_teacher/data/models/subject.dart';
import 'package:eschool_teacher/utils/api.dart';

class TeacherRepository {
  Future<Map<String, dynamic>> myClasses() async {
    try {
      final result = await Api.get(url: Api.getClasses, useAuthToken: true);

      return {
        "primaryClass": ClassSectionDetails.fromJson(
            Map.from(result['data']['class_teacher'])),
        "classes": (result['data']['other'] as List)
            .map((e) => ClassSectionDetails.fromJson(Map.from(e)))
            .toList()
      };
    } catch (e) {
      throw ApiException(e.toString());
    }
  }

  Future<List<Subject>> subjectsByClassSection(int classSectionId) async {
    try {
      final result = await Api.get(
          url: Api.getSubjectByClassSection,
          useAuthToken: true,
          queryParameters: {"class_section_id": classSectionId});

      return (result['data'] as List)
          .map((subjectJson) =>
              Subject.fromJson(Map.from(subjectJson['subject'])))
          .toList();
    } catch (e) {
      throw ApiException(e.toString());
    }
  }
}
