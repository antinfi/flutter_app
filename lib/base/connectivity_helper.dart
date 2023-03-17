import 'dart:async';

import 'package:connectivity_plus/connectivity_plus.dart';

import '../utils/data_connection_checker.dart';

class ConnectivityHelper {
  final Connectivity _connectivity = Connectivity();
  StreamSubscription? _stream;
  bool _currentState = false;

  final _onConnectivityChangeController = StreamController<bool>.broadcast();

  bool get isConnected => _currentState;

  Stream<bool> get onConnectivityChange {
    _connectivity.checkConnectivity().then((value) => _checkInternetStatus(value, forceUpdate: true));
    return _onConnectivityChangeController.stream;
  }

  ConnectivityHelper() {
    init();
  }

  Future init() async {
    _stream = _connectivity.onConnectivityChanged.listen(_checkInternetStatus);
  }

  void dispose() {
    _stream?.cancel();
  }

  Future<void> _checkInternetStatus(ConnectivityResult result, {bool forceUpdate = false}) async {
    if (result == ConnectivityResult.none) {
      if (_currentState || forceUpdate) {
        _currentState = false;
        _onConnectivityChangeController.add(_currentState);
      }
    } else {
      final state = await DataConnectionChecker().hasConnection;
      if (_currentState != state || forceUpdate) {
        _currentState = state;
        _onConnectivityChangeController.add(_currentState);
      }
    }
  }
}
