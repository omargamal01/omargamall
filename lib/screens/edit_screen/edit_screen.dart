import 'package:airplane/core/utils/app_colors.dart';
import 'package:airplane/core/utils/app_constant.dart';
import 'package:airplane/models/flight_model.dart';
import 'package:airplane/screens/edit_screen/cubit/edit_cubit.dart';
import 'package:airplane/widgets/app_text.dart';
import 'package:airplane/widgets/custom_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';

import '../../widgets/custom_text_form_field.dart';

class EditFlightScreen extends StatelessWidget {
  EditFlightScreen({Key? key, required this.flightModel}) : super(key: key);
  final FlightModel flightModel;
  var startPoint = TextEditingController();
  var endPoint = TextEditingController();
  var flightDate = TextEditingController();
  var startTime = TextEditingController();
  var arriveTime = TextEditingController();
  var capacity = TextEditingController();
  var planeCode = TextEditingController();
  var formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => EditCubit(),
      child: BlocConsumer<EditCubit, EditState>(
        listener: (context, state) {
          if(state is UpdateSuccess){
            AppConstant.showCustomSnakeBar(context, "Updated Successfully", true);
            Future.delayed(const Duration(seconds: 3),() {
              Navigator.pop(context);
            },);
          }
        },
        builder: (context, state) {
          EditCubit cubit = EditCubit.get(context);
          return Scaffold(
            appBar: AppBar(
              backgroundColor: Colors.white,
              centerTitle: true,
              title: AppText(
                  text: 'Edit Flight', color: AppColors.primary, textSize: 25),
            ),
            body: SingleChildScrollView(
              child: Padding(
                padding:
                    const EdgeInsets.symmetric(vertical: 20, horizontal: 20),
                child: Form(
                  key: formKey,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      CustomTextFormField(
                        hintText: 'Flight Date',
                        controller: flightDate
                          ..text = flightModel.flightDate.toString(),
                        maxLines: 1,
                        onTap: () {
                          showDatePicker(
                                  context: context,
                                  builder: (context, child) => Theme(
                                      data: Theme.of(context).copyWith(
                                        colorScheme: ColorScheme.light(
                                          primary: AppColors.primary,
                                          onPrimary: Colors.white,
                                          onSurface: AppColors
                                              .primaryLight, // body text color
                                        ),
                                      ),
                                      child: child!),
                                  initialDate: DateTime.now(),
                                  firstDate: DateTime.now(),
                                  lastDate: DateTime(2024, 1, 1))
                              .then((value) {
                            flightDate.text = DateFormat.yMd().format(value!);
                          });
                        },
                        validate: (val) {
                          if (val!.isEmpty) {
                            return 'Please Enter Flight Data ';
                          }
                        },
                      ),
                      const SizedBox(
                        height: 15,
                      ),
                      CustomTextFormField(
                          hintText: 'Start Time',
                          controller: startTime
                            ..text = flightModel.startTime.toString(),
                          onTap: () {
                            showTimePicker(
                                    context: context,
                                    initialTime: TimeOfDay.now())
                                .then((value) {
                              DateTime dateTime = DateTime(
                                  2023, 12, 12, value!.hour, value.minute);
                              startTime.text =
                                  DateFormat.Hms().format(dateTime);
                            });
                          },
                          validate: (val) {
                            if (val!.isEmpty) {
                              return 'Please choose Start Time ';
                            }
                          }),
                      const SizedBox(
                        height: 15,
                      ),
                      CustomTextFormField(
                          hintText: 'Arrive Time',
                          controller: arriveTime
                            ..text = flightModel.arriveTime.toString(),
                          onTap: () {
                            showTimePicker(
                                    context: context,
                                    initialTime: TimeOfDay.now())
                                .then((value) {
                              DateTime dateTime = DateTime(
                                  2023, 12, 12, value!.hour, value.minute);

                              arriveTime.text =
                                  DateFormat.Hms().format(dateTime);
                            });
                          },
                          validate: (val) {
                            if (val!.isEmpty) {
                              return 'Please choose Arrive Time ';
                            }
                          }),
                      const SizedBox(
                        height: 15,
                      ),
                      CustomTextFormField(
                          hintText: 'Capacity',
                          controller: capacity
                            ..text = flightModel.capacity.toString(),
                          validate: (val) {
                            if (val!.isEmpty) {
                              return 'Please choose Plane Capacity ';
                            }
                            return null;
                          }),
                      const SizedBox(
                        height: 15,
                      ),
                      CustomTextFormField(
                          hintText: 'Plane Code',
                          controller: planeCode
                            ..text = flightModel.planeCode.toString(),
                          validate: (val) {
                            if (val!.isEmpty) {
                              return 'Please choose Plane Code ';
                            }
                            return null;
                          }),
                      const SizedBox(
                        height: 15,
                      ),
                      CustomButton(
                          text: 'Update Flight',
                          press: () {
                            if (formKey.currentState!.validate()) {
                              EditCubit.get(context).updateFlightToFirestore(
                                  flightDate: flightDate.text,
                                  startTime: startTime.text,
                                  arriveTime: arriveTime.text,
                                  capacity: int.parse(capacity.text),
                                  plane: planeCode.text,
                                  id: flightModel.id.toString());
                            }
                          }),
                    ],
                  ),
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
