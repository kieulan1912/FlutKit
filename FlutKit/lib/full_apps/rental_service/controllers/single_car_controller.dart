import 'package:flutter/material.dart';
import 'package:flutx/flutx.dart';

import '../models/car.dart';
import '../views/payment_screen.dart';

class SingleCarController extends FxController {
  Car car;

  SingleCarController(this.car);

  bool fav = false;

  @override
  void initState() {
    super.initState();
    save = false;
  }

  void toggleFav() {
    fav = !fav;
    update();
  }

  void goToPaymentScreen() {
    Navigator.of(context, rootNavigator: true).pushReplacement(
      MaterialPageRoute(
        builder: (context) => PaymentScreen(),
      ),
    );
  }

  void goBack() {
    Navigator.pop(context);
  }

  @override
  String getTag() {
    return "single_car_controller";
  }
}
