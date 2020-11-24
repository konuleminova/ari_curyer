import 'package:dio/dio.dart';

class DioConfig<T> {
  final String path;
  final dynamic data;
  Map<String, dynamic> queryParamaters;
  Options options;
  final ProgressCallback onSendProgress;
  final ProgressCallback onReceiveProgress;
  final T Function(Response response) transformResponse;

  DioConfig(
      {this.path,
      this.data,
      this.queryParamaters,
      this.options,
      this.onSendProgress,
      this.onReceiveProgress,
      this.transformResponse});
}
