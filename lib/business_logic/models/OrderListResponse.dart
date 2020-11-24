import 'package:ari_kuryer/business_logic/models/RestourantResponse.dart';

class OrderListResponse extends RestourantResponse {
  List<Order> waitingOrders;
  List<Order> finishedOrders;

  OrderListResponse.fromJson(Map<String, dynamic> json) : super.fromJson(json) {
    found = json['found'];
    restid = json['restid'];
    name = json['name'];
    coords = json['coords'];
    waitingOrders = listOrderFromJson(json['finished_orders']);
    finishedOrders = listOrderFromJson(json['finished_orders']);
  }
}

class Order {
  String id;
  String restid;
  List<Food> data;
  String dt;
  String md5key;
  String finished;

  Order.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    restid = json['restid'];
    data = listFoodFromJson(json['data']);
    dt = json['dt'];
    md5key = json['md5key'];
    finished = json['finished'];
  }
}

listOrderFromJson(List<dynamic> orderList) =>
    List<Order>.from(orderList.map((e) => Order.fromJson(e)));

class Data {
  String id;
  String name;
  String price;
  String information;
  String menu_id;
  String restourant_id;
  List adds;

  Data.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    price = json['price'];
    information = json['information'];
    menu_id = json['menu_id'];
    restourant_id = json['restourant_id'];
  }
}

class Food {
  int count;
  Data data;

  Food.fromJson(Map<String, dynamic> json) {
    data = Data.fromJson(json['food']);
    count = json['count'];
  }
}

listFoodFromJson(List<dynamic> foodList) =>
    List<Food>.from(foodList.map((e) => Food.fromJson(e)));
