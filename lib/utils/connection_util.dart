import 'dart:async';
import 'dart:io';

import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:rxdart/rxdart.dart';

class ConnectionUtil {
  ConnectionUtil._internal();
  static final ConnectionUtil instance = ConnectionUtil._internal();

  final BehaviorSubject<bool> _connectionStream = BehaviorSubject<bool>();

  Stream<bool> get connectionStream => _connectionStream.stream;

  bool _initialized = false;

  Future<void> initialize() async {
    await _checkConnection();

    if (_initialized) return;
    Connectivity().onConnectivityChanged.listen((results) async {
      await _checkConnection(results: results);
    });
    _initialized = true;
  }

  Future<void> _checkConnection({List<ConnectivityResult>? results}) async {
    bool hasConnection = await hasInternetConnection(results: results);
    bool canPingGoogle = await _pingGoogle();
    _emitHasConnection(hasConnection && canPingGoogle);
  }

  Future<bool> hasInternetConnection({
    List<ConnectivityResult>? results,
  }) async {
    List<ConnectivityResult> finalResult =
        results ??= await Connectivity().checkConnectivity();
    return !finalResult.contains(ConnectivityResult.none);
  }

  Future<bool> _pingGoogle() async {
    try {
      final result = await InternetAddress.lookup(
        'www.google.com',
        type: InternetAddressType.any,
      );
      return result.isNotEmpty && result[0].rawAddress.isNotEmpty;
    } on TimeoutException {
      return false;
    } on SocketException {
      return false;
    } catch (e) {
      return false;
    }
  }

  void _emitHasConnection(bool value) {
    _connectionStream.add(value);
  }
}
