import 'dart:async';
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter/material.dart';

class ConnectivityProvider extends ChangeNotifier {
  final Connectivity _connectivity = Connectivity();
  late StreamSubscription<List<ConnectivityResult>> _streamSubscription;

  String _status = ' waiting...;';

  String get status => _status;

  ConnectivityProvider() {
    checkConnectivity();
  }

  void checkConnectivity() async {
    var connectionResult = await _connectivity.checkConnectivity();
    if (connectionResult.contains(ConnectivityResult.mobile)) {
      _status = 'Connected to MobileData';
      notifyListeners();
    } else if (connectionResult.contains(ConnectivityResult.wifi)) {
      _status = 'Connected to Wifi';
      notifyListeners();
    } else if (connectionResult.contains(ConnectivityResult.none)) {
      _status = 'Offline';
      notifyListeners();
    }

    _streamSubscription = _connectivity.onConnectivityChanged.listen(
      (List<ConnectivityResult> event) {
        if (event.contains(ConnectivityResult.wifi) ||
            event.contains(ConnectivityResult.mobile)) {
          _status = 'Online';
          notifyListeners();
        } else if (event.contains(ConnectivityResult.none)) {
          _status = 'Offline';
          notifyListeners();
        }
      },
    );
  }

  @override
  void dispose() {
    _streamSubscription.cancel();
    super.dispose();
  }
}
