import 'package:ari_kuryer/business_logic/routes/route_navigation.dart';
import 'package:ari_kuryer/utils/image_config.dart';
import 'package:ari_kuryer/utils/sharedpref/sp_util.dart';
import 'package:ari_kuryer/utils/theme_color.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:ari_kuryer/utils/size_config.dart';

import 'image_asset.dart';

class CustomAppBar extends HookWidget implements PreferredSizeWidget {
  @override
  Widget build(BuildContext context) {
    var onClickIndex = useState<int>(0);
    useEffect(() {
      onClickIndex.value = 0;
      return () {};
    }, [onClickIndex]);
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
                child: SpUtil.getString('token').isNotEmpty
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
                                  Text('A34005',
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
                                  'Cıxış',
                                  style: TextStyle(
                                      color: Colors.white, fontSize: 14.toFont),
                                ),
                              ),
                              onTap: () {
                                SpUtil.remove('token');
                                pushReplaceRouteWithName('/');

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
                  child: ImageAssetWidget(
                path: LOGO_ASSET,
                width: 40.toHeight,
                height: 40.toHeight,
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
  Size get preferredSize => Size.fromHeight(50.toHeight);
}
