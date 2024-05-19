import 'package:airplane/core/utils/app_constant.dart';
import 'package:airplane/main_layout/cubit/main_cubit.dart';
import 'package:airplane/models/flight_model.dart';
import 'package:airplane/screens/edit_screen/edit_screen.dart';
import 'package:airplane/screens/home/cubit/home_cubit.dart';
import 'package:airplane/screens/map_screen/map_screen.dart';
import 'package:airplane/widgets/app_text.dart';
import 'package:airplane/widgets/custom_button.dart';
import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class FlightItemDesign extends StatelessWidget {
  final FlightModel flightModel;
  final bool isAdmin;

  double _value = 0;
  String _status = '00';
  final Color _statusColor = Colors.amber;

  FlightItemDesign({Key? key, required this.flightModel, required this.isAdmin})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    if (isAdmin) {
      return BlocConsumer<HomeCubit, HomeState>(
        listener: (context, state) {},
        builder: (context, state) {
          return InkWell(
            onTap: (){
              showDialog(
                context: context,
                builder: (context) {
                  return StatefulBuilder(
                    builder: (context, setState) {
                      return AlertDialog(
                        title: const Text("Flight Speed"),
                        content: Builder(builder: (context) {
                          return SizedBox(
                            height: 200,
                            width: double.infinity,
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Slider(
                                  min: 0.0,
                                  max: 100.0,
                                  value: _value,
                                  divisions: 10,
                                  onChanged: (value) {
                                    setState(() {
                                      _value = value;
                                      _status = '${_value.round()}';
                                    });
                                  },
                                ),
                                Text(
                                  'Status: ${setUpStatus()}',
                                  style: TextStyle(color: _statusColor),
                                ),
                                const Spacer(),
                                CustomButton(
                                    text: "Confirm",
                                    press: () {
                                      AppConstant.navigateTo(
                                          context,
                                          MapScreen(
                                            flightModel: flightModel,
                                            speed: setUpStatus(),
                                          ));
                                    }),
                                const SizedBox(height: 20),
                              ],
                            ),
                          );
                        }),
                      );
                    },
                  );
                },
              );
            },
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 20),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(20),
                gradient: LinearGradient(
                  begin: Alignment.topCenter,
                  colors: [
                    const Color(0xFF1c3d80),
                    const Color(0xFF0078be),
                  ].map((color) => color).toList(),
                ),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      const SizedBox(width: 20),
                      const Spacer(),
                      GestureDetector(
                        onTap: () {
                          showCustomDialog(context);
                        },
                        child: const Icon(
                          Icons.delete,
                          color: Colors.white,
                        ),
                      ),
                      const SizedBox(width: 20),
                      GestureDetector(
                        onTap: (){
                          AppConstant.navigateTo(context, EditFlightScreen(flightModel: flightModel));
                        },
                        child: const Icon(
                          Icons.edit,
                          color: Colors.white,
                        ),
                      ),
                      const SizedBox(width: 10),
                    ],
                  ),
                  const SizedBox(height: 10),
                  Row(
                    children: [
                      const Icon(Icons.credit_card, color: Colors.white),
                      const SizedBox(width: 5),
                      Padding(
                        padding: const EdgeInsets.only(top: 4),
                        child: AppText(
                          text: flightModel.planeCode.toString(),
                          color: Colors.white,
                          textSize: 20,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 10),
                  Row(
                    children: [
                      const Icon(Icons.date_range_sharp, color: Colors.white),
                      const SizedBox(width: 5),
                      Padding(
                        padding: const EdgeInsets.only(top: 4),
                        child: AppText(
                          text: flightModel.flightDate.toString(),
                          color: Colors.white,
                          textSize: 20,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 10),
                  Row(
                    children: [
                      const Icon(Icons.watch_later, color: Colors.white),
                      const SizedBox(width: 5),
                      Padding(
                        padding: const EdgeInsets.only(top: 4),
                        child: AppText(
                          text: flightModel.startTime.toString(),
                          color: Colors.white,
                          textSize: 20,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 10),
                  Row(
                    children: [
                      const Icon(Icons.watch_later, color: Colors.white),
                      const SizedBox(width: 5),
                      Padding(
                        padding: const EdgeInsets.only(top: 4),
                        child: AppText(
                          text: flightModel.arriveTime.toString(),
                          color: Colors.white,
                          textSize: 20,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 10),
                  Row(
                    children: [
                      const Icon(Icons.supervised_user_circle_sharp,
                          color: Colors.white),
                      const SizedBox(width: 5),
                      Padding(
                        padding: const EdgeInsets.only(top: 4),
                        child: AppText(
                          text: flightModel.capacity.toString(),
                          color: Colors.white,
                          textSize: 20,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          );
        },
      );
    } else {
      return BlocConsumer<MainCubit, MainState>(
        listener: (context, state) {},
        builder: (context, state) {
          return InkWell(
            onTap: () {
              showDialog(
                context: context,
                builder: (context) {
                  return StatefulBuilder(
                    builder: (context, setState) {
                      return AlertDialog(
                        title: const Text("Flight Speed"),
                        content: Builder(builder: (context) {
                          return SizedBox(
                            height: 200,
                            width: double.infinity,
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Slider(
                                  min: 0.0,
                                  max: 100.0,
                                  value: _value,
                                  divisions: 10,
                                  onChanged: (value) {
                                    setState(() {
                                      _value = value;
                                      _status = '${_value.round()}';
                                    });
                                  },
                                ),
                                Text(
                                  'Status: ${setUpStatus()}',
                                  style: TextStyle(color: _statusColor),
                                ),
                                const Spacer(),
                                CustomButton(
                                    text: "Confirm",
                                    press: () {
                                      AppConstant.navigateTo(
                                          context,
                                          MapScreen(
                                            flightModel: flightModel,
                                            speed: setUpStatus(),
                                          ));
                                    }),
                                const SizedBox(height: 20),
                              ],
                            ),
                          );
                        }),
                      );
                    },
                  );
                },
              );
            },
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 20),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(20),
                gradient: LinearGradient(
                  begin: Alignment.topCenter,
                  colors: [
                    const Color(0xFF1c3d80),
                    const Color(0xFF0078be),
                  ].map((color) => color).toList(),
                ),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      const Icon(Icons.credit_card, color: Colors.white),
                      const SizedBox(width: 5),
                      Padding(
                        padding: const EdgeInsets.only(top: 4),
                        child: AppText(
                          text: flightModel.planeCode.toString(),
                          color: Colors.white,
                          textSize: 20,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 10),
                  Row(
                    children: [
                      const Icon(Icons.date_range_sharp, color: Colors.white),
                      const SizedBox(width: 5),
                      Padding(
                        padding: const EdgeInsets.only(top: 4),
                        child: AppText(
                          text: flightModel.flightDate.toString(),
                          color: Colors.white,
                          textSize: 20,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 10),
                  Row(
                    children: [
                      const Icon(Icons.watch_later, color: Colors.white),
                      const SizedBox(width: 5),
                      Padding(
                        padding: const EdgeInsets.only(top: 4),
                        child: AppText(
                          text: flightModel.startTime.toString(),
                          color: Colors.white,
                          textSize: 20,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 10),
                  Row(
                    children: [
                      const Icon(Icons.watch_later, color: Colors.white),
                      const SizedBox(width: 5),
                      Padding(
                        padding: const EdgeInsets.only(top: 4),
                        child: AppText(
                          text: flightModel.arriveTime.toString(),
                          color: Colors.white,
                          textSize: 20,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 10),
                  Row(
                    children: [
                      const Icon(Icons.supervised_user_circle_sharp,
                          color: Colors.white),
                      const SizedBox(width: 5),
                      Padding(
                        padding: const EdgeInsets.only(top: 4),
                        child: AppText(
                          text: flightModel.capacity.toString(),
                          color: Colors.white,
                          textSize: 20,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          );
        },
      );
    }
  }

  String setUpStatus() {
    if (_status == "100") {
      return "10";
    } else {
      return _status.substring(0, 1);
    }
  }

  void showCustomDialog(context){
    AwesomeDialog(
      context: context,
      animType: AnimType.scale,
      dialogType: DialogType.info,
      body:Column(
        children: const [
          AppText(text: "Confirmation",fontWeight: FontWeight.bold,textSize: 35),
          SizedBox(height: 40),
          AppText(text: "Are you sure you want to delete this flight ? ",maxLines: 3)
        ],
      ) ,
      title: 'This is Ignored',
      desc:   'This is also Ignored',
      btnOkOnPress: () =>HomeCubit.get(context).deleteFlight(id: flightModel.id.toString()),
      btnCancelOnPress: (){}
    ).show();
  }
}
