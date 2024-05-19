import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import '../utils/app_colors.dart';
import '../utils/app_size.dart';
import '../utils/app_strings.dart';

class ThemeManger {
  static ThemeData appTheme() {
    return ThemeData(
      scaffoldBackgroundColor: Colors.white,
      textTheme: TextTheme(
          bodyMedium: const TextStyle(color: Colors.black),
          headlineMedium: TextStyle(color: AppColors.iconGrey)),
      appBarTheme: AppBarTheme(
          elevation: 0.0,
          backgroundColor: Colors.white,
          centerTitle: true,
          iconTheme: IconThemeData(
            color: AppColors.iconGrey,
          ),
          actionsIconTheme: IconThemeData(
            color: AppColors.iconGrey,
          ),
          systemOverlayStyle:const SystemUiOverlayStyle(
              statusBarBrightness: Brightness.dark,
              statusBarIconBrightness: Brightness.dark,
              statusBarColor: Colors.white)),
      brightness: Brightness.light,
      fontFamily: AppStrings.englishFont,
      inputDecorationTheme: InputDecorationTheme(
        border: buildBorder(),
        enabledBorder: buildBorder(),
        disabledBorder: buildBorder(),
        focusedBorder: buildBorder(),
        errorBorder: buildBorder(),
      ),
      bottomNavigationBarTheme: BottomNavigationBarThemeData(
        type: BottomNavigationBarType.fixed,
        showUnselectedLabels: true,
        showSelectedLabels: true,
        selectedItemColor: AppColors.primary,
        unselectedItemColor: Colors.grey,
      ),
      primaryColor: AppColors.primary,
      colorScheme: ColorScheme.fromSwatch().copyWith(
        secondary: AppColors.primary,
        primary: AppColors.primary,
        brightness: Brightness.light,
        onPrimary: Colors.white,
        onSecondary: Colors.white,
        primaryContainer: AppColors.lightGrey,
        error: Colors.black,
        onError: Colors.white,
        background: Colors.blue,
        onBackground: Colors.white,
        surface: Colors.pink,
        onSurface: Colors.white,
      ),
    );
  }

  static ThemeData darkTheme() {
    return ThemeData(
      scaffoldBackgroundColor: AppColors.darkModeColor,
      appBarTheme: AppBarTheme(
          elevation: 0.0,
          backgroundColor: AppColors.darkModeColor,
          centerTitle: true,
          actionsIconTheme: IconThemeData(
            color: AppColors.iconGrey,
          ),
          iconTheme: IconThemeData(
            color: AppColors.iconGrey,
          ),
          systemOverlayStyle:  SystemUiOverlayStyle(
            statusBarBrightness: Brightness.light,
            statusBarIconBrightness: Brightness.light,
            statusBarColor: AppColors.darkModeColor
          )),
      inputDecorationTheme: InputDecorationTheme(
        border: buildBorder(),
        enabledBorder: buildBorder(),
        disabledBorder: buildBorder(),
        focusedBorder: buildBorder(),
        errorBorder: buildBorder(),
      ),
      iconTheme: IconThemeData(color: AppColors.iconGrey),
      fontFamily: AppStrings.englishFont,
      textTheme: TextTheme(
          bodyMedium: const TextStyle(color: Colors.white),
          headlineMedium: TextStyle(color: AppColors.hint)),
      bottomNavigationBarTheme: BottomNavigationBarThemeData(
        type: BottomNavigationBarType.fixed,
        showUnselectedLabels: true,
        showSelectedLabels: true,
        selectedItemColor: AppColors.primary,
        unselectedItemColor: Colors.grey,
      ),
      primaryColor: AppColors.primary,
      colorScheme: ColorScheme.fromSwatch().copyWith(
        secondary: AppColors.primary,
        primary: AppColors.primary,
        brightness: Brightness.dark,
        onPrimary: Colors.black,
        onSecondary: Colors.black,
        primaryContainer: AppColors.darkModeColor,
        error: Colors.black,
        onError: Colors.black,
        background: Colors.blue,
        onBackground: Colors.black,
        surface: Colors.pink,
        onSurface: Colors.black,
      ),
    );
  }
}



OutlineInputBorder buildBorder() {
  return const OutlineInputBorder(
    borderSide: BorderSide(color: Colors.transparent),
  );
}

OutlineInputBorder buildMainBuild() {
  return OutlineInputBorder(
    borderSide: BorderSide(color: AppColors.primary),
    borderRadius:
        BorderRadius.all(Radius.circular(SizeConfig.bodyHeight * .02)),
  );
}

OutlineInputBorder buildErrorBorder() {
  return OutlineInputBorder(
    borderSide: const BorderSide(color: Colors.red),
    borderRadius:
        BorderRadius.all(Radius.circular(SizeConfig.bodyHeight * .02)),
  );
}

BorderRadius setUpBorderRadius() {
  return BorderRadius.circular(SizeConfig.bodyHeight * .02);
}
