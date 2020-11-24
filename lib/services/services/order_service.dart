import 'package:ari_kuryer/business_logic/models/Order.dart';
import 'package:ari_kuryer/services/api_helper/api_config.dart';
import 'package:ari_kuryer/services/api_helper/api_response.dart';
import 'package:ari_kuryer/services/api_helper/dio_config.dart';
import 'package:ari_kuryer/services/hooks/useApiConfig.dart';
import 'package:ari_kuryer/services/hooks/useDioRequest.dart';
import 'package:ari_kuryer/utils/sharedpref/sp_util.dart';
import 'package:dio/dio.dart';
import 'package:flutter_hooks/flutter_hooks.dart';

ApiResponse<Order> useFetchOrderStatus() {
  final ApiConfig apiConfig = useApiConfig();
  final DioConfig dioConfig = useMemoized(
      () => DioConfig<Order>(
          path: apiConfig.FETCH_ORDER_STATUS(SpUtil.getString('token')),
          transformResponse: (Response response) =>
              Order.fromJson(response.data)),
      []);
  ApiResponse<Order> apiResponse = useDioRequest(dioConfig);
  return apiResponse;
}

ApiResponse<Order> useAssignOrder(String orderId) {
  final ApiConfig apiConfig = useApiConfig();
  final DioConfig dioConfig = useMemoized(() {
    if (orderId == null) return null;
    return DioConfig<Order>(
        path: apiConfig.ASSIGN_ORDER(orderId, SpUtil.getString('token')),
        transformResponse: (Response response) =>
            Order.fromJson(response.data));
  }, [orderId]);
  ApiResponse<Order> apiResponse = useDioRequest(dioConfig);
  return apiResponse;
}
