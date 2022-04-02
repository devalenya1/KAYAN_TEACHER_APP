class Video {
  final String title;
  final String description;
  final String youTubeLink;
  final String thumbnailImageUrl;
  final String chapterId;
  final String classDivisonId;
  final String subjectId;

  Video(
      {required this.chapterId,
      required this.classDivisonId,
      required this.description,
      required this.subjectId,
      required this.thumbnailImageUrl,
      required this.title,
      required this.youTubeLink});

  Video copyWith({
    String? newTitle,
    String? newDescription,
    String? newchapterId,
    String? newClassDivisionId,
    String? newThumbnailImageUrl,
    String? newYoutubeLink,
    String? newSubjectID,
  }) {
    return Video(
        chapterId: newchapterId ?? chapterId,
        classDivisonId: newClassDivisionId ?? classDivisonId,
        description: newDescription ?? description,
        subjectId: newSubjectID ?? subjectId,
        thumbnailImageUrl: newThumbnailImageUrl ?? thumbnailImageUrl,
        title: newTitle ?? title,
        youTubeLink: newYoutubeLink ?? youTubeLink);
  }
  //TODO: Add fromJson and toJosn

}
