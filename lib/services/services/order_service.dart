import 'package:ari_kuryer/business_logic/models/Order.dart';
import 'package:ari_kuryer/services/api_helper/api_config.dart';
import 'package:ari_kuryer/services/api_helper/api_response.dart';
import 'package:ari_kuryer/services/api_helper/dio_config.dart';
import 'package:ari_kuryer/services/hooks/useApiConfig.dart';
import 'package:ari_kuryer/services/hooks/useDioRequest.dart';
import 'package:ari_kuryer/utils/sharedpref/sp_util.dart';
import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_hooks/flutter_hooks.dart';

//Get OrderList status
ApiResponse<OrderList> useFetchOrderListStatus(UniqueKey key) {
  final ApiConfig apiConfig = useApiConfig();
  final DioConfig dioConfig = useMemoized(
      () => DioConfig<OrderList>(
          path: apiConfig.FETCH_ORDER_STATUS(SpUtil.getString('token')),
          transformResponse: (Response response) =>
              OrderList.fromJson(response.data)),
      [key]);
  ApiResponse<OrderList> apiResponse = useDioRequest(dioConfig);
  return apiResponse;
}

//Assign OrderList
ApiResponse<OrderList> useAssignOrderList(String OrderListId) {
  final ApiConfig apiConfig = useApiConfig();
  final DioConfig dioConfig = useMemoized(() {
    if (OrderListId == null)
      return null;
      return DioConfig<OrderList>(
          path: apiConfig.ASSIGN_ORDER(OrderListId, SpUtil.getString('token')),
          transformResponse: (Response response) =>
              OrderList.fromJson(response.data));
  }, [OrderListId]);
  ApiResponse<OrderList> apiResponse = useDioRequest(dioConfig);
  return apiResponse;
}

//Take OrderList
ApiResponse<OrderList> useTakeOrderList(String OrderListId) {
  final ApiConfig apiConfig = useApiConfig();
  final DioConfig dioConfig = useMemoized(() {
    if (OrderListId == null) return null;
    return DioConfig<OrderList>(
        path: apiConfig.TAKE_ORDER(OrderListId, SpUtil.getString('token')),
        transformResponse: (Response response) =>
            OrderList.fromJson(response.data));
  }, [OrderListId]);
  ApiResponse<OrderList> apiResponse = useDioRequest(dioConfig);
  return apiResponse;
}

//Give OrderList
ApiResponse<OrderList> useGiveOrderList(String OrderListId) {
  final ApiConfig apiConfig = useApiConfig();
  final DioConfig dioConfig = useMemoized(() {
    if (OrderListId == null) return null;
    return DioConfig<OrderList>(
        path: apiConfig.GIVE_ORDER(OrderListId, SpUtil.getString('token')),
        transformResponse: (Response response) =>
            OrderList.fromJson(response.data));
  }, [OrderListId]);
  ApiResponse<OrderList> apiResponse = useDioRequest(dioConfig);
  return apiResponse;
}
