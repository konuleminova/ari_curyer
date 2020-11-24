import 'package:ari_kuryer/ui/views/home/widgets/order_item.dart';
import 'package:ari_kuryer/utils/size_config.dart';
import 'package:flutter/material.dart';

class HomeView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Container(
      child: Column(children: <Widget>[OrderItemWidget(),],),
      height: SizeConfig().screenHeight,
      width: SizeConfig().screenWidth,
    );
  }
}
