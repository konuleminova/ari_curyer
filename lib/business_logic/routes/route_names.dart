import 'package:ari_kuryer/business_logic/view_models/LoginViewModel.dart';
import 'package:ari_kuryer/business_logic/view_models/HomeViewModel.dart';
import 'package:ari_kuryer/ui/views/home/home.dart';
import 'package:ari_kuryer/ui/views/splash.dart';

const ROUTE_LOGIN = '/';
const ROUTE_HOME = '/home';
final routeNames = {
// default rout as '/' is necessary!
  ROUTE_HOME: (context) => SplashScreen(),
  ROUTE_LOGIN: (context) => LoginViewModel(),
};
