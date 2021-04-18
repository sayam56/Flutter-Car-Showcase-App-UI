import 'package:flutter/material.dart';

double iconSize = 30;

//an object of the carlist class
CarList carList = CarList(cars: [
  Car(companyName: "Chevrolet", carName: "Corvette", price: 2100, imgList: [
    "corvette_front.png",
    "corvette_back.png",
    "interior1.png",
    "interior2.png",
    "corvette_front2.png",
  ], offerDetails: [
    {Icon(Icons.bluetooth, size: iconSize): "Automatic"},
    {Icon(Icons.airline_seat_individual_suite, size: iconSize): "4 seats"},
    {Icon(Icons.pin_drop, size: iconSize): "6.4L"},
    {Icon(Icons.shutter_speed, size: iconSize): "5HP"},
    {Icon(Icons.invert_colors, size: iconSize): "Variant Colours"},
  ], specs: [
    {
      Icon(Icons.av_timer, size: iconSize): {"Milegp(upto)": "14.2 kmpl"}
    },
    {
      Icon(Icons.power, size: iconSize): {"Engine(upto)": "3996 cc"}
    },
    {
      Icon(Icons.assignment_late, size: iconSize): {"BHP": "700"}
    },
    {
      Icon(Icons.account_balance_wallet, size: iconSize): {
        "More Specs": "14.2 kmpl"
      }
    },
    {
      Icon(Icons.cached, size: iconSize): {"More Specs": "14.2 kmpl"}
    },
  ], features: [
    {Icon(Icons.bluetooth, size: iconSize): "Bluetooth"},
    {Icon(Icons.usb, size: iconSize): "USB Port"},
    {Icon(Icons.power_settings_new, size: iconSize): "Keyless"},
    {Icon(Icons.android, size: iconSize): "Android Auto"},
    {Icon(Icons.ac_unit, size: iconSize): "AC"},
  ]),
  Car(companyName: "Lamborghini", carName: "Aventador", price: 3000, imgList: [
    "lambo_front.png",
    "interior_lambo.png",
    "lambo_back.png",
  ], offerDetails: [
    {Icon(Icons.bluetooth, size: iconSize): "Automatic"},
    {Icon(Icons.airline_seat_individual_suite, size: iconSize): "4 seats"},
    {Icon(Icons.pin_drop, size: iconSize): "6.4L"},
    {Icon(Icons.shutter_speed, size: iconSize): "5HP"},
    {Icon(Icons.invert_colors, size: iconSize): "Variant Colours"},
  ], specs: [
    {
      Icon(Icons.av_timer, size: iconSize): {"Milegp(upto)": "14.2 kmpl"}
    },
    {
      Icon(Icons.power, size: iconSize): {"Engine(upto)": "3996 cc"}
    },
    {
      Icon(Icons.assignment_late, size: iconSize): {"BHP": "700"}
    },
    {
      Icon(Icons.account_balance_wallet, size: iconSize): {
        "Milegp(upto)": "14.2 kmpl"
      }
    },
  ], features: [
    {Icon(Icons.bluetooth, size: iconSize): "Bluetooth"},
    {Icon(Icons.usb, size: iconSize): "USB Port"},
    {Icon(Icons.power_settings_new, size: iconSize): "Keyless"},
    {Icon(Icons.android, size: iconSize): "Android Auto"},
    {Icon(Icons.ac_unit, size: iconSize): "AC"},
  ])
]);

class CarList {
  //this class takes the cars and make a list out of them
  List<Car> cars;

  CarList({@required this.cars});
}

class Car {
  //this class creates the car, as in all the things that make the signature of a car in the app
  String companyName;
  String carName;
  int price;
  List<String> imgList;
  List<Map<Icon, String>> offerDetails;
  List<Map<Icon, String>> features;
  List<Map<Icon, Map<String, String>>> specs;

  Car(
      {@required this.companyName,
      @required this.carName,
      @required this.price,
      @required this.imgList,
      @required this.offerDetails,
      @required this.features,
      @required this.specs});
}
