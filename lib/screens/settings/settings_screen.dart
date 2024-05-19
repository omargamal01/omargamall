import 'package:airplane/core/utils/app_assets.dart';
import 'package:airplane/core/utils/app_colors.dart';
import 'package:airplane/core/utils/app_constant.dart';
import 'package:airplane/core/utils/app_size.dart';
import 'package:airplane/core/utils/app_strings.dart';
import 'package:airplane/main_layout/cubit/main_cubit.dart';
import 'package:airplane/screens/login_screen/login_screen.dart';
import 'package:airplane/widgets/app_text.dart';
import 'package:airplane/widgets/custom_button.dart';
import 'package:airplane/widgets/custom_text_form_field.dart';
import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

import 'custom_profile_user_item.dart';

class SettingsScreen extends StatelessWidget {
  final formKey = GlobalKey<FormState>();
  var username = TextEditingController();
  var phone = TextEditingController();
  var address = TextEditingController();

  SettingsScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<MainCubit, MainState>(
      listener: (context, state) {
        if (state is UpdateUserInfoSuccess) {
          AppConstant.showToast(
              msg: "Your info Updated Successfully", color: Colors.green);
        }
      },
      builder: (context, state) {
        MainCubit cubit = MainCubit.get(context);
        return cubit.userModel == null
            ? SpinKitHourGlass(color: AppColors.primary)
            : Center(
                child: SingleChildScrollView(
                  child: Column(
                    children: [
                      SizedBox(height: SizeConfig.bodyHeight * .04),
                      const AppText(text: "Personal Profile", textSize: 22),
                      SizedBox(height: SizeConfig.bodyHeight * .02),
                      Container(
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          border: Border.all(
                              color: Colors.black.withOpacity(0.7), width: 3),
                        ),
                        child: CircleAvatar(
                            radius: SizeConfig.bodyHeight * .09,
                            backgroundImage: cubit.userModel!.image ==
                                    AppStrings.defaultValue
                                ? const AssetImage("assets/user.png")
                                : NetworkImage("${cubit.userModel!.image}")
                                    as ImageProvider),
                      ),
                      TextButton(
                          onPressed: () async {
                            cubit.getUserImage();
                          },
                          child: AppText(
                            text: "Change Profile Picture",
                            color: AppColors.primary,
                            textDecoration: TextDecoration.underline,
                            textSize: 18,
                          )),
                      SizedBox(height: SizeConfig.bodyHeight * .02),
                      AppText(
                          text: cubit.userModel!.username.toString(),
                          textSize: 26,
                          fontWeight: FontWeight.bold,
                          color: AppColors.primary),
                      SizedBox(height: SizeConfig.bodyHeight * .02),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 15),
                        child: Column(
                          children: [
                            CustomTextFormField(
                              controller: username
                                ..text = cubit.userModel!.username.toString(),
                              labelText: "Username",
                              validate: (String? value) {
                                if (value!.isEmpty) {
                                  return "Username is required";
                                }
                              },
                            ),
                            const SizedBox(height: 15),
                            CustomTextFormField(
                              controller: phone
                                ..text = cubit.userModel!.phone.toString(),
                              labelText: "Phone",
                              type: TextInputType.phone,
                              validate: (String? value) {
                                if (value!.isEmpty) {
                                  return "phone is required";
                                }
                              },
                            ),
                            const SizedBox(height: 15),
                            CustomTextFormField(
                              controller: address
                                ..text = cubit.userModel!.address.toString(),
                              labelText: "Address",
                              type: TextInputType.streetAddress,
                              validate: (String? value) {
                                if (value!.isEmpty) {
                                  return "address is required";
                                }
                              },
                            ),
                            const SizedBox(height: 30),
                            CustomButton(
                              text: "Save Changes",
                              press: () {
                                cubit.updateUserInfo(
                                    phone: phone.text,
                                    address: address.text,
                                    username: username.text);
                              },
                              backgroundColor: Colors.transparent,
                              textColor: AppColors.primary,
                            ),
                            const SizedBox(height: 15),
                            CustomButton(
                                text: "Logout",
                                press: () async {
                                  showCustomDialog(context);
                                }),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              );
      },
    );
  }

  void showCustomDialog(context) {
    AwesomeDialog(
            context: context,
            animType: AnimType.scale,
            dialogType: DialogType.warning,
            body: Column(
              children: const [
                AppText(
                    text: "Logout Confirmation",
                    fontWeight: FontWeight.bold,
                    textSize: 35),
                SizedBox(height: 40),
                AppText(text: "Are you sure you want to logout ? ", maxLines: 3)
              ],
            ),
            title: 'This is Ignored',
            desc: 'This is also Ignored',
            btnOkOnPress: () {
              FirebaseAuth.instance.signOut().then((value) {
                AppConstant.navigateToAndFinish(context, LoginScreen());
              });
            },
            btnCancelOnPress: () {})
        .show();
  }
}
