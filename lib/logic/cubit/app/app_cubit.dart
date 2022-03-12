import 'dart:developer';

import 'package:equatable/equatable.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hospital25/core/languages/languages.dart';
import 'package:hospital25/data/models/text_model.dart';
import 'package:hospital25/data/repositories/app_repository.dart';
import 'package:hospital25/logic/cubit/internet/internet_cubit.dart';
import 'package:intl/intl.dart';

import '../../../core/languages/language_ar.dart';
import '../../../data/models/products_list_model.dart';

part 'app_state.dart';

class AppCubit extends Cubit<AppState> {
  final AppRepository appRepo;
  final InternetCubit connection;
  AppCubit(
    this.appRepo,
    this.connection,
  ) : super(AppInitial());

  static AppCubit get(BuildContext context) => BlocProvider.of(context);

  static AppText? appText;
  static String? currency = 'EGP';
  static String? appTextErrorMsg;

  Future<void> getAppText(BuildContext context) async {
    emit(ChangeLanguageLoading());

    if (connection.state is InternetConnectionFail) {
      appTextErrorMsg = Languages.of(context).connectionFailed;
      emit(ChangeLanguageFailed(error: Languages.of(context).connectionFailed));
    } else {
      try {
        appText = await appRepo.getAppText();
        emit(ChangeLanguageSuccess());
      } catch (e) {
        log('Get App Text Error: $e');
        appTextErrorMsg = Bidi.stripHtmlIfNeeded(e.toString());
        emit(ChangeLanguageFailed(error: e.toString()));
      }
    }
  }

  Future<void> getAppCurrency(BuildContext context) async {
    emit(ChangeLanguageLoading());

    if (connection.state is InternetConnectionFail) {
      print(' getAppCurrency Error: ${AppCubit.appText!.connectionFailed}');
    } else {
      try {
        currency = await appRepo.getAppCurrency();
        log('Currency is: $currency');
        emit(ChangeLanguageSuccess());
      } catch (e) {
        print(' getAppCurrency Error: $e');
        emit(ChangeLanguageFailed(error: e.toString()));
      }
    }
  }

}
