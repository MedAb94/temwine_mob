import 'dart:ui';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:temwin_front_app/Data/dataSources/Local/Language/app_lang_local_data_source.dart';

class LanguageCubit extends Cubit<Locale?> {
  final AppLangLocalDataSource appLangLocalDataSource;
  LanguageCubit({required this.appLangLocalDataSource}) : super(null);

  void getLanguage() async {
    String lang = await appLangLocalDataSource.getAppLang() ?? "fr";

    emit(Locale(lang, lang == "fr" ? "FR" : "AR"));
  }

  void setLanguage(String lang) async {
    await appLangLocalDataSource.storeAppLang(appLang: lang);

    emit(Locale(lang, lang == "fr" ? "FR" : "AR"));
  }
}
