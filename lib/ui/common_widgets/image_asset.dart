import 'package:flutter/material.dart';
import 'package:ari_kuryer/utils/size_config.dart';
class ImageAssetWidget extends StatelessWidget {
  final String path;
  final width;
  final height;

  ImageAssetWidget({this.path, this.width, this.height});

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Image.asset(
      path,
      height: width ?? 16.toHeight,
      width: height ?? 16.toHeight,
    );
  }
}