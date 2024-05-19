import 'package:airplane/core/utils/app_assets.dart';
import 'package:airplane/core/utils/app_constant.dart';
import 'package:airplane/core/utils/app_size.dart';
import 'package:airplane/widgets/app_text.dart';
import 'package:airplane/widgets/custom_button.dart';
import 'package:airplane/widgets/custom_text_form_field.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

import '../../core/utils/app_colors.dart';
import '../complete_screen/complete_screen.dart';
import 'cubit/register_cubit.dart';

class RegisterScreen extends StatelessWidget {
  RegisterScreen({Key? key}) : super(key: key);

  var formKey = GlobalKey<FormState>();
  var email = TextEditingController();
  var password = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => RegisterCubit(),
      child: BlocConsumer<RegisterCubit, RegisterState>(
        listener: (context, state) {
          if (state is RegisterSuccess) {
            AppConstant.navigateToAndFinish(context, CompleteScreen());
          } else if (state is RegisterFailure) {
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
                      Image.asset(AppAssets.Register),
                      const Spacer(),
                      Image.asset(AppAssets.hello),
                      const SizedBox(
                        width: 25,
                      ),
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
                                text: "Register",
                                textSize: 48,
                                fontWeight: FontWeight.w800),
                            const SizedBox(
                              height: 20,
                            ),
                            CustomTextFormField(
                                hintText: 'Email',
                                controller: email,
                                validate: (val) {
                                  if (val!.length < 10 || val.isEmpty) {
                                    return 'email is required';
                                  }
                                }),
                            const SizedBox(
                              height: 20,
                            ),
                            CustomTextFormField(
                                hintText: 'Password',
                                controller: password,
                                isPassword: true,
                                validate: (val) {
                                  if (val!.length < 6 || val.isEmpty) {
                                    return 'password is short';
                                  }
                                }),
                            const SizedBox(
                              height: 20,
                            ),
                            CustomTextFormField(
                              hintText: 'Confirm Password',
                              isPassword: true,
                              validate: (val) {
                                if (val != password.text) {
                                  return 'Confirm Password is not equal password ';
                                }
                              },
                            ),
                            const SizedBox(
                              height: 20,
                            ),
                            state is RegisterLoading
                                ? SpinKitHourGlass(color: AppColors.primary)
                                : CustomButton(
                                    text: 'Register',
                                    press: () {
                                      if (formKey.currentState!.validate()) {

                                        RegisterCubit.get(context)
                                            .registerNewUser(
                                                email.text, password.text);
                                      }
                                    }),
                            const SizedBox(
                              height: 20,
                            ),
                            Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  const AppText(text: 'You Have Account ? '),
                                  InkWell(
                                      child: AppText(
                                          text: 'Login',
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
