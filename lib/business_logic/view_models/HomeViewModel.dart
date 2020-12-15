import 'dart:async';
import 'dart:io';
import 'package:ari_kuryer/business_logic/models/Order.dart';
import 'package:ari_kuryer/services/api_helper/api_response.dart';
import 'package:ari_kuryer/services/hooks/use_callback.dart';
import 'package:ari_kuryer/services/services/order_service.dart';
import 'package:ari_kuryer/services/services/update_coords.dart';
import 'package:ari_kuryer/ui/common_widgets/error_handler.dart';
import 'package:ari_kuryer/ui/views/home/home.dart';
import 'package:audioplayers/audio_cache.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:geolocator/geolocator.dart';
import 'package:ari_kuryer/utils/size_config.dart';

class HomeViewModel extends HookWidget {
  Timer timer;
  Timer timer2;

  @override
  Widget build(BuildContext context) {
    var assignOrderId = useState<String>();
    var takeOrderId = useState<String>();
    var giveOrderId = useState<String>();

    var refreshKey = useState<UniqueKey>();
    var curyerCoords = useState<String>();

    //Timer for update  CURYER COORDINATES
    useEffect(() {
      timer = Timer.periodic(Duration(seconds: 5), (timer) {
        if (Platform.isAndroid) {
          Geolocator.checkPermission().then((value) {
            Geolocator.getCurrentPosition(
                    desiredAccuracy: LocationAccuracy.high)
                .then((value) {
              curyerCoords.value = '${value.latitude},${value.longitude}';
            });
          });
        }
      });
      return () {
        timer.cancel();
      };
    }, []);

    useEffect(() {
      timer2 = Timer.periodic(Duration(minutes: 1), (timer) {
        refreshKey.value=new UniqueKey();
      });
      return () {
        timer2.cancel();
      };
    }, []);
    //UPDATE CURYER COORDINATES
    useUpdateCuryerCoords(curyerCoords.value);

    //ASSIGN ORDER
    ApiResponse<OrderList> assignResponse =
        useAssignOrderList(assignOrderId.value);

    //TAKE ORDER
    ApiResponse<OrderList> takeResponse = useTakeOrderList(takeOrderId.value);

    //GIVE ORDER
    ApiResponse<OrderList> giveResponse = useGiveOrderList(giveOrderId.value);

    //Fetch ORDER
    ApiResponse<OrderList> apiResponse =
        useFetchOrderListStatus(refreshKey.value);

    useEffect(() {
      if (apiResponse.status == Status.Done) {
        for (int i = 0; i < apiResponse?.data.found; i++) {
          if (apiResponse?.data.order[i].status == 'i want this') {
            AudioCache().play("songs/buzz.mp3");
          }
          break;
        }
      }

      return () {};
    }, [apiResponse]);

    useEffect(() {
      refreshKey.value = new UniqueKey();

      return () {};
    }, [assignResponse]);

    useEffect(() {
      refreshKey.value = new UniqueKey();

      return () {};
    }, [takeResponse]);
    useEffect(() {
      refreshKey.value = new UniqueKey();
      return () {};
    }, [giveResponse]);

    //ASSIGN ORDER CALLBACK
    final assignOrderCallback = useCallback((String order) {
      if (order != null) {
        assignOrderId.value = order;
        refreshKey.value = new UniqueKey();
      }

      return () {};
    }, [assignOrderId.value]);

    //TAKE ORDER CALLBACK
    final takeOrderCallback = useCallback((String order) {
      if (order != null) {
        takeOrderId.value = order;
        refreshKey.value = new UniqueKey();
      }

      return () {};
    }, [takeOrderId.value]);

    //GIVE ORDER CALLBACK
    final giveOrderCallback = useCallback((String order) {
      if (order != null) {
        giveOrderId.value = order;
        refreshKey.value = new UniqueKey();
      }

      return () {};
    }, [giveOrderId.value]);

    return CustomErrorHandler(
      child: apiResponse?.data != null
          ? apiResponse?.data.message == null
              ? HomeView(
                  orders: apiResponse?.data.order,
                  assignOrder: assignOrderCallback,
                  takeOrder: takeOrderCallback,
                  giveOrder: giveOrderCallback,
                )
              : Container(
                  child: Center(
                    child: Container(
                      margin:
                      EdgeInsets.only(top: 16.toHeight, bottom: 16.toHeight),
                      child: Text(
                        'You have no order.',
                        style: TextStyle(fontWeight: FontWeight.w500),
                      ),
                    ),
                  )
                )
          : Container(),
      statuses: [apiResponse.status],
      errors: [apiResponse.error],
    );
  }
}
