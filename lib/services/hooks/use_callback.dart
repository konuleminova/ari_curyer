import 'package:flutter_hooks/flutter_hooks.dart';

T useCallback<T>(T callbackFn, [final List<Object> keys = const <dynamic>[]]) {
  return useMemoized(() => callbackFn, keys);
}