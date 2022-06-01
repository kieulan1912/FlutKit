import 'dart:convert';
import 'package:flutkit/extensions/extensions.dart';
import 'package:flutter/services.dart';

class Car {
  String name, image, location, type;
  double price, power, speed, time;
  int passengers, doors;

  Car(this.name, this.image, this.location, this.type, this.price, this.power,
      this.speed, this.time, this.passengers, this.doors);

  static Future<List<Car>> getDummyList() async {
    dynamic data = json.decode(await getData());
    return getListFromJson(data);
  }

  static Future<Car> getOne() async {
    return (await getDummyList())[0];
  }

  static Future<Car> fromJson(Map<String, dynamic> jsonObject) async {
    String name = jsonObject['name'].toString();
    String image = jsonObject['image'].toString();
    String location = jsonObject['location'].toString();
    String type = jsonObject['type'].toString();
    double power = jsonObject['power'].toString().toDouble();
    double price = jsonObject['price'].toString().toDouble();
    double speed = jsonObject['speed'].toString().toDouble();
    double time = jsonObject['time'].toString().toDouble();
    int passengers = jsonObject['passengers'].toString().toInt();
    int doors = jsonObject['doors'].toString().toInt();
    return Car(name, image, location, type, price, power, speed, time,
        passengers, doors);
  }

  static Future<List<Car>> getListFromJson(List<dynamic> jsonArray) async {
    List<Car> list = [];
    for (int i = 0; i < jsonArray.length; i++) {
      list.add(await Car.fromJson(jsonArray[i]));
    }
    return list;
  }

  static Future<String> getData() async {
    return await rootBundle
        .loadString('lib/full_apps/rental_service/data/cars.json');
  }
}
