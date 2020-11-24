import 'package:ari_kuryer/business_logic/view_models/LoginViewModel.dart';
import 'package:ari_kuryer/business_logic/view_models/OrderListViewModel.dart';

const ROUTE_LOGIN = '/';
const ROUTE_HOME = '/home';
final routeNames = {
// default rout as '/' is necessary!
  ROUTE_HOME: (context) => OrderListViewModel(),
  ROUTE_LOGIN: (context) => LoginViewModel(),
};
