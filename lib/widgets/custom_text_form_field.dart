import 'package:airplane/core/utils/app_strings.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/flutter_svg.dart';
import '../core/theme/app_theme.dart';
import '../core/utils/app_colors.dart';
import '../core/utils/app_size.dart';

class CustomTextFormField extends StatelessWidget {
  final TextInputType? type;
  final FormFieldValidator<String>? validate;
  final VoidCallback? onTap;
  final void Function(String?)? onChange;
  final VoidCallback? onSuffixPressed;
  final TextEditingController? controller;
  final IconData? suffixIcon;
  final String? labelText;
  final String? hintText;
  final String? prefixIcon;
  final Color? prefixIconColor;
  final bool? isEnable;
  final List<TextInputFormatter>? limits;
  final int? maxLines;
  final double? textSize;
  final bool isPassword;

  const CustomTextFormField(
      {super.key,
      this.type = TextInputType.text,
      this.validate,
      this.onChange,
      this.limits,
      this.textSize,
      this.onTap,
      this.maxLines = 1,
      this.suffixIcon,
      this.isPassword = false,
      this.onSuffixPressed,
      this.controller,
      this.isEnable = true,
      this.labelText,
      this.prefixIconColor,
      this.hintText,
      this.prefixIcon});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
          color: Colors.white,
          borderRadius:
              BorderRadius.all(Radius.circular(SizeConfig.bodyHeight * .02))),
      child: TextFormField(
        textAlign: TextAlign.start,
        inputFormatters: limits,
        controller: controller,
        keyboardType: type,
        obscureText: isPassword,
        style: Theme.of(context).textTheme.bodyMedium!.copyWith(
              fontFamily: AppStrings.englishFont,
              overflow: TextOverflow.ellipsis,
              color: Colors.black,
              fontSize: setUpSize(),
            ),
        enabled: isEnable,
        maxLines: maxLines,
        validator: validate,
        onChanged: onChange,
        onTap: onTap,
        decoration: InputDecoration(
          border: buildMainBuild(),
          enabledBorder: buildMainBuild(),
          errorStyle: const TextStyle(color: Colors.red),
          disabledBorder: buildMainBuild(),
          focusedBorder: buildMainBuild(),
          labelText: labelText,
          focusedErrorBorder: buildErrorBorder(),
          errorBorder: buildErrorBorder(),
          prefixIcon: prefixIcon == null
              ? null
              : Padding(
                  padding: EdgeInsets.all(SizeConfig.bodyHeight * .012),
                  child: SvgPicture.asset(prefixIcon!),
                ),
          hintText: hintText,
          hintStyle: TextStyle(
            color: Colors.grey,
            fontSize: setUpSize(),
          ),
          floatingLabelBehavior: FloatingLabelBehavior.auto,
          suffixIcon: IconButton(
            icon: Icon(
              suffixIcon,
              color: AppColors.primary,
            ),
            onPressed: onSuffixPressed,
          ),
        ),
      ),
    );
  }

  double setUpSize() {
    if (textSize == null) {
      return getProportionateScreenHeight(20.0);
    } else {
      return getProportionateScreenHeight(textSize!);
    }
  }


}
