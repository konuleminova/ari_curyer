import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter_hooks/flutter_hooks.dart';

class TimerText extends HookWidget {
  String dateText;
  TextStyle style;

  TimerText({this.dateText, this.style});

  Timer timer;

  @override
  Widget build(BuildContext context) {
    final ValueNotifier<String> sDuration = useState<String>('');

    useEffect(() {
      timer = Timer.periodic(Duration(seconds: 1), (timer) {
        final DateTime now = DateTime.now();
        final DateTime orderDate = DateTime.parse(dateText);
        final difference =
            (now.millisecondsSinceEpoch - orderDate.millisecondsSinceEpoch);
        Duration duration = Duration(milliseconds: difference);
        if (sDuration != null)
          sDuration.value =
              "${duration.inDays} days - ${duration.inHours.remainder(60)}:${duration.inMinutes.remainder(60)}:${(duration.inSeconds.remainder(60))}";
      });
      return () {
        timer.cancel();
      };
    }, []);
    // TODO: implement build
    return Text(
      sDuration.value,
      style: style,
    );
  }
}
