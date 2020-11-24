import 'dart:async';
import 'dart:math';

import 'package:ari_kuryer/business_logic/models/Order.dart';
import 'package:ari_kuryer/services/api_helper/api_response.dart';
import 'package:ari_kuryer/services/hooks/use_callback.dart';
import 'package:ari_kuryer/services/services/order_service.dart';
import 'package:ari_kuryer/services/services/update_coords.dart';
import 'package:ari_kuryer/ui/common_widgets/error_handler.dart';
import 'package:ari_kuryer/ui/views/home/home.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_hooks/flutter_hooks.dart';

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
        curyerCoords.value = UniqueKey().toString();
      });
      return () {
        timer.cancel();
      };
    }, []);

    //UPDATE CURYER COORDINATES
    useUpdateCuryerCoords(curyerCoords.value);

    //ASSIGN ORDER
    useAssignOrder(assignOrderId.value);

    //TAKE ORDER
    useTakeOrder(takeOrderId.value);

    //GIVE ORDER
    useGiveOrder(giveOrderId.value);

    //Fetch ORDER
    ApiResponse<Order> apiResponse = useFetchOrderStatus(refreshKey.value);

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
      child: HomeView(
        order: (apiResponse.data),
        assignOrder: assignOrderCallback,
        takeOrder: takeOrderCallback,
        giveOrder: giveOrderCallback,
      ),
      statuses: [apiResponse.status],
      errors: [apiResponse.error],
    );
  }
}
