import 'package:ari_kuryer/services/api_helper/api_response.dart';
import 'package:ari_kuryer/services/api_helper/dio_config.dart';
import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_hooks/flutter_hooks.dart';

ApiResponse<T> useDioRequest<T>(DioConfig<T> config) {
  final ValueNotifier<ApiResponse<T>> _state =
      useState<ApiResponse<T>>(ApiResponse.initial());
  Dio dio = useMemoized(() => Dio());
  useEffect(() {
    bool isCancel = false;
    CancelToken cancelToken;
    if (config != null) {
       print('REQUESTED URL: ${config.path}');
      _state.value = ApiResponse.loading();
      cancelToken = CancelToken();
      dio
          .request(config.path,
              data: config.data,
              queryParameters: config.queryParamaters,
              options: config.options,
              onSendProgress: config.onSendProgress,
              onReceiveProgress: config.onReceiveProgress,
              cancelToken: cancelToken)
          .then((value) {
        if (!isCancel) {
          print('IsCanceled: $isCancel');
          print('VALUE DATA ${value.data}');
          if (value.data['error'] != '1') {
            _state.value =
                ApiResponse.completed(config.transformResponse(value));
          } else {
            _state.value =
                ApiResponse.error(AppException(message: value.data['message']));
          }
        }
      }).catchError((error) {
        if (!isCancel) {
          _state.value =
              ApiResponse.error(AppException(message: error.toString()));
        }
      });
    } else {
      _state.value = ApiResponse.initial();
    }
    return () {
      print('Dispose -> Cancelled');
      isCancel = true;
      if (cancelToken != null) {
        cancelToken.cancel('Request Cancelled');
        cancelToken = null;
      }
    };
  }, [config]);
  //print('STATEB VALUE ${_state.value}');
  return _state.value;
}
