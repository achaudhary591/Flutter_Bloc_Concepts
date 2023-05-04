 import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:connectivity/connectivity.dart';
import 'package:equatable/equatable.dart';

part 'internet_bloc_event.dart';
part 'internet_bloc_state.dart';

class InternetBlocBloc extends Bloc<InternetBlocEvent, InternetBlocState> {

StreamSubscription? connectivitySubscription;

Connectivity _connectivity = Connectivity();

  InternetBlocBloc() : super(InternetBlocInitial()) {
    
    on<InternetLostEvent>((event, emit) => emit(InternetLostState()));
    on<InternetOpenedEvent>((event, emit) => emit(InternetOpenedState()));

    connectivitySubscription = _connectivity.onConnectivityChanged.listen((result) { 
      if(result == ConnectivityResult.mobile || result == ConnectivityResult.wifi){
        add(InternetOpenedEvent());
      }
      else{
        add(InternetLostEvent());
      }
    });
  }

  @override
  Future<void> close() {
    // TODO: implement close
    connectivitySubscription?.cancel();
    return super.close();
  }
}
