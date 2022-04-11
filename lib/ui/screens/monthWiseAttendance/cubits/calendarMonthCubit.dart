import 'package:flutter_bloc/flutter_bloc.dart';

class CalendarMonthState {
  final int monthIndex;

  CalendarMonthState(this.monthIndex);
}

class CalendarMonthCubit extends Cubit<CalendarMonthState> {
  CalendarMonthCubit() : super(CalendarMonthState(DateTime.now().month));

  void updateMonthIndex(int index) {
    emit(CalendarMonthState(index));
  }
}
