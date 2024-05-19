import 'dart:io';
import 'dart:math';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:airplane/core/utils/app_strings.dart';
import 'package:airplane/models/user_model.dart';
import 'package:bloc/bloc.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';
import 'package:meta/meta.dart';

part 'complete_state.dart';

class CompleteCubit extends Cubit<CompleteState> {
  CompleteCubit() : super(CompleteInitial());

  static CompleteCubit get(context) => BlocProvider.of(context);

  List<String> gender = ["Male", "Female"];

  int genderIndex = 0;

  void changeToggleGender({required int index}) {
    genderIndex = index;
    emit(ChangeGenderIndexState());
  }

  final ImagePicker picker = ImagePicker();
  File? userImage;
  String userImageLink = AppStrings.defaultValue;

  Future<void> changeUserImage() async {
    final XFile? image = await picker.pickImage(source: ImageSource.gallery);

    if (image != null) {
      userImage = File(image.path);

      FirebaseStorage.instance
          .ref(AppStrings.users)
          .child(Random().nextInt(50000).toString())
          .putFile(userImage!)
          .then((p0) async {
        userImageLink = await p0.ref.getDownloadURL();
      });
    }
    emit(ChangeUserImageSuccess());
  }

  Future<void> uploadUserData(
      {required String username,
      required String phone,
      required String address}) async {
    UserModel userModel = UserModel(
        uid: FirebaseAuth.instance.currentUser!.uid,
        username: username,
        phone: phone,
        address: address,
        token: await FirebaseMessaging.instance.getToken(),
        image: userImageLink,
        isAdmin: false,
        isMale: genderIndex == 0 ? true : false);

    FirebaseFirestore.instance
        .collection(AppStrings.users)
        .doc(FirebaseAuth.instance.currentUser!.uid)
        .set(userModel.toMap())
        .then((value) {
          emit(UploadUserInfoData());
    });
  }
}
