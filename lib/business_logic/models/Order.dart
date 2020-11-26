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
    rest_address = json['rest_address'];
    foods = listFoodFromJson(json['foods']);
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
  int count;
  Data data;

  Food.fromJson(Map<String, dynamic> json) {
    data = Data.fromJson(json['food']);
    count = json['count'];
  }
}

listFoodFromJson(List<dynamic> foodList) =>
    List<Food>.from(foodList.map((e) => Food.fromJson(e)));
