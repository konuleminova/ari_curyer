import 'package:ari_kuryer/business_logic/models/Order.dart';
import 'package:ari_kuryer/services/api_helper/api_response.dart';
import 'package:ari_kuryer/services/services/order_service.dart';
import 'package:ari_kuryer/ui/common_widgets/error_handler.dart';
import 'package:ari_kuryer/ui/views/home/home.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_hooks/flutter_hooks.dart';

class HomeViewModel extends HookWidget {
  @override
  Widget build(BuildContext context) {
    ApiResponse<Order> apiResponse = useFetchOrderStatus();

    return CustomErrorHandler(
      child: HomeView(order: (apiResponse.data)),
      statuses: [apiResponse.status],
      errors: [apiResponse.error],
    );
  }
}
