class RestourantResponse {
  String found;
  String restid;
  String name;
  String coords;
  String token;

  RestourantResponse.fromJson(Map<String, dynamic> json) {
    found = json['found'];
    restid = json['restid'];
    name = json['name'];
    coords = json['coords'];
    token = json['token'];
  }
}
