part of 'settings_cubit.dart';

class SettingsState extends Equatable {
  final bool appNotifications;
  final bool emailNotifications;

  SettingsState({
    required this.appNotifications,
    required this.emailNotifications,
  });

  SettingsState copyWith({
    required bool? appNotifications,
    required bool? emailNotifications,
  }) {
    return SettingsState(
      appNotifications: appNotifications ?? this.appNotifications,
      emailNotifications: emailNotifications ?? this.emailNotifications,
    );
  }

  @override
  List<Object> get props => [
        emailNotifications!,
        appNotifications!,
      ];

  /*factory SettingsState.fromJson(Map<String, dynamic> json) {
    return SettingsState(
      appNotifications: json["appNotifications"].toLowerCase() == 'true',
      emailNotifications: json["emailNotifications"].toLowerCase() == 'true',
    );
  }

  Map<String, dynamic> toJson() {
    return {
      "appNotifications": this.appNotifications,
      "emailNotifications": this.emailNotifications,
    };
  }*/

//

  Map<String, dynamic> toMap() {
    return {
      "appNotifications": this.appNotifications,
      "emailNotifications": this.emailNotifications,
    };
  }

  factory SettingsState.fromMap(Map<String, dynamic> json) {
    return SettingsState(
      appNotifications: json["appNotifications"],
      emailNotifications: json["emailNotifications"],
    );
  }

  @override
  String toString() {
    return 'SettingsState{appNotifications: $appNotifications, emailNotifications: $emailNotifications}';
  }

  String toJson() => json.encode(toMap());

  factory SettingsState.fromJson(String source) =>
      SettingsState.fromMap(json.decode(source));
}
