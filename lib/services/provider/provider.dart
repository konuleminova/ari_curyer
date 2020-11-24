import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:flutter/widgets.dart';

part 'provider_injector.dart';
part 'provider_hook.dart';

class Provider<T> extends HookWidget {
  T value;
  final Widget child;

  Provider({this.value, this.child});

  @override
  Widget build(BuildContext context) {
    final providerInstance = useMemoized<_ProviderInjector>(
        () => _ProviderInjector.getInstance(), const []);
    useEffect(() {
      return () {
        providerInstance.unRegisterProvider();
      };
    }, [providerInstance]);
    providerInstance.registerOrUpdateWithValue<T>(value);
    // TODO: implement build
    return child;
  }
}
