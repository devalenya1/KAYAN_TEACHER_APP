import 'package:eschool_teacher/data/models/student.dart';
import 'package:eschool_teacher/utils/api.dart';

class StudentRepository {
  Future<Map<String, dynamic>> getStudentsByClassSection(
      {required int classSectionId, int? page}) async {
    try {
      Map<String, dynamic> queryParameters = {
        "page": page ?? 0,
        "class_section_id": classSectionId
      };

      if (queryParameters['page'] == 0) {
        queryParameters.remove("page");
      }
      final result = await Api.get(
          url: Api.getStudentsByClassSection,
          useAuthToken: true,
          queryParameters: queryParameters);

      return {
        "students": (result['data']['data'] as List)
            .map((e) => Student.fromJson(Map.from(e)))
            .toList(),
        "totalPage": result['data']['last_page'] as int,
        "currentPage": result['data']['current_page'] as int,
      };
    } catch (e) {
      throw ApiException(e.toString());
    }
  }
}
