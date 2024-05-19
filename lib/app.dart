import 'package:airplane/screens/add_flight_screen/cubit/add_flight_cubit.dart';
import 'package:airplane/screens/splash_screen/splash_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'core/theme/app_theme.dart';
import 'core/utils/app_strings.dart';
import 'screens/pick_location_screen/pick_location_screen.dart';

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
        providers: [
          BlocProvider(create: (context) => AddFlightCubit())
        ],
        child: MaterialApp(
          title: AppStrings.appName,
          debugShowCheckedModeBanner: false,
          theme: ThemeManger.appTheme(),
          darkTheme: ThemeManger.darkTheme(),
          themeMode: ThemeMode.light,
          home: const SplashScreen(),
        ));
  }
}
