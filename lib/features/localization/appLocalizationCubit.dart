import 'package:eschool_teacher/utils/constants.dart';
import 'package:eschool_teacher/utils/uiUtils.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class AppLocalizationState {
  final Locale language;
  AppLocalizationState(this.language);
}

class AppLocalizationCubit extends Cubit<AppLocalizationState> {
  //final SettingsLocalDataSource settingsLocalDataSource;
  //TODO: Add settings repository for stoing selected language value
  AppLocalizationCubit()
      : super(AppLocalizationState(
            UiUtils.getLocaleFromLanguageCode(defaultLanguageCode))) {
    //changeLanguage(settingsLocalDataSource.languageCode()!);
  }

  void changeLanguage(String languageCode) {
    //settingsLocalDataSource.setLanguageCode(languageCode);
    emit(AppLocalizationState(UiUtils.getLocaleFromLanguageCode(languageCode)));
  }
}
