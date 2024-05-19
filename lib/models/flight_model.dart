import 'package:airplane/models/location_model.dart';

class FlightModel {
  String? id;
  List<dynamic> flightPath = [];
  String? flightDate;
  String? startTime;
  String? arriveTime;
  int? capacity;
  String? planeCode;


  FlightModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    flightPath = json['flightPath'];
    flightDate = json['flightDate'];
    startTime = json['startTime'];
    arriveTime = json['arriveTime'];
    capacity = json['capacity'];
    planeCode = json['planeCode'];
  }

  Map<String, dynamic> toMap() {
    return {
      "id": id,
      "flightPath": flightPath,
      "flightDate": flightDate,
      "startTime": startTime,
      "arriveTime": arriveTime,
      "capacity": capacity,
      "planeCode": planeCode,
    };
  }
}
