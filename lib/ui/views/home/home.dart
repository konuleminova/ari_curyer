import 'package:ari_kuryer/business_logic/models/Order.dart';
import 'package:ari_kuryer/ui/views/home/widgets/order_item.dart';
import 'package:ari_kuryer/utils/size_config.dart';
import 'package:ari_kuryer/utils/theme_color.dart';
import 'package:flutter/material.dart';

class HomeView extends StatelessWidget {
  final Order order;

  HomeView({this.order});

  Color statusColor;

  @override
  Widget build(BuildContext context) {
    if (order.status == 'go to user') {
      statusColor = ThemeColor().blue;
    } else if (order.status == 'go to rest') {
      statusColor = ThemeColor().blue.withOpacity(0.5);
    } else if (order.status == 'order') {
      statusColor = ThemeColor().yellowColor;
    }
    // TODO: implement build
    return Container(
      child: Column(
        children: <Widget>[
          order.status == 'waiting'
              ? Container(
                  margin: EdgeInsets.only(top: 16.toHeight),
                  child: Text('You have no order.'),
                )
              : OrderItemWidget(
                  statusColor: statusColor,
                ),
        ],
      ),
      height: SizeConfig().screenHeight,
      width: SizeConfig().screenWidth,
    );
  }
}
