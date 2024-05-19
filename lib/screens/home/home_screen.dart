import 'package:airplane/core/utils/app_colors.dart';
import 'package:airplane/core/utils/app_constant.dart';
import 'package:airplane/main_layout/cubit/main_cubit.dart';
import 'package:airplane/screens/add_flight_screen/add_flight_screen.dart';
import 'package:airplane/screens/home/cubit/home_cubit.dart';
import 'package:airplane/widgets/app_text.dart';
import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

import '../login_screen/login_screen.dart';
import 'widgets/flight_item_design.dart';

class HomeScreen extends StatelessWidget {
  final bool isAdmin;

  const HomeScreen({Key? key, required this.isAdmin}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    if (isAdmin) {
      return BlocProvider(
        create: (context) => HomeCubit()..getAllFlights(),
        child: BlocConsumer<HomeCubit, HomeState>(
          listener: (context, state) {
            if (state is DeleteFlightState) {
              AppConstant.showToast(
                  msg: "Flight Deleted Successfully", color: Colors.red);
            }
          },
          builder: (context, state) {
            HomeCubit cubit = HomeCubit.get(context);
            return Scaffold(
              floatingActionButton: FloatingActionButton(
                child: const Icon(Icons.add),
                onPressed: () =>
                    AppConstant.navigateTo(context, AddFlightScreen()),
              ),
              appBar: AppBar(
                actions: [
                  IconButton(
                      onPressed: () async {
                        showCustomDialog(context);
                      },
                      icon: const Icon(Icons.exit_to_app_rounded))
                ],
                centerTitle: true,
              ),
              body: SafeArea(
                  child: state is GetAllFlightsAdminLoading
                      ? SpinKitHourGlass(color: AppColors.primary)
                      : HomeCubit.get(context).flightList.isNotEmpty
                          ? Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: ListView.separated(
                                  itemBuilder: (context, index) =>
                                      FlightItemDesign(
                                          isAdmin: isAdmin,
                                          flightModel: cubit.flightList[index]),
                                  separatorBuilder: (context, index) =>
                                      const SizedBox(height: 10),
                                  itemCount: cubit.flightList.length),
                            )
                          : const Center(
                              child: AppText(
                                  text: "No FLight List",
                                  color: Colors.grey,
                                  textSize: 25,
                                  fontWeight: FontWeight.bold),
                            )),
            );
          },
        ),
      );
    } else {
      return BlocConsumer<MainCubit, MainState>(
        listener: (context, state) {},
        builder: (context, state) {
          MainCubit cubit = MainCubit.get(context);
          return state is GetAllFlightsLoading
              ? SpinKitHourGlass(color: AppColors.primary)
              : MainCubit.get(context).flightList.isNotEmpty
                  ? Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: ListView.separated(
                          itemBuilder: (context, index) => FlightItemDesign(
                              isAdmin: isAdmin,
                              flightModel:
                                  MainCubit.get(context).flightList[index]),
                          separatorBuilder: (context, index) =>
                              const SizedBox(height: 10),
                          itemCount: cubit.flightList.length),
                    )
                  : const Center(
                      child: AppText(
                          text: "No FLight List",
                          color: Colors.grey,
                          textSize: 25,
                          fontWeight: FontWeight.bold),
                    );
        },
      );
    }
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
