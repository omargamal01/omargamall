import 'package:flutter/material.dart';
import '../core/utils/app_colors.dart';
import '../core/utils/app_size.dart';
import 'app_text.dart';

class CustomButton extends StatelessWidget {
  const CustomButton({
    Key? key,
    required this.text,
    this.textSize,
    required this.press,
    this.iconData,
    this.iconColor,
    this.width,
    this.radius,
    this.backgroundColor,
    this.textColor,
    this.borderColor,
    this.height,
  }) : super(key: key);
  final String? text;
  final Function? press;
  final double? width;
  final double? height;
  final double? textSize;
  final double? radius;
  final Color? backgroundColor;
  final Color? textColor;
  final Color? iconColor;
  final Color? borderColor;
  final IconData? iconData;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: width == null
          ? double.infinity
          : getProportionateScreenHeight(width!),
      height: height == null
          ? getProportionateScreenHeight(60)
          : getProportionateScreenHeight(height!),
      decoration: BoxDecoration(
          border: Border.all(
              color: borderColor == null ? AppColors.primary : borderColor!,
              width: getProportionateScreenHeight(1)),
          color: backgroundColor ?? AppColors.primary,
          borderRadius: BorderRadius.circular(radius == null
              ? getProportionateScreenHeight(10)
              : getProportionateScreenHeight(radius!))),
      child: text != null
          ? MaterialButton(
              onPressed: press as void Function(),
              child: AppText(
                color: textColor ?? Colors.white,
                text: text!,
                fontWeight: FontWeight.w500,
                textSize: textSize == null
                    ? getProportionateScreenHeight(22.0)
                    : getProportionateScreenHeight(textSize!),
              ),
            )
          : Icon(iconData, color: iconColor ?? Colors.white),
    );
  }
}
