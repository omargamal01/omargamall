import 'package:another_flushbar/flushbar.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:intl/intl.dart';
import 'app_colors.dart';

class AppConstant {
  static void showErrorDialog(
      {required BuildContext context, required String msg}) {
    showDialog(
        context: context,
        builder: (context) => CupertinoAlertDialog(
              title: Text(
                msg,
                style: const TextStyle(color: Colors.black, fontSize: 16),
              ),
              actions: [
                TextButton(
                  onPressed: () => Navigator.pop(context),
                  style: TextButton.styleFrom(
                      primary: Colors.black,
                      textStyle: const TextStyle(
                          fontSize: 14, fontWeight: FontWeight.bold)),
                  child: const Text('Ok'),
                )
              ],
            ));
  }

  static void showCustomSnakeBar(context, msg, isSuccess) {
    Flushbar(
      message: msg,
      icon: isSuccess
          ? Icon(
              Icons.check,
              size: 28.0,
              color: Colors.blue[300],
            )
          : Icon(
              Icons.info_outline,
              size: 28.0,
              color: Colors.blue[300],
            ),
      margin: const EdgeInsets.all(8),
      borderRadius: BorderRadius.circular(8),
      duration: const Duration(seconds: 3),
      leftBarIndicatorColor: Colors.blue[300],
    ).show(context);
  }

  static void showToast(
      {required String msg, Color? color, ToastGravity? gravity ,  bool isLong = true}) {
    Fluttertoast.showToast(
        toastLength: isLong ? Toast.LENGTH_LONG:Toast.LENGTH_SHORT,
        msg: msg,
        backgroundColor: color ?? AppColors.primary,
        gravity: gravity ?? ToastGravity.BOTTOM);
  }

  static void navigateTo(context, widget) => Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => widget,
        ),
      );

  static void navigateToAndFinish(context, widget) =>
      Navigator.pushAndRemoveUntil(
        context,
        MaterialPageRoute(
          builder: (context) => widget,
        ),
        (Route<dynamic> route) => false,
      );

  static void showSnackBar(BuildContext context, String errorMsg) {
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(
      content: Text(errorMsg),
      backgroundColor: Colors.black,
      duration: const Duration(seconds: 5),
    ));
  }

  static void showCustomProgressIndicator(BuildContext context) {
    showDialog(
      barrierColor: Colors.white.withOpacity(0),
      barrierDismissible: false,
      context: context,
      useRootNavigator: true,
      builder: (context) {
        return SpinKitFadingCircle(color: AppColors.primary);
      },
    );
  }

  static String formatTime({DateTime? dateTime}) {
    return DateFormat.jms().format(dateTime ?? DateTime.now());
  }

  static String formatDate({DateTime? dateTime}) {
    return DateFormat.yMMMEd().format(dateTime ?? DateTime.now());
  }
}
