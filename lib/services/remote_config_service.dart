import 'dart:ffi';

import 'package:firebase_remote_config/firebase_remote_config.dart';
import 'package:flutter/services.dart';

const _DEBUG_OPTION_ENABLED = "debug_option_enabled";

class RemoteConfigService {
  final FirebaseRemoteConfig _remoteConfig;
  static RemoteConfigService? _intance;
  final defauls = <String, dynamic>{_DEBUG_OPTION_ENABLED: true};

  RemoteConfigService({required FirebaseRemoteConfig firebaseRemoteConfig})
      : _remoteConfig = firebaseRemoteConfig;

  Future initialise() async {
    try {
      await _remoteConfig.setDefaults(defauls);
      await _remoteConfig.setConfigSettings(RemoteConfigSettings(
          // fetchTimeout:  If the server does not respond within the time specified by the fetchTimeout property => fetch() will return a Exception.
          // can be useful if you want to reduce the amount of time your app spends waiting for a fetch request to complete, or if you are experiencing frequent timeouts and want to increase the timeout value.

          // minimumFetchInterval: It represents the minimum amount of time that must elapse between fetch requests
          // by defaut the setting will be 12 hours which mean firebase Remote Config SDK will not allow you to make more than one fetch request every 12 hours.
          fetchTimeout: const Duration(seconds: 30),
          minimumFetchInterval: const Duration(hours: 1)));

      await _remoteConfig.fetchAndActivate();
    } on PlatformException catch (e) {
      print("Remote config fetch throttled:$e");
    } catch (exception) {
      print('Unable to fetch remote config. Cached or default values will be '
          'used');
      print(exception);
    }
  }

  Future<RemoteConfigService> getInstance() async {
    if (_intance == null) {
      return _intance ??= RemoteConfigService(
          firebaseRemoteConfig: FirebaseRemoteConfig.instance);
    }
    return _intance!;
  }

  String getString(String key) {
    return _remoteConfig.getString(key);
  }

  int getInt(String key) {
    return _remoteConfig.getInt(key);
  }

  bool getBool(String key) {
    return _remoteConfig.getBool(key);
  }

  double getDouble(String key) {
    return _remoteConfig.getDouble(key);
  }

  bool getDebugOption() {
    return _remoteConfig.getBool(_DEBUG_OPTION_ENABLED);
  }
}
