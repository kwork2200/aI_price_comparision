import 'package:firebase_remote_config/firebase_remote_config.dart';

class RemoteConfigService {
  static final RemoteConfigService _instance = RemoteConfigService._internal();
  factory RemoteConfigService() => _instance;
  RemoteConfigService._internal();

  late FirebaseRemoteConfig _remoteConfig;
  bool _initialized = false;

  Future<void> initialize() async {
    if (_initialized) return;

    try {
      _remoteConfig = FirebaseRemoteConfig.instance;

      await _setDefaults();
      
      await _remoteConfig.setConfigSettings(RemoteConfigSettings(
        fetchTimeout: const Duration(seconds: 30),
        minimumFetchInterval: const Duration(minutes: 1),
      ));

      await _remoteConfig.fetchAndActivate();
      print('✅ Remote Config initialized successfully');
      
      _initialized = true;
    } catch (e) {
      print('❌ Remote Config initialization error: $e');
      _initialized = true;
    }
  }

  Future<void> _setDefaults() async {
    await _remoteConfig.setDefaults({
      'ad_client': 'ca-pub-3940256099942544',
      'ad_slot': '1234567890',
    });
  }

  String get adClient {
    try {
      return _remoteConfig.getString('ad_client');
    } catch (e) {
      return 'ca-pub-3940256099942544';
    }
  }
  
  String get adSlot {
    try {
      return _remoteConfig.getString('ad_slot');
    } catch (e) {
      return '1234567890';
    }
  }

  Future<void> refresh() async {
    if (!_initialized) {
      await initialize();
      return;
    }

    try {
      await _remoteConfig.fetchAndActivate();
      print('✅ Remote Config refreshed successfully');
    } catch (e) {
      print('⚠️ Remote Config refresh failed: $e');
    }
  }
}
