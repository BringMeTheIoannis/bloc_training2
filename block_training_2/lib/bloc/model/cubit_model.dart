import 'dart:async';
import 'dart:io';

import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class InternetConnectionState {
  final bool isActive;
  InternetConnectionState(this.isActive);
}

class CubitModel extends Cubit<InternetConnectionState> {
  late StreamSubscription<ConnectivityResult> _stream;
  CubitModel() : super(InternetConnectionState(false)) {
    _stream = Connectivity().onConnectivityChanged.listen((result) {
      emit(InternetConnectionState(result != ConnectivityResult.none));
    });
  }
  @override
  Future<void> close() {
    super.close();
    return _stream.cancel();
  }
}
