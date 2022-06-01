import 'package:flutter/material.dart';
import 'package:flutx/flutx.dart';

import '../models/car.dart';
import '../rental_service_cache.dart';
import '../views/single_car_screen.dart';

class SavedController extends FxController {
  List<Car> cars = [];

  @override
  void initState() {
    super.initState();
    cars = RentalServiceCache.cars;
  }

  double findAspectRatio() {
    double width = MediaQuery.of(context).size.width;
    return ((width - 60) / 2) / (90*2);
  }

  void goToSingleCarScreen(Car car) {
    Navigator.of(context, rootNavigator: true).push(
      MaterialPageRoute(
        builder: (context) => SingleCarScreen(
          car: car,
        ),
      ),
    );
  }

  @override
  String getTag() {
    return "saved_controller";
  }
}
