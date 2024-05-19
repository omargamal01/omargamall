import 'dart:io';

import 'package:airplane/core/utils/app_strings.dart';
import 'package:airplane/models/flight_model.dart';
import 'package:airplane/models/notification_model.dart';
import 'package:airplane/models/user_model.dart';
import 'package:airplane/screens/home/home_screen.dart';
import 'package:airplane/screens/notification_screen/notification_screen.dart';
import 'package:airplane/screens/settings/settings_screen.dart';
import 'package:bloc/bloc.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';

part 'main_state.dart';

class MainCubit extends Cubit<MainState> {
  MainCubit() : super(MainInitial());

  static MainCubit get(context) => BlocProvider.of(context);

  List<BottomNavigationBarItem> bottomNavBarItems = [
    const BottomNavigationBarItem(icon: Icon(Icons.home), label: "Home"),
    const BottomNavigationBarItem(
        icon: Icon(Icons.notifications), label: "Notification"),
    const BottomNavigationBarItem(
        icon: Icon(CupertinoIcons.settings), label: "Settings"),
  ];

  int currentIndex = 0;

  List<Widget> screens = [
    const HomeScreen(isAdmin: false),
    const NotificationScreen(),
    SettingsScreen(),
  ];

  void changeCurrentIndex(index) {
    currentIndex = index;
    if (index == 1) {
      getNotificationList();
    } else if (index == 2) {
      getUserInfo();
    }
    emit(ChangeCurrentIndexState());
  }

  List<FlightModel> flightList = [];

  Future<void> getAllFlights() async {
    emit(GetAllFlightsLoading());
    FirebaseFirestore.instance
        .collection(AppStrings.flights)
        .snapshots()
        .listen((event) {
      flightList.clear();
      for (var element in event.docs) {
        FlightModel flightModel = FlightModel.fromJson(element.data());
        flightList.add(flightModel);
      }
      emit(GetAllFlightsSuccess());
    });
  }

  List<NotificationModel> notificationList = [];

  void getNotificationList() async {
    emit(GetAllNotificationsLoading());
    FirebaseFirestore.instance
        .collection("notifications")
        .snapshots()
        .listen((event) {
      notificationList.clear();
      for (var element in event.docs) {
        notificationList.add(NotificationModel.fromJson(json: element.data()));
      }
      emit(GetAllNotificationsSuccess());
    });
  }

  UserModel? userModel;

  void getUserInfo() {
    emit(GetUserInfoLoading());
    FirebaseFirestore.instance
        .collection("users")
        .doc(FirebaseAuth.instance.currentUser!.uid)
        .snapshots()
        .listen((event) {
      userModel = UserModel.fromJson(event.data() ?? {});
      emit(GetUserInfoSuccess());
    });
  }

  File? userImage;
  final ImagePicker picker = ImagePicker();

  Future<void> getUserImage() async {
    final XFile? image = await picker.pickImage(source: ImageSource.gallery);
    if (image != null) {
      FirebaseStorage.instance
          .ref("users")
          .child(image.path.split('/').last)
          .putFile(File(image.path))
          .then((p0) {
        p0.ref.getDownloadURL().then((image) {
          FirebaseFirestore.instance
              .collection(AppStrings.users)
              .doc(FirebaseAuth.instance.currentUser!.uid)
              .update({"image": image});
        });
      });
    }
  }

  void updateUserInfo(
      {required String username,
      required String phone,
      required String address}) {
    FirebaseFirestore.instance
        .collection(AppStrings.users)
        .doc(FirebaseAuth.instance.currentUser!.uid)
        .update({
      "address": address,
      "phone": phone,
      "username": username,
    }).then((value) {
      emit(UpdateUserInfoSuccess());
    });
  }
}
