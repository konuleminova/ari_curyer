import 'package:ari_kuryer/business_logic/models/OrderListResponse.dart';
import 'package:ari_kuryer/services/api_helper/api_response.dart';
import 'package:ari_kuryer/services/hooks/use_callback.dart';
import 'package:ari_kuryer/services/services/orderList_service.dart';
import 'package:ari_kuryer/ui/common_widgets/error_handler.dart';
import 'package:ari_kuryer/ui/views/orderlist/order_list.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:ari_kuryer/utils/size_config.dart';

class OrderListViewModel extends HookWidget {
  @override
  Widget build(BuildContext context) {
    final ValueNotifier<UniqueKey> keyRefresh1 = useState();
    final ValueNotifier<UniqueKey> keyRefresh2 = useState();
    final ValueNotifier<Map<String, bool>> acceptTarget =
        useState<Map<String, bool>>(Map<String, bool>());
    final ValueNotifier<String> id = useState();
    final ValueNotifier<ScrollController> listScrollController =
        useState(ScrollController());
    //On Drag Accept CallBack
    useChangeStatus(id?.value, keyRefresh2?.value);
    //Use fetch Order list
    ApiResponse<OrderListResponse> apiResponse =
        useOrderList(keyRefresh1.value);
    useMemoized(() {
      print('WAIITGNCOrders1 ${apiResponse?.data?.waitingOrders}');
      if (apiResponse.status == Status.Done) {
        apiResponse.data.waitingOrders.forEach((element) {
          acceptTarget.value[element.id] = false;
        });
        apiResponse.data.finishedOrders.forEach((element) {
          acceptTarget.value[element.id] = false;
        });
      }
    }, [apiResponse]);

    //On drag Started Callback
    final onDragStartCallBack = useCallback((String idWaitingOrder) {
      id.value = idWaitingOrder;
      listScrollController.value.animateTo(
          listScrollController.value.position.maxScrollExtent + 270.toHeight,
          curve: Curves.easeOut,
          duration: Duration(milliseconds: 500));
//      if (apiResponse.status == Status.Done) {
//        acceptTarget.value[apiResponse.data.waitingOrders[index].id] =
//            !acceptTarget.value[apiResponse.data.waitingOrders[index].id];
//
//        acceptTarget.notifyListeners();
//      }
      return () {};
    }, [id.value]);

    final onDragAcceptCallBack = useCallback(() {
      keyRefresh2.value = new UniqueKey();
    }, [keyRefresh2.value]);

//On refresh Data Callback
    final onRefreshDataCallBack = useCallback(() {
      keyRefresh1.value = new UniqueKey();
    }, [keyRefresh1.value]);
    // TODO: implement build
    return CustomErrorHandler(
      statuses: [apiResponse.status],
      errors: [apiResponse.error],
      child: OrderListView(
          orderListResponse: apiResponse.data,
          acceptTarget: acceptTarget.value,
          onDragStartCallback: onDragStartCallBack,
          scrollController: listScrollController.value,
          onDragAcceptCallBack: onDragAcceptCallBack,
          onRefreshDataCallBack: onRefreshDataCallBack),
    );
  }
}
