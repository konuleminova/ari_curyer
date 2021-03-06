import 'package:ari_kuryer/business_logic/routes/route_names.dart';
import 'package:ari_kuryer/business_logic/routes/route_navigation.dart';
import 'package:ari_kuryer/services/services/login_service.dart';
import 'package:ari_kuryer/utils/image_config.dart';
import 'package:ari_kuryer/utils/sharedpref/sp_util.dart';
import 'package:ari_kuryer/utils/theme_color.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:ari_kuryer/utils/size_config.dart';

import 'image_asset.dart';

class CustomAppBar extends HookWidget implements PreferredSizeWidget {
  final bool hasToken;
  final Function clearToken;

  CustomAppBar({this.hasToken, this.clearToken});

  @override
  Widget build(BuildContext context) {
    ValueNotifier<UniqueKey> logoutKey = useState<UniqueKey>();
    useLogout(logoutKey.value);
    // TODO: implement build
    return Stack(
      children: <Widget>[
        AppBar(
          actions: <Widget>[SizedBox()],
          elevation: 0,
          backgroundColor: Colors.white,
          title: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              Expanded(
                flex: 4,
                child: hasToken
                    ? Container(
                        child: Row(
                          children: <Widget>[
                            Container(
                              width: 200,
                              margin: EdgeInsets.only(
                                  left: 4.toWidth, top: 8.toHeight),
                              alignment: Alignment.centerLeft,
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                mainAxisAlignment: MainAxisAlignment.end,
                                children: <Widget>[
                                  Text(
                                    SpUtil.getString('name'),
                                    style: TextStyle(fontSize: 15.toFont),
                                  ),
                                  SizedBox(
                                    height: 2.toHeight,
                                  ),
                                  Text('User id: ${SpUtil.getString('userid')}',
                                      style: TextStyle(fontSize: 12.toFont))
                                ],
                              ),
                            ),
                            Expanded(
                                child: InkWell(
                              child: Container(
                                height: 28.toWidth,
                                width: 24.toWidth,
                                alignment: Alignment.center,
                                decoration: BoxDecoration(
                                    color: ThemeColor().blue,
                                    borderRadius: BorderRadius.circular(20)),
                                child: Text(
                                  '????x????',
                                  style: TextStyle(
                                      color: Colors.white, fontSize: 14.toFont),
                                ),
                              ),
                              onTap: () {
                                logoutKey.value = new UniqueKey();
                                Future.delayed(Duration(milliseconds: 500))
                                    .then((value) {
                                  clearToken.call();
                                  SpUtil.remove('token').then((value) {
                                    pushReplaceRouteWithName('/');
                                  });
                                });
                              },
                            )),
                          ],
                        ),
                      )
                    : SizedBox(),
              ),
              SizedBox(
                width: 16.toWidth,
              ),
              Expanded(
                  child: InkWell(
                child: ImageAssetWidget(
                  path: LOGO_ASSET,
                  width: 40.toHeight,
                  height: 40.toHeight,
                ),
                onTap: () {
                  pushReplaceRouteWithName(ROUTE_HOME);
                },
              ))
            ],
          ),
        ),
      ],
    );
  }

//final AppBar appBar=
  @override
  // TODO: implement preferredSize
  Size get preferredSize => Size.fromHeight(54.toHeight);
}
