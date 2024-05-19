import 'package:flutter/material.dart';

import '../../core/utils/app_assets.dart';
import '../../core/utils/app_colors.dart';
import '../../core/utils/app_constant.dart';
import '../../core/utils/app_size.dart';
import '../../widgets/app_text.dart';
import '../../widgets/custom_button.dart';
import '../../widgets/custom_text_form_field.dart';
import '../forget_password/forget_password.dart';

class ScreenProfile extends StatelessWidget {
  const ScreenProfile({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
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
                borderRadius: BorderRadius.vertical(top: Radius.circular(30)),
                color: Colors.white),
            child: Form(
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
                        validate: (val) {
                          if (val!.length < 6 || val.isEmpty) {
                            return 'enter password';
                          }
                        }),
                    const SizedBox(
                      height: 5,
                    ),
                    InkWell(
                      onTap: () =>
                          AppConstant.navigateTo(context, ForgetScreen()),
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
                    CustomButton(text: 'Login', press: () {}),
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
                          onTap: () {},
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
                    Row(mainAxisAlignment: MainAxisAlignment.center, children: [
                      const AppText(text: 'Dont Have Account ? '),
                      InkWell(
                          onTap: () {},
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
    ));
  }
}
