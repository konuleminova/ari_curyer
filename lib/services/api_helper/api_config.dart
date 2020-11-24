class ApiConfig {
  final String BASE_URl = 'http://bees.az/api/pad/?lang=ru&action=';

  String LOGIN(String login, String password) =>
      '${BASE_URl}+login&login=${login}&pass=${password}';

  String ORDER_LIST(String token) => '${BASE_URl}orderlist&token=${token}';

  String CHANGE_STATUS(String token, String id) =>
      '${BASE_URl}orderlist&token=${token}&change=${id}';
}
