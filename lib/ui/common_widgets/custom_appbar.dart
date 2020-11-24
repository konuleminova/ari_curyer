
import 'package:ari_kuryer/utils/image_config.dart';
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
          backgroundColor: ThemeColor().greenColor,
          title: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              Container(
                width: 200,
                margin: EdgeInsets.only(left: 8.toWidth),
                alignment: Alignment.bottomCenter,
              ),
              Expanded(
                flex: 2,
                child: Container(
                  height: 54.toHeight,
                ),
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
        Positioned(
          bottom: 3,
          left: 0,
          right: 0,
          child: Container(
              decoration: BoxDecoration(
                  color: ThemeColor().yellowColor,
                  borderRadius: BorderRadius.only(
                      topRight: Radius.circular(20),
                      topLeft: Radius.circular(20))),
              height: 44.toHeight,
              padding: EdgeInsets.symmetric(horizontal: 4.toWidth),
              child: Center(
                child: Text(
                  'Доброе утро Ильхам, сегодня в Баку 23 оС, отличная погода...',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                      fontWeight: FontWeight.bold, fontSize: 11.toFont),
                ),
              )),
        ),
        Positioned(
          child: Container(
            height: 4,
            color: ThemeColor().yellowColor
          ),
          bottom: 0,
          left: 0,
          right: 0,
        )
      ],
    );
  }

//final AppBar appBar=
  @override
  // TODO: implement preferredSize
  Size get preferredSize => Size.fromHeight(85.toHeight);
}
