import 'package:ari_kuryer/business_logic/models/Order.dart';
import 'package:ari_kuryer/services/api_helper/api_config.dart';
import 'package:ari_kuryer/services/api_helper/api_response.dart';
import 'package:ari_kuryer/services/api_helper/dio_config.dart';
import 'package:ari_kuryer/services/hooks/useApiConfig.dart';
import 'package:ari_kuryer/services/hooks/useDioRequest.dart';
import 'package:ari_kuryer/utils/sharedpref/sp_util.dart';
import 'package:dio/dio.dart';
import 'package:flutter_hooks/flutter_hooks.dart';

ApiResponse<Order> useGiveOrder(String coords) {
  final ApiConfig apiConfig = useApiConfig();
  final DioConfig dioConfig = useMemoized(() {
    if (coords == null) return null;
    return DioConfig<Order>(
        path: apiConfig.UPDATE_COORDS(coords, SpUtil.getString('token')),
        transformResponse: (Response response) =>
            Order.fromJson(response.data));
  }, [coords]);
  ApiResponse<Order> apiResponse = useDioRequest(dioConfig);
  return apiResponse;
}