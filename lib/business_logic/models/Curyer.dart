class Curyer {
  String found;
  String restid;
  String name;
  String coords;
  String token;

  Curyer.fromJson(Map<String, dynamic> json) {
    found = json['found'];
    restid = json['restid'];
    name = json['name'];
    coords = json['coords'];
    token = json['token'];
  }
}
