class Order {
  String message;
  String done;
  String status;
  String order;
  String coords;

  Order.fromJson(Map<String, dynamic> json) {
    message = json['message'];
    done = json['done'];
    status = json['status'];
    order = json['order'];
    coords = json['coords'];
  }
}
