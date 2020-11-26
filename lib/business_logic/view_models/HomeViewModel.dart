import 'dart:async';
import 'dart:io';
import 'package:ari_kuryer/business_logic/models/Order.dart';
import 'package:ari_kuryer/business_logic/routes/route_navigation.dart';
import 'package:ari_kuryer/services/api_helper/api_response.dart';
import 'package:ari_kuryer/services/hooks/use_callback.dart';
import 'package:ari_kuryer/services/services/order_service.dart';
import 'package:ari_kuryer/services/services/update_coords.dart';
import 'package:ari_kuryer/ui/common_widgets/error_handler.dart';
import 'package:ari_kuryer/ui/views/home/home.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:geolocator/geolocator.dart';
import 'package:location_permissions/location_permissions.dart';

class HomeViewModel extends HookWidget {
  Timer timer;

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
    //UPDATE CURYER COORDINATES
    useUpdateCuryerCoords(curyerCoords.value);

    //ASSIGN ORDER
    ApiResponse<Order> assignResponse = useAssignOrder(assignOrderId.value);

    //TAKE ORDER
    ApiResponse<Order> takeResponse = useTakeOrder(takeOrderId.value);

    //GIVE ORDER
    ApiResponse<Order> giveResponse = useGiveOrder(giveOrderId.value);

    //Fetch ORDER
    ApiResponse<Order> apiResponse = useFetchOrderStatus(refreshKey.value);

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
      }

      return () {};
    }, [assignOrderId.value]);

    //TAKE ORDER CALLBACK
    final takeOrderCallback = useCallback((String order) {
      if (order != null) {
        takeOrderId.value = order;
      }

      return () {};
    }, [takeOrderId.value]);

    //GIVE ORDER CALLBACK
    final giveOrderCallback = useCallback((String order) {
      if (order != null) {
        giveOrderId.value = order;
      }

      return () {};
    }, [giveOrderId.value]);

    return CustomErrorHandler(
      child:  HomeView(
              order: apiResponse?.data,
              assignOrder: assignOrderCallback,
              takeOrder: takeOrderCallback,
              giveOrder: giveOrderCallback,
            ),
      statuses: [apiResponse.status],
      errors: [apiResponse.error],
    );
  }
}
