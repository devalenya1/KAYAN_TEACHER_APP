import 'package:eschool_teacher/data/models/classSectionDetails.dart';
import 'package:eschool_teacher/data/repositories/teacherRepository.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

abstract class MyClassesState {}

class MyClassesInitial extends MyClassesState {}

class MyClassesFetchInProgress extends MyClassesState {}

class MyClassesFetchSuccess extends MyClassesState {
  final List<ClassSectionDetails> classes;
  //Primary class will be act as a class teacher's class
  final ClassSectionDetails primaryClass;

  MyClassesFetchSuccess({required this.classes, required this.primaryClass});
}

class MyClassesFetchFailure extends MyClassesState {
  final String errorMessage;

  MyClassesFetchFailure(this.errorMessage);
}

class MyClassesCubit extends Cubit<MyClassesState> {
  final TeacherRepository _teacherRepository;

  MyClassesCubit(this._teacherRepository) : super(MyClassesInitial());

  void fetchMyClasses() async {
    emit(MyClassesFetchInProgress());
    try {
      final result = await _teacherRepository.myClasses();

      emit(MyClassesFetchSuccess(
          classes: result['classes'], primaryClass: result['primaryClass']));
    } catch (e) {
      emit(MyClassesFetchFailure(e.toString()));
    }
  }
}
