import 'package:ari_kuryer/business_logic/models/Order.dart';
import 'package:ari_kuryer/ui/views/google_map/google_map.dart';
import 'package:ari_kuryer/ui/views/home/widgets/order_item.dart';
import 'package:ari_kuryer/utils/size_config.dart';
import 'package:ari_kuryer/utils/theme_color.dart';
import 'package:flutter/material.dart';

class HomeView extends StatelessWidget {
  final Order order;
  final Function(String orderId) assignOrder;
  final Function(String orderId) takeOrder;
  final Function(String orderId) giveOrder;

  HomeView({this.order, this.assignOrder, this.giveOrder, this.takeOrder});

//
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return order?.status != null
        ? Container(
            child: Column(
              children: <Widget>[
                order.status == 'waiting'
                    ? Container(
                        margin: EdgeInsets.only(
                            top: 16.toHeight, bottom: 16.toHeight),
                        child: Text(
                          'You have no order.',
                          style: TextStyle(fontWeight: FontWeight.w500),
                        ),
                      )
                    : OrderItemWidget(
                        order: order,
                        assignOrder: assignOrder,
                        takeOrder: takeOrder,
                        giveOrder: giveOrder,
                      ),
                Expanded(
                  child: order.status == 'go to user' ||
                          order.status == 'go to rest'
                      ? GoogleMapView(
                          coords: order.status == 'go to user'
                              ? order.user_coords
                              : order.rest_coords,
                          name: order.status == 'go to user'
                              ? order.user_name ?? ''
                              : order.rest_name ?? '',
                          address: order.status == 'go to user'
                              ? order.user_address ?? ''
                              : order.rest_address ?? '',
                        )
                      : SizedBox()
                )
              ],
            ),
            height: SizeConfig().screenHeight,
            width: SizeConfig().screenWidth,
          )
        : Container(
            child: Padding(
            padding: EdgeInsets.symmetric(horizontal: 16, vertical: 16),
            child: Text(
              'Your account is used someone else.\nLog out and Login again..',
              textAlign: TextAlign.center,
              style: TextStyle(fontWeight: FontWeight.w500),
            ),
          ));
  }
}
