import 'package:ari_kuryer/business_logic/models/Order.dart';
import 'package:ari_kuryer/services/services/order_service.dart';
import 'package:ari_kuryer/utils/theme_color.dart';
import 'package:flutter/material.dart';
import 'package:ari_kuryer/utils/size_config.dart';

class OrderItemWidget extends StatelessWidget {
  final Order order;
  Function(String orderId) assignOrder;

  OrderItemWidget({this.order, this.assignOrder});

  Color statusColor;

  @override
  Widget build(BuildContext context) {
    if (order.status == 'go to user') {
      statusColor = ThemeColor().blue;
    } else if (order.status == 'go to rest') {
      statusColor = ThemeColor().blue.withOpacity(0.5);
    } else {
      statusColor = ThemeColor().yellowColor;
    }
    // TODO: implement build
    return Container(
        height: 180.toHeight,
        margin: EdgeInsets.all(16),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.only(
              topLeft: Radius.circular(16), topRight: Radius.circular(16)),
          color: Colors.white,
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Container(
              padding: EdgeInsets.all(24.toWidth),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  Expanded(
                    child: Text(
                      "TOMAT ŞORBASI 1 POLLO CON GORGONZOLA 5 BRUSCHETTA",
                      maxLines: 3,
                    ),
                  ),
                  SizedBox(
                    width: 26.toWidth,
                  ),
                  Text(
                    order.order ?? '934',
                    style: TextStyle(fontWeight: FontWeight.w700),
                  )
                ],
              ),
            ),
            InkWell(
              onTap: () {
                assignOrder(order.order);
              },
              child: Container(
                margin: EdgeInsets.all(16),
                padding: EdgeInsets.all(16.toWidth),
                width: SizeConfig().screenHeight,
                height: 44.toHeight,
                color: statusColor,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: <Widget>[
                    Text(
                      "I WANT THIS",
                      style: TextStyle(
                          fontSize: 20.toFont,
                          fontWeight: FontWeight.w700,
                          color: statusColor == ThemeColor().yellowColor
                              ? Colors.black
                              : Colors.white),
                    ),
                    SizedBox(
                      width: 4.toWidth,
                    ),
                    Image.asset('assets/images/done.png',
                        color: statusColor == ThemeColor().yellowColor
                            ? Colors.black
                            : Colors.white)
                  ],
                ),
              ),
            )
          ],
        ));
  }
}
