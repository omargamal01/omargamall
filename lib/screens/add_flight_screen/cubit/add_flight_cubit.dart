import 'package:airplane/core/utils/app_constant.dart';
import 'package:airplane/core/utils/app_strings.dart';
import 'package:airplane/models/flight_model.dart';
import 'package:airplane/models/location2_model.dart';
import 'package:airplane/models/location_model.dart';
import 'package:airplane/models/notification_model.dart';
import 'package:bloc/bloc.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:meta/meta.dart';
import 'package:geocoding/geocoding.dart' as geo;
import 'package:geolocator/geolocator.dart';

part 'add_flight_state.dart';

class AddFlightCubit extends Cubit<AddFlightState> {
  AddFlightCubit() : super(AddFlightInitial());

  static AddFlightCubit get(context) => BlocProvider.of(context);

  Future<void> setUpPermissions() async {
    emit(InitAppState());
    try {
      bool isLocationServiceEnabled =
          await Geolocator.isLocationServiceEnabled();
      LocationPermission permission = await Geolocator.checkPermission();

      if (!isLocationServiceEnabled) {
        await Geolocator.openLocationSettings();
        if (!isLocationServiceEnabled) {
          return;
        }
      }

      if (permission == LocationPermission.denied) {
        permission = await Geolocator.requestPermission();
        if (permission == LocationPermission.denied) {
          return Future.error('Location permissions are denied');
        }
      }

      emit(SetUpLocationState());
    } catch (error) {
      if (kDebugMode) {
        print(error.toString());
      }
    }
  }

  Future<String> getLocationAddress({required double lat, required double lon}) async {
    List<geo.Placemark> addressList =
        await geo.placemarkFromCoordinates(lat, lon);
    String address =
        '${addressList[0].country} - ${addressList[0].administrativeArea}}';
    return address;
  }

  List<LocationModel2> flightLocationList = [];

  void addFlightPath({required LocationModel2 locationModel}) async {
    flightLocationList.add(locationModel);
    emit(AddPathLocationToList());
  }

  Future<void> addFlightToFirestore({
    required String flightDate,
    required String startTime,
    required String arriveTime,
    required int capacity,
    required String plane,
  }) async {

    FirebaseFirestore.instance.collection(AppStrings.flights).add({
      "id": 'id',
      "flightPath": flightLocationList.map((e) => e.toMap()).toList(),
      "flightDate": flightDate,
      "startTime": startTime,
      "arriveTime": arriveTime,
      "capacity": capacity,
      "planeCode": plane,
    }).then((value) {
      FirebaseFirestore.instance
          .collection(AppStrings.flights)
          .doc(value.id)
          .update({
        "id": value.id,
      });
      _sendNotification(date: flightDate ,time: startTime);
    });
  }

  void _sendNotification({required String date, required String time}) async {
    try {
      final data = {
        "to": AppStrings.adminTopic,
        "notification": {
          "body": "new quotation is add to flight list at $date in $time",
          "title": "New Flight !! ",
          "sound": "default"
        },
        "android": {
          "priority": "HIGH",
          "notification": {
            "notification_priority": "PRIORITY_HIGH",
            "sound": "default",
            "default_sound": true,
            "default_vibrate_timings": true,
            "default_light_settings": true,
          },
        },
        "data": {
          "id": "87",
          "click_action": "FLUTTER_NOTIFICATION_CLICK",
        }
      };

      BaseOptions baseOptions = BaseOptions(
        receiveDataWhenStatusError: true,
        headers: {
          AppStrings.contentType: AppStrings.applicationJson,
          AppStrings.authorization: "key=${AppStrings.serverKey}",
        },
      );
      Dio dio = Dio(baseOptions);
      var response =
      await dio.post("https://fcm.googleapis.com/fcm/send", data: data);
      if (response.statusCode == 200) {
        NotificationModel model = NotificationModel(
            notificationId: '',
            date: AppConstant.formatDate(),
            time: AppConstant.formatTime(),
            title: "New Flight !! ",
            body: "new quotation is add to flight list at $date in $time",
            );

        var snapShot = await FirebaseFirestore.instance
            .collection(AppStrings.notification)
            .add(model.toJson());
        FirebaseFirestore.instance
            .collection(AppStrings.notification)
            .doc(snapShot.id)
            .update({"notificationId": snapShot.id});
      }
      emit(AddFlightSuccessState());
    } catch (error) {
      if (kDebugMode) {
        print(error.toString());
      }
    }
  }

}



