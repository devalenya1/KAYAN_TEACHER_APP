import 'package:eschool_teacher/data/models/student.dart';

class StudentRepository {
  //filter with given class division id
  Future<List<Student>> searchStudents({required String searchQuery}) async {
    await Future.delayed(Duration(seconds: 1));
    return [
      Student(
          classDivision: "10 - A", id: "1", name: "Priyansh", rollNumber: "1"),
      Student(classDivision: "10 - A", id: "2", name: "Aarav", rollNumber: "2"),
      Student(classDivision: "10 - A", id: "3", name: "Nirav", rollNumber: "3"),
    ];
  }
}
