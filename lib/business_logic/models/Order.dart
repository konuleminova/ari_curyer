class OrderList {
  int found;
  List<Order> order;
  String message;

  OrderList.fromJson(Map<String, dynamic> json) {
    found = json['found'];
    order = json['data'] != 'waiting' || json['error'] == '1'
        ? listOrdersFromJson(json['data'])
        : [];
    message = json['data'] == 'waiting'
        ? json['data']
        : json['error'] == '1'
            ? json['message']
            : null;
  }
}

listOrdersFromJson(List<dynamic> orders) =>
    List<Order>.from(orders.map((e) => Order.fromJson(e)));

class Order {
  String message;
  String done;
  String status;
  String order;
  String coords;
  String user_address;
  String user_coords;
  String user_name;
  String user_phone;
  String rest_coords;
  String rest_name;
  String rest_address;
  List<Food> foods;
  String finished_time;
  String km;

  Order.fromJson(Map<String, dynamic> json) {
    message = json['message'];
    done = json['done'];
    status = json['status'];
    order = json['order'];
    coords = json['coords'];
    user_address = json['user_address'];
    user_coords = json['user_coords'];
    rest_coords = json['rest_coords'];
    rest_name = json['rest_name'];
    user_name = json['user_name'];
    user_phone = json['user_phone'];
    rest_address = json['rest_address'];
    foods = json['foods'] != null ? listFoodFromJson(json['foods']) : null;
    finished_time = json['finished_time'] ?? '';
    km = json['km'] ?? '';
  }
}

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
  var count;
  Data data;

  Food.fromJson(Map<String, dynamic> json) {
    data = Data.fromJson(json['food']);
    count = json['count'];
  }
}

listFoodFromJson(List<dynamic> foodList) =>
    List<Food>.from(foodList.map((e) => Food.fromJson(e)));
