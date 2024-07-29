import 'dart:convert';
import 'dart:developer';
import 'package:http/http.dart' as http;

class ApiClient {
  // TODO: POST REQUEST

  static Future<dynamic> postRequest({
    required String endpoint,
   var body = const {},
  }) async {
    try {
      var response = await http.post(Uri.parse(endpoint), body: jsonEncode(body), );
      if (response.statusCode == 200) {
        return jsonDecode(response.body);
      } else {
        log('the something went wrong');
      }
    } catch (e) {
      return Future.error(e.toString());
    }
  }
}
