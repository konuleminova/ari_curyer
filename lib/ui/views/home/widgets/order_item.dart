import 'package:ari_kuryer/business_logic/models/Order.dart';
import 'package:ari_kuryer/utils/theme_color.dart';
import 'package:flutter/material.dart';
import 'package:ari_kuryer/utils/size_config.dart';
import 'package:flutter_hooks/flutter_hooks.dart';

class OrderItemWidget extends HookWidget {
  final Order order;
  Function(String orderId) assignOrder;
  final Function(String orderId) takeOrder;
  final Function(String orderId) giveOrder;

  OrderItemWidget(
      {this.order, this.assignOrder, this.takeOrder, this.giveOrder});

  Color statusColor;
  String statusText;

  @override
  Widget build(BuildContext context) {
    var valueExpaned = useState<bool>(false);
    if (order.status == 'go to user') {
      statusColor = ThemeColor().blue;
      statusText = 'DONE';
    } else if (order.status == 'go to rest') {
      statusColor = ThemeColor().blue.withOpacity(0.5);
      statusText = 'TAKE';
    } else if (order.status == 'i want this') {
      statusColor = ThemeColor().yellowColor;
      statusText = 'I WANT THIS';
    }
    // TODO: implement build
    return order.status == 'i want this'?AnimatedCrossFade(
        firstChild: InkWell(
            onTap: () {
              valueExpaned.value = true;
            },
            child: Container(
              height: 60.toHeight,
              width: SizeConfig().screenWidth,
              margin: EdgeInsets.only(
                  left: 16.toWidth, right: 16.toWidth, bottom: 4.toHeight),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.all(Radius.circular(15)),
                color: Colors.white,
              ),
              child: Row(
                children: [
                  Expanded(
                    child: Container(
                      child: Text(
                        order.order ?? '',
                        style: TextStyle(fontWeight: FontWeight.w500),
                      ),
                      margin: EdgeInsets.only(left: 24.toWidth),
                    ),
                  ),
                  Expanded(
                    flex: 3,
                    child: Container(
                      child: Text(
                        order.rest_name ?? '',
                        style: TextStyle(color: ThemeColor().greenColor),
                      ),
                      margin: EdgeInsets.only(left: 8.toWidth),
                    ),
                  ),
                  Expanded(
                    flex: 1,
                    child: Container(
                      child: Text(
                        order.finished_time != null &&
                                order.finished_time.length > 10
                            ? order.finished_time.substring(10)
                            : '' ?? '',
                        style: TextStyle(
                            color: ThemeColor().greenColor, fontSize: 12),
                      ),
                      margin: EdgeInsets.only(left: 8.toWidth),
                    ),
                  ),
                  SizedBox(
                    width: 4.toWidth,
                  ),
                  CircleAvatar(
                      backgroundColor: ThemeColor().yellowColor,
                      child: Image.asset(
                        'assets/images/done.png',
                        color: statusColor == ThemeColor().yellowColor
                            ? Colors.black
                            : Colors.white,
                        height: 14.toHeight,
                      )),
                  SizedBox(
                    width: 16.toWidth,
                  )
                ],
              ),
            )),
        secondChild: InkWell(
            onTap: () {
              valueExpaned.value = false;
            },
            child: _seconWidget()
        ),
        crossFadeState: !valueExpaned.value
            ? CrossFadeState.showFirst
            : CrossFadeState.showSecond,
        duration: Duration(milliseconds: 300)):_seconWidget();
  }

  _seconWidget() =>Container(
      height: 220.toHeight,
      margin: EdgeInsets.only(
          left: 16.toWidth, right: 16.toWidth, bottom: 4.toHeight),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.all(Radius.circular(16)),
        color: Colors.white,
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Expanded(
            child: Container(
              padding: EdgeInsets.all(24.toWidth),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Expanded(
                      child: ListView.builder(
                          shrinkWrap: true,
                          // physics: NeverScrollableScrollPhysics(),
                          itemCount: order.foods.length,
                          itemBuilder:
                              (BuildContext context, int index) {
                            return Container(
                                margin: EdgeInsets.only(
                                    bottom: 4.toHeight),
                                child: Column(
                                  crossAxisAlignment:
                                  CrossAxisAlignment.start,
                                  children: <Widget>[
                                    Text(
                                      "${order.foods[index].count??""}. ${order.foods[index].data.name ?? ''}",
                                      style: TextStyle(
                                          fontSize: 13.toFont,
                                          fontWeight:
                                          FontWeight.w500),
                                      maxLines: 3,
                                    ),
                                    SizedBox(
                                      height: 4.toHeight,
                                    ),
                                    Text(
                                      order.foods[index].data
                                          .information ??
                                          '',
                                      style: TextStyle(
                                          fontSize: 11.toFont),
                                    )
                                  ],
                                ));
                          })),
                  SizedBox(
                    width: 26.toWidth,
                  ),
                  Text(
                    order.order ?? '',
                    style: TextStyle(fontWeight: FontWeight.w700),
                  )
                ],
              ),
            ),
          ),
          InkWell(
            onTap: () {
              if (order.order != null) {
                if (order.status == 'go to rest') {
                  takeOrder(order.order);
                } else if (order.status == 'go to user') {
                  giveOrder(order.order);
                } else if (order.status == 'i want this') {
                  assignOrder(order.order);
                }
              }
            },
            child: Container(
              margin: EdgeInsets.only(
                left: 16,
                right: 16,
                bottom: 16,
              ),
              padding: EdgeInsets.all(16.toWidth),
              width: SizeConfig().screenHeight,
              height: 54.toHeight,
              color: statusColor,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: <Widget>[
                  Text(
                    statusText,
                    style: TextStyle(
                        fontSize: 19.toFont,
                        fontWeight: FontWeight.w700,
                        color: statusColor == ThemeColor().yellowColor
                            ? Colors.black
                            : Colors.white),
                  ),
                  SizedBox(
                    width: 4.toWidth,
                  ),
                  Image.asset(
                    'assets/images/done.png',
                    color: statusColor == ThemeColor().yellowColor
                        ? Colors.black
                        : Colors.white,
                    height: 19.toHeight,
                  )
                ],
              ),
            ),
          )
        ],
      ));
}
