import 'dart:io';

class PickedStudyMaterial {
  final String fileName;
  final int
      pickedStudyMaterialTypeId; // 1 = file_upload , 2 = youtube_link , 3 = video_upload
  final String? youTubeLink;
  final File? videoThumbnailFile;
  final File? studyMaterialFile;

  PickedStudyMaterial(
      {required this.fileName,
      required this.pickedStudyMaterialTypeId,
      this.studyMaterialFile,
      this.videoThumbnailFile,
      this.youTubeLink});

  Map<String, dynamic> toJson() {
    Map<String, dynamic> json = {};
    json['type'] = pickedStudyMaterialTypeId;
    json['name'] = fileName;

    if (pickedStudyMaterialTypeId != 2) {
      json['file'] = studyMaterialFile;
    }
    if (pickedStudyMaterialTypeId != 1) {
      json['thumbnail'] = videoThumbnailFile;
    }
    if (pickedStudyMaterialTypeId == 2) {
      json['link'] = youTubeLink;
    }

    return json;
  }
}
