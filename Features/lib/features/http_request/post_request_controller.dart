import 'package:flutx/flutx.dart';
import 'package:http/http.dart';

import 'api_util.dart';

class PostRequestController extends FxController {
  bool loading = false;
  Response? response;

  PostRequestController() {
    save = false;
  }

  postRequest() async {
    loading = true;
    update();

    Map<String, String> data = {'key': 'value', 'key2': 'value2'};
    response = await ApiUtil.makePostRequest(data);

    loading = false;
    update();
  }

  @override
  String getTag() {
    return "post_request_controller";
  }
}
