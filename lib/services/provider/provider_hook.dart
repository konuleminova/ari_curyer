part of 'provider.dart';

final providerInstance = _ProviderInjector.getInstance();

T useProvider<T>([String tag]) {
  return providerInstance.getProviderValue(tag);
}

void useProviderRegistration<T>(T value, [String tag]) {
  useEffect(() {
    return () {
      providerInstance.unRegisterProvider(tag);
    };
  }, [tag]);
  providerInstance.registerOrUpdateWithValue<T>(value, tag);
}



