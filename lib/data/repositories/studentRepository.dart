import 'package:eschool_teacher/data/models/student.dart';
import 'package:eschool_teacher/utils/api.dart';

class StudentRepository {
  Future<List<Student>> getStudentsByClassSection(
      {required int classSectionId}) async {
    try {
      final result = await Api.get(
          url: Api.getStudentsByClassSection,
          useAuthToken: true,
          queryParameters: {"class_section_id": classSectionId});

      return (result['data'] as List)
          .map((e) => Student.fromJson(Map.from(e)))
          .toList();
    } catch (e) {
      throw ApiException(e.toString());
    }
  }
}
