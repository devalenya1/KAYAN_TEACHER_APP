import 'package:eschool_teacher/data/models/topic.dart';
import 'package:eschool_teacher/utils/api.dart';

class TopicRepository {
  Future<List<Topic>> fetchTopics({required int lessonId}) async {
    try {
      final result = await Api.get(
          url: Api.getTopics,
          useAuthToken: true,
          queryParameters: {"lesson_id": lessonId});
      return (result['data'] as List)
          .map((topic) => Topic.fromJson(Map.from(topic)))
          .toList();
    } catch (e) {
      throw ApiException(e.toString());
    }
  }
}
