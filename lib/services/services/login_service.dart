import 'package:ari_kuryer/business_logic/models/Curyer.dart';
import 'package:ari_kuryer/services/api_helper/api_config.dart';
import 'package:ari_kuryer/services/api_helper/api_response.dart';
import 'package:ari_kuryer/services/api_helper/dio_config.dart';
import 'package:ari_kuryer/services/hooks/useApiConfig.dart';
import 'package:ari_kuryer/services/hooks/useDioRequest.dart';
import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_hooks/flutter_hooks.dart';

ApiResponse<Curyer> useLogin(String login, String password, UniqueKey key) {
  final ApiConfig apiConfig = useApiConfig();
  final DioConfig dioConfig = useMemoized(() {
    if (login.isEmpty && password.isEmpty && key == null) return null;

    return DioConfig<Curyer>(
      path: apiConfig.LOGIN(login, password),
      transformResponse: (Response response) => Curyer.fromJson(response.data),
    );
  }, [login, password, key]);

  ApiResponse<Curyer> apiResponse = useDioRequest(dioConfig);
  return apiResponse;
}
