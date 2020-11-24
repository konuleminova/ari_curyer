import 'package:flutter/widgets.dart';
import 'package:flutter_hooks/flutter_hooks.dart';

void useSideEffect(Dispose Function() effect, [List<Object> keys]) {
  use(_EffectHook(effect, keys));
}

class _EffectHook extends Hook<void> {
  const _EffectHook(this.effect, [List<Object> keys])
      : assert(effect != null, 'effect cannot be null'),
        super(keys: keys);

  final Dispose Function() effect;

  @override
  _EffectHookState createState() => _EffectHookState();
}

class _EffectHookState extends HookState<void, _EffectHook> {
  Dispose disposer;

  @override
  void initHook() {
    super.initHook();
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      scheduleEffect();
    });
  }

  @override
  void didUpdateHook(_EffectHook oldHook) {
    super.didUpdateHook(oldHook);

    if (hook.keys == null) {
      if (disposer != null) {
        disposer();
      }
      scheduleEffect();
    }
  }

  @override
  void build(BuildContext context) {}

  @override
  void dispose() {
    if (disposer != null) {
      disposer();
    }
  }

  void scheduleEffect() {
    disposer = hook.effect();
  }
}