import 'package:airplane/core/utils/app_assets.dart';
import 'package:airplane/core/utils/app_constant.dart';
import 'package:airplane/core/utils/app_size.dart';
import 'package:airplane/screens/forget_password/cubit/forget_cubit.dart';
import 'package:airplane/widgets/app_text.dart';
import 'package:airplane/widgets/custom_button.dart';
import 'package:airplane/widgets/custom_text_form_field.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../core/utils/app_colors.dart';

class ForgetScreen extends StatelessWidget {
  ForgetScreen({Key? key}) : super(key: key);

  var formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => ForgetCubit(),
      child: BlocConsumer<ForgetCubit, ForgetState>(
        listener: (context, state) {
          if(state is ResetPasswordError){
            AppConstant.showToast(msg: state.error,color: Colors.red);
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
                        borderRadius: BorderRadius.vertical(
                            top: Radius.circular(30)),
                        color: Colors.white),
                    child: Form(
                      key: formKey,
                      child: Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 20.0),
                        child: Column(
                          children: [
                            SizedBox(height: SizeConfig.bodyHeight * .05),
                            const AppText(
                                text: "Forget Password",
                                textSize: 35,
                                fontWeight: FontWeight.w800),
                            const SizedBox(
                              height: 40,
                            ),
                            CustomTextFormField(
                                hintText: 'Email',
                                validate: (val) {
                                  if (val!.length < 6 || val.isEmpty) {
                                    return 'please enter your email';
                                  }
                                }),
                            const SizedBox(
                              height: 80,
                            ),
                            CustomButton(text: 'Rset Password', press: () {}),
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
