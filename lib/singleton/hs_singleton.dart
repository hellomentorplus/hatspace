import 'package:get_it/get_it.dart';
import 'package:hatspace/models/permission/permission_service.dart';
import 'package:hatspace/models/storage/storage_service.dart';

import 'package:hatspace/models/authentication/authentication_service.dart';

abstract class HsSingleton {
  static final singleton = _HsSingletonImpl();

  void initialise();
}

class _HsSingletonImpl implements HsSingleton {
  static final _singleton = GetIt.instance;

  @override
  void initialise() {
    _singleton.registerSingleton<HsSingleton>(HsSingleton.singleton);

    if (!_singleton.isRegistered<AuthenticationService>()) {
      _singleton.registerSingleton(AuthenticationService());
    }

    if (!_singleton.isRegistered<StorageService>()) {
      _singleton.registerSingleton(StorageService());
    }

    if (!_singleton.isRegistered<HsPermissionService>()) {
      _singleton.registerSingleton(HsPermissionService());
    }
  }

  void registerSingleton<T extends Object>(T instance) {
    _singleton.registerSingleton<T>(instance);
  }

  void registerLazySingleton<T extends Object>(T instance) {
    _singleton.registerLazySingleton(() => instance);
  }

  T get<T extends Object>() {
    return _singleton.get<T>();
  }

  Future<T> getAsync<T extends Object>() {
    return _singleton.getAsync<T>();
  }
}
