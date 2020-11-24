import 'package:ari_kuryer/business_logic/models/Order.dart';
import 'package:ari_kuryer/ui/views/home/widgets/order_item.dart';
import 'package:ari_kuryer/utils/size_config.dart';
import 'package:ari_kuryer/utils/theme_color.dart';
import 'package:flutter/material.dart';

class HomeView extends StatelessWidget {
  final Order order;
  final Function(String orderId) assignOrder;

  HomeView({this.order, this.assignOrder});

//
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Container(
      child: Column(
        children: <Widget>[
          false
              ? Container(
                  margin: EdgeInsets.only(top: 16.toHeight),
                  child: Text('You have no order.'),
                )
              : OrderItemWidget(
                  order: order,
                  assignOrder: assignOrder,
                ),
        ],
      ),
      height: SizeConfig().screenHeight,
      width: SizeConfig().screenWidth,
    );
  }
}
