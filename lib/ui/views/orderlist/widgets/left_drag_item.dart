import 'package:ari_kuryer/business_logic/models/OrderListResponse.dart';
import 'package:ari_kuryer/utils/theme_color.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:ari_kuryer/utils/size_config.dart';

class LeftDragItem extends StatelessWidget {
  Order order;

  LeftDragItem({this.order});

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Stack(
      children: <Widget>[
        Container(
            margin: EdgeInsets.only(
                bottom: 8.toHeight, top: 16.toHeight, right: 4.toWidth),
            width: MediaQuery.of(context).size.width,
            color: Color(0xFF72D84B),
            // height: 140.toHeight,
            padding: EdgeInsets.all(16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                ListView.builder(
                  shrinkWrap: true,
                  itemBuilder: (BuildContext context, int index) {
                    return Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          mainAxisSize: MainAxisSize.max,
                          children: <Widget>[
                            Text(
                              '${index + 1}. ${order.data[index].data.name}',
                              style: TextStyle(fontSize: 12.toFont,fontWeight: FontWeight.w600),
                            ),
                            SizedBox(
                              width: 16.toHeight,
                            ),
                            Expanded(
                              child: Text(order.data[index].data.price + " ₼",
                                  style: TextStyle(fontSize: 12.toFont)),
                            )
                          ],
                        ),
                        SizedBox(
                          height: 4.toHeight,
                        ),
                        Container(
                          child: Text(
                            order.data[index].data.information,
                            style: TextStyle(fontSize: 12.toFont),
                            textAlign: TextAlign.start,
                            overflow: TextOverflow.ellipsis,
                          ),
                          width: SizeConfig().screenWidth / 3,
                        )
                      ],
                    );
                  },
                  itemCount: order.data.length,
                ),
                SizedBox(
                  height: 4.toHeight,
                ),
                Container(
                  child: Text(
                    order.id,
                    style: TextStyle(
                      color: Colors.black,
                      fontWeight: FontWeight.w600,
                      fontSize: 14.toFont,
                    ),
                    textAlign: TextAlign.end,
                  ),
                  width: SizeConfig().screenWidth,
                )
              ],
            )),
        Positioned(
            right: 0,
            top: 0,
            child: CircleAvatar(
              radius: 14.toFont,
              child: Icon(
                Icons.done,
                color: Colors.black,
              ),
              backgroundColor: Color(0xFFFDCE26),
            ))
      ],
    );
  }
}
//     "3TOMAT ŞORBASI \n1POLLO CON GORGONZOLA \n \n5 BRUSCHETTA",
