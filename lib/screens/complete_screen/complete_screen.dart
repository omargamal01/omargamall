import 'package:airplane/core/utils/app_assets.dart';
import 'package:airplane/core/utils/app_constant.dart';
import 'package:airplane/core/utils/app_size.dart';
import 'package:airplane/screens/complete_screen/cubit/complete_cubit.dart';
import 'package:airplane/screens/login_screen/login_screen.dart';
import 'package:airplane/widgets/custom_button.dart';
import 'package:airplane/widgets/custom_text_form_field.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:toggle_switch/toggle_switch.dart';

import '../../core/utils/app_colors.dart';

class CompleteScreen extends StatelessWidget {
  CompleteScreen({Key? key}) : super(key: key);

  var formKey = GlobalKey<FormState>();

  var username = TextEditingController();
  var phone = TextEditingController();
  var address = TextEditingController();

  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    return BlocProvider(
      create: (context) => CompleteCubit(),
      child: BlocConsumer<CompleteCubit, CompleteState>(
        listener: (context, state) {
          if(state is UploadUserInfoData){
            AppConstant.navigateToAndFinish(context, LoginScreen());
          }
        },
        builder: (context, state) {
          CompleteCubit cubit = CompleteCubit.get(context);
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
                            SizedBox(
                              height: 100,
                              width: 100,

                              child: CircleAvatar(
                                backgroundColor: Colors.grey,
                                child: InkWell(
                                  onTap: () => cubit.changeUserImage(),
                                  child: Stack(
                                    alignment: Alignment.bottomRight,
                                    children: [
                                      cubit.userImage == null ? const Icon(
                                        Icons.person, size: 100,
                                        color: Colors.white,) : Image.file(
                                          cubit.userImage!),
                                      Container(
                                          decoration: const BoxDecoration(
                                              shape: BoxShape.circle,
                                              color: Colors.white
                                          ),
                                          child: const Icon(
                                            Icons.camera_alt_outlined,
                                            color: Colors.grey,))
                                    ],
                                  ),
                                ),
                              ),

                            ),
                            const SizedBox(
                              height: 20,
                            ),
                            CustomTextFormField(
                                controller: username,
                                suffixIcon: Icons.person,
                                hintText: 'Username',
                                validate: (val) {
                                  if (val!.isEmpty) {
                                    return "please enter your username";
                                  }
                                  return null;
                                }
                            ),
                            const SizedBox(
                              height: 20,
                            ),
                            CustomTextFormField(
                                controller: phone,
                                type: TextInputType.phone,
                                suffixIcon: Icons.call,
                                hintText: 'Phone Number',
                                validate: (val) {
                                  if ( val!.isEmpty) {
                                    return ' Phone Number is required';
                                  }
                                }

                            ),
                            const SizedBox(
                              height: 20,
                            ),
                            CustomTextFormField(
                                hintText: 'Address',
                                controller: address,
                                type: TextInputType.streetAddress,
                                validate: (val) {
                                  if (val!.isEmpty) {
                                    return 'Address is required';
                                  }
                                }
                            ),
                            const SizedBox(
                              height: 20,
                            ),
                            ToggleSwitch(
                              initialLabelIndex: cubit.genderIndex,
                              totalSwitches: cubit.gender.length,
                              labels: cubit.gender,
                              onToggle: (index) =>
                                  cubit.changeToggleGender(index: index!),
                            ),
                            const SizedBox(
                              height: 20,
                            ),
                            CustomButton(text: 'Continue', press: () {
                              if (formKey.currentState!.validate()) {
                                cubit.uploadUserData(username: username.text,
                                    phone: phone.text,
                                    address: address.text);
                              }
                            }),


                            const SizedBox(
                              height: 20,
                            ),

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
