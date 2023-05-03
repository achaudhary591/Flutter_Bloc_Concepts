part of 'internet_cubit.dart';

@immutable
abstract class InternetState {}

class InternetLoading extends InternetState {}

class InternetConnected extends InternetState {
  final ConnectionType connectionType;

  @override
  String toString() {
    return 'InternetConnected{connectionType: $connectionType}';
  }

  InternetConnected({required this.connectionType});
}

class InternetDisconnected extends InternetState {}
