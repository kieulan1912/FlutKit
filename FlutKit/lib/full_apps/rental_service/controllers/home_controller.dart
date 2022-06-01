import 'package:flutter/material.dart';
import 'package:flutx/flutx.dart';

import '../models/car.dart';
import '../rental_service_cache.dart';
import '../views/single_car_screen.dart';

class Category {
  String name, image;

  Category(this.name, this.image);
}

class HomeController extends FxController {
  TextEditingController searchController = TextEditingController();
  List<Category> categories = [];
  List<Car> cars = [];

  @override
  void initState() {
    super.initState();
    categories = [
      Category("BMW", "assets/images/full_apps/rental_service/icons/logo1.png"),
      Category("Kia", "assets/images/full_apps/rental_service/icons/logo7.png"),
      Category(
          "Ferrari", "assets/images/full_apps/rental_service/icons/logo3.png"),
      Category(
          "Ford", "assets/images/full_apps/rental_service/icons/logo6.png"),
      Category(
          "Opel", "assets/images/full_apps/rental_service/icons/logo2.png"),
      Category(
          "Porsche", "assets/images/full_apps/rental_service/icons/logo5.png"),
    ];
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
    return "home_controller";
  }
}
