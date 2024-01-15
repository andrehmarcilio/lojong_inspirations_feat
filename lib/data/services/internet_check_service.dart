import 'dart:async';

import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:dio/dio.dart';

abstract class InternetCheckService {
  Future<bool> get hasInternetConnection;
}

class InternetCheckServiceImpl implements InternetCheckService {
  static const _internetCheckMinInterval = Duration(minutes: 10);
  DateTime? _lastTimeChecked;

  static const _urlsToTestConnection = <String>[
    'https://dns.google',
    'https://www.apple.com',
    'https://www.github.com',
    'https://www.google.com/',
    'https://use.opendns.com/',
    'https://www.cloudflare.com/',
    'https://developers.google.com/speed/public-dns/',
  ];

  @override
  Future<bool> get hasInternetConnection async {
    final lastTimeChecked = _lastTimeChecked;

    if (await _deviceIsNotConnected) return false;

    if (lastTimeChecked != null && lastTimeChecked.difference(DateTime.now()) < _internetCheckMinInterval) {
      return true;
    }

    const minimumSuccessRequests = 2;

    final checkUrlFutures = _urlsToTestConnection.map(_checkSingleUrl);
    final wasRequestsSuccess = await Future.wait(checkUrlFutures);
    final successRequestsCount = wasRequestsSuccess.where((isSuccess) => isSuccess).length;
    final hasInternet = successRequestsCount > minimumSuccessRequests;
    if (hasInternet) _lastTimeChecked = DateTime.now();
    return hasInternet;
  }

  Future<bool> get _deviceIsNotConnected async {
    final connectivityResult = await Connectivity().checkConnectivity();
    return connectivityResult == ConnectivityResult.none;
  }

  Future<bool> _checkSingleUrl(String url) async {
    final dio = Dio();
    dio.options.connectTimeout = const Duration(seconds: 2);

    try {
      final response = await dio.head(url);
      if (response.statusCode == 200) return true;
    } on DioException {
      return false;
    }
    return false;
  }
}
