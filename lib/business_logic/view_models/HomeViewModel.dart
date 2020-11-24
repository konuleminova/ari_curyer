import 'package:ari_kuryer/business_logic/models/Order.dart';
import 'package:ari_kuryer/services/api_helper/api_response.dart';
import 'package:ari_kuryer/services/hooks/use_callback.dart';
import 'package:ari_kuryer/services/services/order_service.dart';
import 'package:ari_kuryer/ui/common_widgets/error_handler.dart';
import 'package:ari_kuryer/ui/views/home/home.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_hooks/flutter_hooks.dart';

class HomeViewModel extends HookWidget {
  @override
  Widget build(BuildContext context) {
    var orderId = useState<String>();
    var fetchOrderStatusKey = useState<UniqueKey>();

    useAssignOrder(orderId.value);
    ApiResponse<Order> apiResponse =
        useFetchOrderStatus(fetchOrderStatusKey.value);

    final assignOrderCallback = useCallback((String order) {
      if (order != null) {
        orderId.value = order;
        fetchOrderStatusKey.value = new UniqueKey();
      }

      return () {};
    }, [orderId.value]);

    return CustomErrorHandler(
      child: HomeView(
        order: (apiResponse.data),
        assignOrder: assignOrderCallback,
      ),
      statuses: [apiResponse.status],
      errors: [apiResponse.error],
    );
  }
}
