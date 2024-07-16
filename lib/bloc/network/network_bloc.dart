import 'dart:async';
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'network_event.dart';
import 'network_state.dart';

class NetworkBloc extends Bloc<NetworkEvent, NetworkState> {
  final Connectivity _connectivity = Connectivity();
  late StreamSubscription<ConnectivityResult> _subscription;

  NetworkBloc._() : super(NetworkInitial()) {
    on<NetworkObserve>(_observe);
    on<NetworkNotify>(_notifyStatus);
  }

  static final NetworkBloc _instance = NetworkBloc._();

  factory NetworkBloc() => _instance;

  void _observe(NetworkObserve event, Emitter<NetworkState> emit) async {
    _subscription = _connectivity.onConnectivityChanged.listen((result) {
      add(NetworkNotify(isConnected: _isConnected(result as ConnectivityResult)));
    }) as StreamSubscription<ConnectivityResult>;
  }

  void _notifyStatus(NetworkNotify event, Emitter<NetworkState> emit) {
    event.isConnected ? emit(NetworkSuccess()) : emit(NetworkFailure());
  }

  bool _isConnected(ConnectivityResult result) {
    return result == ConnectivityResult.mobile || result == ConnectivityResult.wifi;
  }

  @override
  Future<void> close() {
    _subscription.cancel();
    return super.close();
  }
}
