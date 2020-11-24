import 'package:ari_kuryer/business_logic/routes/nested_root.dart';
import 'package:ari_kuryer/business_logic/routes/route_names.dart';
import 'package:ari_kuryer/business_logic/routes/route_navigation.dart';
import 'package:ari_kuryer/services/hooks/use_callback.dart';
import 'package:ari_kuryer/services/provider/provider.dart';
import 'package:ari_kuryer/ui/common_widgets/custom_appbar.dart';
import 'package:ari_kuryer/ui/provider/token_action.dart';
import 'package:ari_kuryer/ui/provider/token_status.dart';
import 'package:ari_kuryer/utils/sharedpref/sp_util.dart';
import 'package:ari_kuryer/utils/size_config.dart';
import 'package:ari_kuryer/utils/theme_color.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';

class InitPage extends HookWidget {
  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    final Store<TokenState, TokenAction> tokenStore = useTokenStore();
    useProviderRegistration(tokenStore);
    var hasToken = useState<bool>(false);

    SpUtil.getInstance().then((value) {
      hasToken.value = SpUtil.getString('token').isEmpty ? false : true;
    });
    useEffect(() {
      if (hasToken.value) {
        hasToken.value = true;
        tokenStore.dispatch(TokenAction(true));
        pushReplaceRouteWithName('/home');
      }
      return () {};
    }, [hasToken.value]);

    final getTokenCallBack = useCallback(() {
      hasToken.value = false;
      tokenStore.dispatch(TokenAction(false));
    }, []);
    // TODO: implement build
    return Scaffold(
        backgroundColor: Colors.white,
        appBar: CustomAppBar(
          hasToken: tokenStore.state.hasToken,
          clearToken: getTokenCallBack,
        ),
        body: Container(
          width: SizeConfig().screenWidth,
          height: SizeConfig().screenHeight,
          child: NestedNavigator(initialRoute: '/', routes: routeNames),
          decoration: BoxDecoration(
              color: ThemeColor().yellowColor,
              borderRadius: BorderRadius.only(
                  topRight: Radius.circular(20), topLeft: Radius.circular(20))),
        ));
  }
}
