import 'package:ari_kuryer/business_logic/view_models/LoginViewModel.dart';
import 'package:ari_kuryer/business_logic/view_models/HomeViewModel.dart';
import 'package:ari_kuryer/ui/views/home/home.dart';

const ROUTE_LOGIN = '/';
const ROUTE_HOME = '/home';
final routeNames = {
// default rout as '/' is necessary!
  ROUTE_HOME: (context) => HomeViewModel(),
  ROUTE_LOGIN: (context) => LoginViewModel(),
};
