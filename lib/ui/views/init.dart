import 'package:ari_kuryer/business_logic/routes/nested_root.dart';
import 'package:ari_kuryer/business_logic/routes/route_names.dart';
import 'package:ari_kuryer/business_logic/routes/route_navigation.dart';
import 'package:ari_kuryer/utils/sharedpref/sp_util.dart';
import 'package:ari_kuryer/utils/size_config.dart';
import 'package:ari_kuryer/utils/theme_color.dart';
import 'package:flutter/material.dart';

class InitPage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return _InitPage();
  }
}

class _InitPage extends State<InitPage> {
  String initial;

  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    // TODO: implement build
    return Scaffold(
      backgroundColor: ThemeColor().greyColor,
      body: NestedNavigator(initialRoute: '/', routes: routeNames),
    );
  }

  @override
  void initState() {
    super.initState();
    setInstance();
  }

  void setInstance() async {
    await SpUtil.getInstance();
    initial = SpUtil.getString('token').isEmpty ? null : "/home";
    if (initial != null) {
      pushReplaceRouteWithName('/home');
    }
  }
}
