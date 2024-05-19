import 'package:airplane/core/utils/app_assets.dart';
import 'package:airplane/core/utils/app_constant.dart';
import 'package:airplane/core/utils/app_size.dart';
import 'package:airplane/main_layout/main_layout.dart';
import 'package:airplane/screens/complete_screen/complete_screen.dart';
import 'package:airplane/screens/forget_password/forget_password.dart';
import 'package:airplane/screens/home/home_screen.dart';
import 'package:airplane/screens/login_screen/cubt/login_cubit.dart';
import 'package:airplane/screens/register_screen/register_screen.dart';
import 'package:airplane/widgets/app_text.dart';
import 'package:airplane/widgets/custom_button.dart';
import 'package:airplane/widgets/custom_text_form_field.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

import '../../core/utils/app_colors.dart';
import '../../core/utils/app_strings.dart';

class LoginScreen extends StatelessWidget {
  LoginScreen({Key? key}) : super(key: key);

  var formKey = GlobalKey<FormState>();
  var email = TextEditingController();
  var password = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => LoginCubit(),
      child: BlocConsumer<LoginCubit, LoginState>(
        listener: (context, state) {
          if (state is LoginSuccessState) {
            if (state.isDataExists) {
              if(state.isAdmin){
                AppConstant.navigateToAndFinish(context, const HomeScreen(isAdmin: true));

              }else{
                AppConstant.navigateToAndFinish(context, const MainLayout());

              }
            } else {
              AppConstant.navigateToAndFinish(context, CompleteScreen());
            }

            FirebaseMessaging.instance.subscribeToTopic(AppStrings.adminTopicName);
          } else if (state is LoginFailureState) {
            AppConstant.showToast(msg: state.error, color: Colors.red);
          }
        },
        builder: (context, state) {
          return Scaffold(
            body: SafeArea(
              child: Stack(children: [
                Container(
                  height: SizeConfig.bodyHeight * .4,
                  width: double.infinity,
                  padding: EdgeInsets.only(bottom: SizeConfig.bodyHeight * .15),
                  decoration: BoxDecoration(
                    color: AppColors.primary,
                  ),
                  child: Row(
                    children: [
                      const SizedBox(
                        width: 25,
                      ),
                      Image.asset(AppAssets.hi),
                      const Spacer(),
                      Image.asset(AppAssets.login),
                    ],
                  ),
                ),
                SingleChildScrollView(
                  child: Container(
                    width: double.infinity,
                    margin: EdgeInsets.only(top: SizeConfig.bodyHeight * .3),
                    decoration: const BoxDecoration(
                        borderRadius:
                            BorderRadius.vertical(top: Radius.circular(30)),
                        color: Colors.white),
                    child: Form(
                      key: formKey,
                      child: Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 20.0),
                        child: Column(
                          children: [
                            SizedBox(height: SizeConfig.bodyHeight * .05),
                            const AppText(
                                text: "Login",
                                textSize: 48,
                                fontWeight: FontWeight.w800),
                            const SizedBox(
                              height: 20,
                            ),
                            CustomTextFormField(
                                hintText: 'Email',
                                controller: email,
                                suffixIcon: Icons.email,
                                validate: (val) {
                                  if (val!.length < 6 || val.isEmpty) {
                                    return 'please enter your email';
                                  }
                                }),
                            const SizedBox(
                              height: 20,
                            ),
                            CustomTextFormField(
                                hintText: 'Password',
                                suffixIcon: Icons.lock,
                                isPassword: true,
                                controller: password,
                                validate: (val) {
                                  if (val!.length < 6 || val.isEmpty) {
                                    return 'enter password';
                                  }
                                }),
                            const SizedBox(
                              height: 5,
                            ),
                            InkWell(
                              onTap: () => AppConstant.navigateTo(
                                  context, ForgetScreen()),
                              child: Align(
                                  alignment: Alignment.topRight,
                                  child: AppText(
                                      text: 'Forget Password ?',
                                      fontWeight: FontWeight.bold,
                                      color: AppColors.primary)),
                            ),
                            const SizedBox(
                              height: 20,
                            ),
                            state is LoginLoadingState
                                ? SpinKitHourGlass(color: AppColors.primary)
                                : CustomButton(
                                    text: 'Login',
                                    press: () {
                                      if (formKey.currentState!.validate()) {
                                        LoginCubit.get(context)
                                            .loginWithEmailAddPassword(
                                                email.text, password.text);
                                      }
                                    }),
                            const SizedBox(
                              height: 20,
                            ),
                            AppText(
                                text: 'Or Log In With ',
                                color: AppColors.primary,
                                fontWeight: FontWeight.w500),
                            const SizedBox(
                              height: 20,
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                InkWell(
                                  onTap: () {
                                    LoginCubit.get(context).signInWithGoogle();
                                  },
                                  child: Container(
                                      decoration: BoxDecoration(
                                        shape: BoxShape.circle,
                                        border: Border.all(color: Colors.grey),
                                      ),
                                      child: Padding(
                                        padding: const EdgeInsets.all(20.0),
                                        child: Image.asset(AppAssets.google),
                                      )),
                                ),
                                const SizedBox(
                                  width: 30,
                                ),
                                Container(
                                    decoration: BoxDecoration(
                                      shape: BoxShape.circle,
                                      border: Border.all(color: Colors.grey),
                                    ),
                                    child: Padding(
                                      padding: const EdgeInsets.all(20.0),
                                      child: Image.asset(AppAssets.facbook),
                                    )),
                              ],
                            ),
                            const SizedBox(
                              height: 20,
                            ),
                            Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  const AppText(text: 'Dont Have Account ? '),
                                  InkWell(
                                      onTap: () => AppConstant.navigateTo(
                                          context, RegisterScreen()),
                                      child: AppText(
                                          text: 'Register',
                                          color: AppColors.primary,
                                          fontWeight: FontWeight.bold)),
                                ]),
                          ],
                        ),
                      ),
                    ),
                  ),
                )
              ]),
            ),
          );
        },
      ),
    );
  }
}
