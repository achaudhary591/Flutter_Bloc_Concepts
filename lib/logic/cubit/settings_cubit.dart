import 'dart:convert';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:hydrated_bloc/hydrated_bloc.dart';

part 'settings_state.dart';

class SettingsCubit extends Cubit<SettingsState> with HydratedMixin{
  SettingsCubit()
      : super(
    SettingsState(
      appNotifications: false,
      emailNotifications: false,
    ),
  );

  void toggleAppNotifications(bool newValue) {
    emit(state.copyWith(appNotifications: newValue, emailNotifications: null));
  }

  void toggleEmailNotifications(bool newValue) =>
      emit(state.copyWith(emailNotifications: newValue, appNotifications: null));

  @override
  SettingsState? fromJson(Map<String, dynamic> json) {
    // TODO: implement fromJson
    return SettingsState.fromMap(json);
  }

  @override
  Map<String, dynamic>? toJson(SettingsState state) {
    // TODO: implement toJson
    return state.toMap();
  }
}
