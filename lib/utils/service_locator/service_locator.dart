import 'dart:async';

import 'package:get_it/get_it.dart';

final serviceLocator = ServiceLocator();

class ServiceLocator {
  final _provider = GetIt.instance;

  T get<T extends Object>({dynamic param}) {
    return _provider.get<T>(param1: param);
  }

  void registerSingleton<T extends Object>(
    T instance, {
    FutureOr<dynamic> Function(T)? dispose,
  }) {
    _provider.registerSingleton<T>(instance, dispose: dispose);
  }

  void registerSingletonAsync<T extends Object>(
    Future<T> Function() asyncConstructor, {
    FutureOr<dynamic> Function(T)? dispose,
  }) {
    _provider.registerSingletonAsync<T>(asyncConstructor, dispose: dispose);
  }

  void registerFactory<T extends Object>(T Function() constructor) {
    _provider.registerFactory<T>(constructor);
  }

  void pushNewScope(void Function(ServiceLocator)? init) {
    _provider.pushNewScope(init: (_) => init?.call(serviceLocator));
  }

  Future<void> popScope() async {
    await _provider.popScope();
  }

  Future<void> reset() async {
    await _provider.reset();
  }

  Future<void> allReady() async {
    await _provider.allReady();
  }
}

void initializeDependencies() {}
