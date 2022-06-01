import 'package:flutter/material.dart';
import 'package:flutx/flutx.dart';

import '../models/car.dart';
import '../rental_service_cache.dart';
import '../views/single_car_screen.dart';

class CollectionController extends FxController {
  List<Car> cars = [];
  TextEditingController searchController = TextEditingController();

  @override
  void initState() {
    super.initState();
    cars = RentalServiceCache.cars;
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
    return "collection_controller";
  }
}
