part of 'provider.dart';

class _ProviderInjector {
  static _ProviderInjector _instance;
  final Map<String, dynamic> _providers = <String, dynamic>{};

  static _ProviderInjector getInstance() {
    if (_instance == null) {
      _instance = _ProviderInjector();
    }
    return _instance;
  }

  String _makeKey<T>(T type, [String key]) =>
      '${type.toString()}::${key ?? 'default'}';

  //(bu hisseni izzah olunacaq)
  bool _hasKey(String key) {
    return this._providers.containsKey(key);
  }

  void registerOrUpdateWithValue<T>(T value, [String tag]) {
    String key = _makeKey(T, tag);
    this._providers[key] = value;
  }

  void unRegisterProvider<T>([String tag]) {
    String key = _makeKey(T, tag);
    if (this._hasKey(key)) {
      this._providers.remove(key);
    }
  }

  T getProviderValue<T>([String tag]) {
    String key = _makeKey(T, tag);
    if (!_hasKey(key)) {
      throw Exception('Rovider can not find ${key}');
    }
    return this._providers[key];
  }
}
