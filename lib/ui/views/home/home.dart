import 'package:ari_kuryer/business_logic/models/Order.dart';
import 'package:ari_kuryer/ui/views/google_map/google_map.dart';
import 'package:ari_kuryer/ui/views/home/widgets/order_item.dart';
import 'package:ari_kuryer/utils/size_config.dart';
import 'package:ari_kuryer/utils/theme_color.dart';
import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart' as UrlLauncher;

class HomeView extends StatelessWidget {
  final List<Order> orders;
  final Function(String orderId) assignOrder;
  final Function(String orderId) takeOrder;
  final Function(String orderId) giveOrder;

  HomeView({this.orders, this.assignOrder, this.giveOrder, this.takeOrder});

//
  @override
  Widget build(BuildContext context) {
    print('ORDERS lenth ${orders.length}');
    // TODO: implement build
    return orders != null
        ? orders.length < 1
            ? Center(
                child: Container(
                  margin:
                      EdgeInsets.only(top: 16.toHeight, bottom: 16.toHeight),
                  child: Text(
                    'You have no order.',
                    style: TextStyle(fontWeight: FontWeight.w500),
                  ),
                ),
              )
            : Container(
                margin: EdgeInsets.only(top: 16.toHeight),
                child: ListView.builder(
                    shrinkWrap: true,
                    itemCount: orders.length,
                    itemBuilder: (BuildContext context, int index) {
                      return Container(
                        child: Column(
                          children: <Widget>[
                            OrderItemWidget(
                              order: orders[index],
                              assignOrder: assignOrder,
                              takeOrder: takeOrder,
                              giveOrder: giveOrder,
                            ),
                            orders[index].status == 'go to user' ||
                                    orders[index].status == 'go to rest'
                                ? Column(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceEvenly,
                                    children: [
                                      SizedBox(
                                        height: 8,
                                      ),
                                      Container(
                                          height: 280.toHeight,
                                          child: GoogleMapView(
                                            coords: orders[index].status ==
                                                    'go to user'
                                                ? orders[index].user_coords
                                                : orders[index].rest_coords,
                                            name: orders[index].status ==
                                                    'go to user'
                                                ? orders[index].user_name ?? ''
                                                : orders[index].rest_name ?? '',
                                            address: orders[index].status ==
                                                    'go to user'
                                                ? orders[index].user_address ??
                                                    ''
                                                : orders[index].rest_address ??
                                                    '',
                                          )),
                                      orders[index].status == 'go to user'
                                          ? InkWell(
                                              child: Container(
                                                  decoration: BoxDecoration(
                                                      border: Border.all(
                                                          color: ThemeColor()
                                                              .grey1),
                                                      color: ThemeColor().blue),
                                                  padding: EdgeInsets.symmetric(
                                                      horizontal: 24.toWidth),
                                                  height: 56.toHeight,
                                                  alignment: Alignment.center,
                                                  child: Row(
                                                    mainAxisAlignment:
                                                        MainAxisAlignment
                                                            .spaceBetween,
                                                    children: <Widget>[
                                                      Text(
                                                        orders[index]
                                                                .user_name ??
                                                            '',
                                                        style: TextStyle(
                                                            color: Colors.white,
                                                            fontWeight:
                                                                FontWeight.w500,
                                                            fontSize:
                                                                16.toFont),
                                                      ),
                                                      Image.asset(
                                                        'assets/images/call.png',
                                                        width: 30,
                                                        height: 30,
                                                        color: Colors.white,
                                                      )
                                                    ],
                                                  )),
                                              onTap: () => UrlLauncher.launch(
                                                  "tel://${orders[index].user_phone}"),
                                            )
                                          : SizedBox()
                                    ],
                                  )
                                : SizedBox()
                          ],
                        ),
                        //height: SizeConfig().screenHeight,
                        //width: SizeConfig().screenWidth,
                      );
                    }))
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
