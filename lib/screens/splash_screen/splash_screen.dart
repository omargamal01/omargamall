import 'package:airplane/core/utils/app_colors.dart';
import 'package:airplane/core/utils/app_constant.dart';
import 'package:airplane/core/utils/app_size.dart';
import 'package:airplane/core/utils/app_strings.dart';
import 'package:airplane/main_layout/main_layout.dart';
import 'package:airplane/models/user_model.dart';
import 'package:airplane/screens/home/home_screen.dart';
import 'package:airplane/screens/login_screen/login_screen.dart';
import 'package:airplane/widgets/app_text.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import '../../core/utils/app_assets.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    initUser();
    super.initState();
  }

  void initUser() async {
    Future.delayed(
      const Duration(seconds: 2),
      () {
        FirebaseAuth.instance.authStateChanges().listen((event) {
          if (event == null) {
            if(mounted){
              AppConstant.navigateToAndFinish(context, LoginScreen());
            }
          }
          else {
            FirebaseFirestore.instance
                .collection(AppStrings.users)
                .doc(event.uid)
                .get()
                .then((val) {
                  UserModel userModel = UserModel.fromJson(val.data()!);
                  if(userModel.isAdmin == true){
                    if(mounted){
                      AppConstant.navigateToAndFinish(context, const HomeScreen(isAdmin: true));
                    }
                  }else{
                    if(mounted){
                      FirebaseMessaging.instance.subscribeToTopic(AppStrings.adminTopicName);
                      AppConstant.navigateToAndFinish(context, const MainLayout());
                    }
                  }
            });
          }
        });
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    return Scaffold(
      backgroundColor: AppColors.primary,
      body: Center(
        child: Column(
          children: [
            const Spacer(),
            Container(
                height: 300,
                decoration: const BoxDecoration(
                  color: Colors.white,
                  shape: BoxShape.circle,
                ),
                child: Lottie.asset(AppAssets.logoPlane)),
            const Spacer(),
            const AppText(
              text: 'Welcome',
              textSize: 30,
              fontWeight: FontWeight.bold,
              color: Colors.white,
            ),
            const SizedBox(
              height: 20,
            ),
          ],
        ),
      ),
    );
  }
}
