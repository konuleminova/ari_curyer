import 'dart:async';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:ari_kuryer/utils/size_config.dart';

class GoogleMapView extends StatelessWidget {
  Completer<GoogleMapController> _controller = Completer();

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Container(
        margin: EdgeInsets.all(16.toWidth),
        decoration: BoxDecoration(
            borderRadius: BorderRadius.only(
                bottomLeft: Radius.circular(20),
                bottomRight: Radius.circular(20))),
        child: Stack(
          children: <Widget>[
            GoogleMap(
              mapType: MapType.normal,
              initialCameraPosition: CameraPosition(
                  target: LatLng(37.43296265331129, -122.08832357078792),
                  zoom: 18),
              onMapCreated: (GoogleMapController googleMapController) {
                _controller.complete(googleMapController);
              },
            ),
            Positioned(
              bottom: 0,
              left: 0,
              right: 0,
              child: Container(
                  height: 70.toHeight,
                  padding: EdgeInsets.all(16.toWidth),
                  color: Colors.black.withOpacity(0.4),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: <Widget>[
                      Container(
                        child: Column(
                          children: <Widget>[
                            Text(
                              'Name Surname',
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
                                'Address',
                                style: TextStyle(color: Colors.white),
                              ),
                            )
                          ],
                          crossAxisAlignment: CrossAxisAlignment.start,
                        ),
                      ),
                      Container(
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
                          ))
                    ],
                  )),
            )
          ],
        ));
  }
}
