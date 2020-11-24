class Curyer {
  String found;
  String userid;
  String name;
  String coords;
  String token;

  Curyer.fromJson(Map<String, dynamic> json) {
    found = json['found'];
    userid = json['userid'];
    name = json['name'];
    coords = json['coords'];
    token = json['token'];
  }
}
