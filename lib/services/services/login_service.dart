import 'package:ari_kuryer/business_logic/models/RestourantResponse.dart';
import 'package:ari_kuryer/services/api_helper/api_config.dart';
import 'package:ari_kuryer/services/api_helper/api_response.dart';
import 'package:ari_kuryer/services/api_helper/dio_config.dart';
import 'package:ari_kuryer/services/hooks/useApiConfig.dart';
import 'package:ari_kuryer/services/hooks/useDioRequest.dart';
import 'package:dio/dio.dart';
import 'package:flutter_hooks/flutter_hooks.dart';

ApiResponse<RestourantResponse> useLogin(String login, String password) {
  final ApiConfig apiConfig = useApiConfig();
  final DioConfig dioConfig = useMemoized(() {
    if (login.isEmpty && password.isEmpty) return null;

    return DioConfig<RestourantResponse>(
      path: apiConfig.LOGIN(login, password),
      transformResponse: (Response response) =>
          RestourantResponse.fromJson(response.data),
    );
  }, [login, password]);

  ApiResponse<RestourantResponse> apiResponse = useDioRequest(dioConfig);
  return apiResponse;
}
