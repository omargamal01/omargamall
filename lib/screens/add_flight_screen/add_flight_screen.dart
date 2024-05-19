import 'package:airplane/core/utils/app_colors.dart';
import 'package:airplane/core/utils/app_constant.dart';
import 'package:airplane/core/utils/app_size.dart';
import 'package:airplane/screens/add_flight_screen/cubit/add_flight_cubit.dart';
import 'package:airplane/screens/pick_location_screen/pick_location_screen.dart';
import 'package:airplane/widgets/app_text.dart';
import 'package:airplane/widgets/custom_button.dart';
import 'package:airplane/widgets/custom_text_form_field.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';

class AddFlightScreen extends StatelessWidget {
  AddFlightScreen({Key? key}) : super(key: key);

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
    SizeConfig().init(context);
    return BlocConsumer<AddFlightCubit, AddFlightState>(
      listener: (context, state) {
        if(state is AddFlightSuccessState){
          AppConstant.showCustomSnakeBar(context, "Flight Added Successfully", true);
        }
      },
      builder: (context, state) {
        AddFlightCubit cubit = AddFlightCubit.get(context);
        return Scaffold(
          appBar: AppBar(
            backgroundColor: Colors.white,
            centerTitle: true,
            title: AppText(
                text: 'Add Flight', color: AppColors.primary, textSize: 25),
          ),
          body: SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 20),
              child: Form(
                key: formKey,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const SizedBox(
                      height: 10,
                    ),
/*                    Row(
                      children: [
                        InkWell(
                            onTap: () {
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) =>
                                        const PickLocationsScreen(
                                            isStart: true),
                                  )).then((value) {
                                if (value.isStart) {
                                  AddFlightCubit.get(context)
                                      .setUpStartPoint(value);
                                }
                              });
                            },
                            child: const Icon(Icons.add_location_alt,
                                color: Colors.grey)),
                        const SizedBox(
                          width: 10,
                        ),
                        Expanded(
                          child: CustomTextFormField(
                            isEnable: false,
                            hintText: 'Start Point',
                            controller:
                                setUpController(isStart: true, cubit: cubit),
                            validate: (val) {
                              if (val!.isEmpty) {
                                return 'please choose start point ';
                              }
                            },
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(
                      height: 15,
                    ),
                    Row(
                      children: [
                        InkWell(
                            onTap: () {
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) =>
                                        const PickLocationsScreen(
                                            isStart: false),
                                  )).then((value) {
                                if (!value.isStart) {
                                  AddFlightCubit.get(context)
                                      .setUpEndPoint(value);
                                }
                              });
                            },
                            child: const Icon(Icons.add_location_alt,
                                color: Colors.grey)),
                        const SizedBox(
                          width: 10,
                        ),
                        Expanded(
                          child: CustomTextFormField(
                              isEnable: false,
                              hintText: 'End Point',
                              controller:
                                  setUpController(isStart: false, cubit: cubit),
                              validate: (val) {
                                if (val!.isEmpty) {
                                  return 'please choose end point ';
                                }
                              }),
                        ),
                      ],
                    ),*/
                    InkWell(
                      onTap: () {
                        AppConstant.navigateTo(context, const PickLocationsScreen());
                      },
                      child: Container(
                        padding: const EdgeInsets.symmetric(vertical: 15),
                        decoration: BoxDecoration(
                          border: Border.all(color: AppColors.primary),
                          borderRadius: BorderRadius.circular(10)
                        ),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: const [
                             Icon(Icons.add_location_alt, color: Colors.grey),
                             SizedBox(
                              width: 10,
                            ),
                             AppText(text: "Choose Flight path"),
                          ],
                        ),
                      ),
                    ),
                    const SizedBox(
                      height: 15,
                    ),
                    CustomTextFormField(
                      hintText: 'Flight Date',
                      controller: flightDate,
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
                        controller: startTime,
                        onTap: () {
                          showTimePicker(
                              context: context, initialTime: TimeOfDay.now()).then((value) {
                            DateTime dateTime  = DateTime(2023,12,12,value!.hour,value.minute);
                            startTime.text = DateFormat.Hms().format(dateTime);

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
                        controller: arriveTime,
                        onTap: (){
                          showTimePicker(
                              context: context, initialTime: TimeOfDay.now()).then((value) {
                            DateTime dateTime  = DateTime(2023,12,12,value!.hour,value.minute);

                            arriveTime.text = DateFormat.Hms().format(dateTime);
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
                        controller: capacity,
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
                        controller: planeCode,
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
                        text: 'Add Flight',
                        press: () {
                          if (formKey.currentState!.validate()) {
                            if(cubit.flightLocationList.isNotEmpty ){
                              AddFlightCubit.get(context).addFlightToFirestore(
                                  flightDate: flightDate.text,
                                  startTime: startTime.text,
                                  arriveTime: arriveTime.text,
                                  capacity: int.parse(capacity.text),
                                  plane: planeCode.text);
                            }else if(cubit.flightLocationList.length ==1){
                              AppConstant.showToast(msg: "Flight should have at least 2 location" ,color: Colors.red);
                            }
                            else{
                              AppConstant.showToast(msg: "Flight should have at least 2 location" ,color: Colors.red);
                            }
                          }
                        }),
                  ],
                ),
              ),
            ),
          ),
        );
      },
    );
  }

}
