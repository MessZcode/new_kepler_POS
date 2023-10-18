import 'package:http/http.dart' as http;
class ApiManagerString {
  static const String baseApiString = "https://650290b9a0f2c1f3faea9330.mockapi.io/Kepler_pos/orders";
  static const String apiProduct = "$baseApiString/product";
  static const String apiUsers = "$baseApiString/users";

  static const String get = "GET";
  static const String post = "POST";
  static const String delete = "DELETE";
}
class ApiServices {

  Future<bool> getApi() async {
    var request = http.Request(ApiManagerString.get, Uri.parse(ApiManagerString.apiProduct));
    http.StreamedResponse response = await request.send();
    if (response.statusCode == 200) {
      print(await response.stream.bytesToString());
      return true;
    }
    else {
      print(response.reasonPhrase);
      return false;
    }
  }
}