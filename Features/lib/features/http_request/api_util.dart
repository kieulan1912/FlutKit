/*
 * For Flutter
 * - Add dependencies to pubspec.yaml for http
 * - run command "flutter pub get"
 * make sure after run this command you need to re run application.
 * don't use hot reload whenever you adding some dependency.
*/

/* For Android & iOS
 * There is no configurations but see once a reference.
 * Reference : https://pub.dev/packages/http
*/

/*
* Make sure all steps you follow as references
* */

import 'dart:convert';

import 'package:http/http.dart' as http;

enum RequestType { Post, Get, PostWithAuth, GetWithAuth }

class ApiUtil {
  static String getUrl =
      'https://api.openweathermap.org/data/2.5/weather?q=surat&appid={API_KEY}';
  static String postUrl =
      'https://api.openweathermap.org/data/2.5/weather?q=surat&appid={API_KEY}';

  //------------------ Header ------------------------------//

  static Map<String, String> getHeader(
      {RequestType requestType = RequestType.Get, String token = ""}) {
    switch (requestType) {
      case RequestType.Post:
        return {
          "Accept": "application/json",
          "Content-type": "application/json"
        };
      case RequestType.Get:
        return {
          "Accept": "application/json",
        };
      case RequestType.PostWithAuth:
        return {
          "Accept": "application/json",
          "Content-type": "application/json",
          "Authorization": "Bearer " + token
        };
      case RequestType.GetWithAuth:
        return {
          "Accept": "application/json",
          "Authorization": "Bearer " + token
        };
    }
    //Not reachable
    return {"Accept": "application/json"};
  }

  // ----------------------  Body --------------------------//
  static Map<String, String> getPatchRequestBody() {
    return {'_method': 'PATCH'};
  }

  //-------------------------------Methods-----------//

  static Future<http.Response> makeGetRequest() async {
    http.Response response = await http.get(Uri.parse(getUrl),
        headers: getHeader(requestType: RequestType.Get));
    return response;
  }

  static Future<http.Response> makePostRequest(Map<String, String> data) async {
    String body = json.encode(data);
    http.Response response = await http.post(Uri.parse(postUrl),
        headers: getHeader(requestType: RequestType.Get), body: body);
    return response;
  }
}
