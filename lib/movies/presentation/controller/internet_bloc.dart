import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:meta/meta.dart';

part 'internet_event.dart';
part 'internet_state.dart';

class InternetBloc extends Bloc<InternetEvent, InternetState> {
  StreamSubscription? _subscription;
  Connectivity connectivity = Connectivity();
  InternetBloc() : super(InternetInitial()) {
    _initConnectivity();
  }

  Future<void> _initConnectivity() async {
    ConnectivityResult result = await connectivity.checkConnectivity();
    _checkConnectivity(result);
    _subscription =
        connectivity.onConnectivityChanged.listen((ConnectivityResult result) {
      _checkConnectivity(result);
    });
  }

  void _checkConnectivity(ConnectivityResult result) {
    if (result == ConnectivityResult.wifi ||
        result == ConnectivityResult.mobile) {
      emit(ConnectedState(message: "Connected"));
    } else {
      emit(NotConnectedState(message: "Not Connected"));
    }
  }

  @override
  Future<void> close() {
    _subscription!.cancel();
    return super.close();
  }
}
