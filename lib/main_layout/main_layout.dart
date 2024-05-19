import 'package:airplane/main_layout/cubit/main_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';

class MainLayout extends StatelessWidget {
  const MainLayout({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => MainCubit()..getAllFlights(),
      child: BlocConsumer<MainCubit, MainState>(
        listener: (context, state) {
          // TODO: implement listener
        },
        builder: (context, state) {
          MainCubit cubit = MainCubit.get(context);
          return Scaffold(
            body: SafeArea(child: cubit.screens[cubit.currentIndex]),
            bottomNavigationBar: BottomNavigationBar(
              items: cubit.bottomNavBarItems,
              currentIndex: cubit.currentIndex,
              onTap: (index) => cubit.changeCurrentIndex(index),
            ),
          );
        },
      ),
    );
  }
}
