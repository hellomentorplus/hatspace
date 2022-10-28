import 'package:get_it/get_it.dart';

abstract class HsSingleton {
  static final singleton = _HsSingletonImpl();

  void initialise();
}

class _HsSingletonImpl implements HsSingleton {
  static final _singleton = GetIt.instance;

  @override
  void initialise() {
    _singleton.registerSingleton<HsSingleton>(HsSingleton.singleton);
  }

  void registerSingleton<T extends Object>(T instance) {
    _singleton.registerSingleton<T>(instance);
  }

  void registerLazySingleton<T extends Object>(
      T instance) {
    _singleton.registerLazySingleton(() => instance);
  }

  T get<T extends Object>() {
    return _singleton.get<T>();
  }

  Future<T> getAsync<T extends Object>() {
    return _singleton.getAsync<T>();
  }
}