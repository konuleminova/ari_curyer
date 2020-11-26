import 'dart:async';
import 'package:ari_kuryer/utils/map_utils.dart';
import 'package:ari_kuryer/utils/sharedpref/sp_util.dart';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:ari_kuryer/utils/size_config.dart';

class GoogleMapView extends StatelessWidget {
  Completer<GoogleMapController> _controller = Completer();
  double lat, lng;

  @override
  Widget build(BuildContext context) {
    String coords = SpUtil.getString('coords');
    var split=coords.split(",");
    lat = double.parse(split[0]);
    lng = double.parse(split[1]);

    print('LAT ${split[0]}');
    print('LNG ${split[1]}');

    // TODO: implement build
    return Container(
        margin: EdgeInsets.only(
            left: 16.toWidth, right: 16.toWidth, bottom: 16.toWidth),
        child: Stack(
          children: <Widget>[
            ClipRRect(
                borderRadius: BorderRadius.only(
                    bottomLeft: Radius.circular(10),
                    bottomRight: Radius.circular(10)),
                child: GoogleMap(
                  mapType: MapType.normal,
                  initialCameraPosition:
                      CameraPosition(target: LatLng(lat, lng), zoom: 13),
                  onMapCreated: (GoogleMapController googleMapController) {
                    _controller.complete(googleMapController);
                  },
                )),
            Positioned(
              bottom: 0,
              left: 0,
              right: 0,
              child: Container(
                  decoration: BoxDecoration(
                      color: Colors.black.withOpacity(0.5),
                      borderRadius: BorderRadius.only(
                          bottomLeft: Radius.circular(10),
                          bottomRight: Radius.circular(10))),
                  height: 70.toHeight,
                  padding: EdgeInsets.all(16.toWidth),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: <Widget>[
                      Expanded(
                        child: Container(
                          child: Column(
                            children: <Widget>[
                              Text(
                                SpUtil.getString('name'),
                                style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 14.toFont,
                                    fontWeight: FontWeight.w500),
                              ),
                              SizedBox(
                                height: 4.toHeight,
                              ),
                              Expanded(
                                  child: Text(
                                'Address: ${SpUtil.getString('coords')}',
                                style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 12.toFont,
                                ),
                                maxLines: 2,
                                overflow: TextOverflow.ellipsis,
                              ))
                            ],
                            crossAxisAlignment: CrossAxisAlignment.start,
                          ),
                        ),
                      ),
                      InkWell(
                        child: Container(
                            width: 90.toWidth,
                            height: 44.toHeight,
                            decoration: BoxDecoration(
                                color: Colors.white,
                                borderRadius: BorderRadius.circular(4)),
                            child: Center(
                              child: Text(
                                'Open in MAPS',
                                textAlign: TextAlign.center,
                                style: TextStyle(fontWeight: FontWeight.w400),
                              ),
                            )),
                        onTap: () {
                          MapUtils.openMap(lat, lng);
                        },
                      )
                    ],
                  )),
            )
          ],
        ));
  }
}
