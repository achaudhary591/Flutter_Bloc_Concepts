part of 'internet_bloc_bloc.dart';

abstract class InternetBlocEvent extends Equatable {
  const InternetBlocEvent();

  @override
  List<Object> get props => [];
}

class InternetLostEvent extends InternetBlocEvent {
  @override
  List<Object> get props => [];
}

class InternetOpenedEvent extends InternetBlocEvent {
  @override
  List<Object> get props => [];
}