import 'package:ari_kuryer/business_logic/view_models/HomeViewModel.dart';
import 'package:ari_kuryer/utils/local_notification/local_notification.dart';
import 'package:flutter/cupertino.dart';

class SplashScreen extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return _SplashSttae();
  }
}

class _SplashSttae extends State<SplashScreen>  with WidgetsBindingObserver{

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return HomeViewModel();
  }

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addObserver(this);
    NotificationUtils().init();
  }
  @override
  void dispose() {
    WidgetsBinding.instance.removeObserver(this);
    super.dispose();
  }

    @override
  void didChangeAppLifecycleState(AppLifecycleState state) async {
    print("SSTTTAT ${state}");
    if (state == AppLifecycleState.paused) {
      NotificationUtils().scheduleNotification();
    }
  }

}
