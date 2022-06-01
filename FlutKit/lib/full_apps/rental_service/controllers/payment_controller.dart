import 'package:flutter/material.dart';
import 'package:flutx/flutx.dart';

class PaymentController extends FxController {
  void goBack() {
    Navigator.pop(context);
  }

  @override
  String getTag() {
    return "payment_controller";
  }
}
