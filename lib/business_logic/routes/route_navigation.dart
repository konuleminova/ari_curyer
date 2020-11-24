import 'package:ari_kuryer/business_logic/routes/nested_root.dart';
import 'package:ari_kuryer/ui/views/init.dart';

void pushRouteWithName(String name, {RouteArguments arguments}) {
  navigationKey.currentState.pushNamed(name, arguments: arguments);
}
void pushReplaceRouteWithName(String name, {RouteArguments arguments}) {
  navigationKey.currentState.pushReplacementNamed(name, arguments: arguments);
}
class RouteArguments<T> {
  T data;

  RouteArguments({this.data});
}
