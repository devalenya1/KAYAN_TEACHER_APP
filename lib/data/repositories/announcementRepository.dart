import 'package:eschool_teacher/data/models/announcement.dart';
import 'package:eschool_teacher/utils/api.dart';

class AnnouncementRepository {
  Future<Map<String, dynamic>> fetchAnnouncements(
      {int? page, required int subjectId, required int classSectionId}) async {
    try {
      Map<String, dynamic> queryParameters = {
        "page": page ?? 0,
        "subject_id": subjectId,
        "class_section_id": classSectionId
      };
      if (queryParameters['page'] == 0) {
        queryParameters.remove("page");
      }
      final result = await Api.get(
          url: Api.getAnnouncement,
          useAuthToken: true,
          queryParameters: queryParameters);

      return {
        "announcements": (result['data']['data'] as List)
            .map((e) => Announcement.fromJson(Map.from(e)))
            .toList(),
        "totalPage": result['data']['last_page'] as int,
        "currentPage": result['data']['current_page'] as int,
      };
    } catch (e) {
      throw ApiException(e.toString());
    }
  }
}
