import 'dart:async';

import 'package:ari_kuryer/business_logic/models/OrderListResponse.dart';
import 'package:ari_kuryer/ui/views/orderlist/widgets/timer_widget.dart';
import 'package:ari_kuryer/utils/theme_color.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:ari_kuryer/utils/size_config.dart';

class RightDragItem extends StatelessWidget {
  Order order;

  RightDragItem({this.order});

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Stack(
      children: <Widget>[
        Container(
            margin: EdgeInsets.only(
                bottom: 8.toHeight, right: 4.toWidth, top: 16.toHeight),
            width: MediaQuery.of(context).size.width,
            color: Colors.black,
            padding: EdgeInsets.all(16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                ListView.builder(
                  itemBuilder: (BuildContext context, int index) {
                    return Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          mainAxisSize: MainAxisSize.max,
                          children: <Widget>[
                            Text(
                              order.data[index].data.name,
                              style: TextStyle(
                                  color: Colors.white, fontSize: 12.toFont),
                            ),
                            SizedBox(
                              width: 16.toHeight,
                            ),
                            Expanded(
                              child: Text(order.data[index].data.price + " ₼",
                                  style: TextStyle(
                                      color: Colors.green,
                                      fontSize: 12.toFont)),
                            )
                          ],
                        ),
                        SizedBox(
                          height: 4.toHeight,
                        ),
                        Container(
                          child: Text(
                            order.data[index].data.information,
                            style: TextStyle(
                                color: Colors.white.withOpacity(0.7),
                                fontSize: 12.toFont),
                            textAlign: TextAlign.start,
                            overflow: TextOverflow.ellipsis,
                          ),
                          width: SizeConfig().screenWidth / 3,
                          alignment: Alignment.topLeft,
                        )
                      ],
                    );
                  },
                  itemCount: order.data.length,
                  shrinkWrap: true,
                  physics: NeverScrollableScrollPhysics(),
                ),
                SizedBox(
                  height: 8.toHeight,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    TimerText(
                        dateText: order.dt,
                        style: TextStyle(
                          color: ThemeColor().yellowColor,
                          fontSize: 14.toFont,
                          fontWeight: FontWeight.w500
                        )),
                    Text(
                      order.id ?? '',
                      style: TextStyle(
                          color: Colors.white,
                          fontSize: 14.toFont,
                          fontWeight: FontWeight.w600),
                    )
                  ],
                )
              ],
            )),
        Positioned(
            right: 0,
            top: 0,
            child: CircleAvatar(
              radius: 14.toFont,
              child: Icon(
                Icons.more_horiz,
                color: Colors.black,
              ),
              backgroundColor: Colors.white,
            ))
      ],
    );
  }
}
//"3TOMAT ŞORBASI \n1POLLO CON GORGONZOLA \n \n5 BRUSCHETTA",
