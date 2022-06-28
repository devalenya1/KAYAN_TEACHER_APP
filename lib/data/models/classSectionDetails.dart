import 'package:eschool_teacher/data/models/classDetails.dart';
import 'package:eschool_teacher/data/models/sectionDetails.dart';

class ClassSectionDetails {
  final int classTeacherId;
  final int classSectionId;
  final ClassDetails classDetails;
  final SectionDetails sectionDetails;

  ClassSectionDetails(
      {required this.classTeacherId,
      required this.classSectionId,
      required this.classDetails,
      required this.sectionDetails});

  static ClassSectionDetails fromJson(Map<String, dynamic> json) {
    return ClassSectionDetails(
      sectionDetails: SectionDetails.fromJson(json['section']),
      classDetails: ClassDetails.fromJson(json['class']),
      classSectionId: json['id'],
      classTeacherId: json['class_teacher_id'],
    );
  }
}
