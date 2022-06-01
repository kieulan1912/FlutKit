import 'dart:developer';

import 'package:admob_flutter/admob_flutter.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutkit_feature/features/firebase/views/login_screen.dart';
import 'package:flutkit_feature/features/firebase/views/register_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutx/flutx.dart';
import 'package:http/http.dart';

import 'api_util.dart';

class GetRequestController extends FxController {
  bool loading = false;
  Response? response;

  GetRequestController() {
    save = false;
  }

  getRequest() async {
    loading = true;
    update();

    response = await ApiUtil.makeGetRequest();

    loading = false;
    update();
  }

  @override
  String getTag() {
    return "get_request_controller";
  }
}
