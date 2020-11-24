class ApiConfig {
  final String BASE_URl = 'https://bees.az/api/curyer/?lang=ru&action=';

  String LOGIN(String login, String password) =>
      '${BASE_URl}login&login=${login}&pass=${password}';

  String FETCH_ORDER_STATUS(String token) => '${BASE_URl}status&token=${token}';

  String ASSIGN_ORDER(String orderId, String token) =>
      '${BASE_URl}assign&order=${orderId}&token=${token}';

  String TAKE_ORDER(String orderId, String token) =>
      '${BASE_URl}take&order=${orderId}&token=${token}';

  String GIVE_ORDER(String orderId, String token) =>
      '${BASE_URl}give&order=${orderId}&token=${token}';
}
