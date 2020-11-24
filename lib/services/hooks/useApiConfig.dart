import 'package:ari_kuryer/services/api_helper/api_config.dart';
import 'package:flutter_hooks/flutter_hooks.dart';

ApiConfig useApiConfig() {
  return useMemoized(() => new ApiConfig(), []);
}
