
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
          backgroundColor: Colors.white,
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
      ],
    );
  }

//final AppBar appBar=
  @override
  // TODO: implement preferredSize
  Size get preferredSize => Size.fromHeight(44.toHeight);
}
