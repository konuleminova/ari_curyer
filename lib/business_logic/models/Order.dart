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
    rest_address=json['rest_address'];
  }
}
