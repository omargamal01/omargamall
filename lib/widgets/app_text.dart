import 'package:flutter/material.dart';

import '../core/utils/app_size.dart';
import '../core/utils/app_strings.dart';


class AppText extends StatelessWidget {
  final String text;
  final Color? color;
  final double? textSize;
  final FontWeight? fontWeight;
  final TextDecoration? textDecoration;
  final TextAlign? align;
  final int? maxLines;
  final String? fontFamily;
  final bool? isLogo;

  const AppText({
    super.key,
    required this.text,
    this.color,
    this.textSize,
    this.fontWeight,
    this.maxLines,
    this.textDecoration,
    this.fontFamily,
    this.align,
    this.isLogo = false,
  });

  @override
  Widget build(BuildContext context) {
    return Text(text,
        maxLines: maxLines,
        textAlign: align,
        overflow: TextOverflow.ellipsis,
        style: Theme.of(context).textTheme.bodyMedium!.copyWith(
              fontFamily: AppStrings.englishFont,
              overflow: TextOverflow.ellipsis,
              decoration: textDecoration,
              color: color ?? Theme.of(context).textTheme.bodyMedium!.color,
              fontSize: setUpSize(),
              fontWeight: fontWeight ?? FontWeight.w400,
            ));
  }

  double setUpSize() {
    if (textSize == null) {
      return getProportionateScreenHeight(18.0);
    } else {
      return getProportionateScreenHeight(textSize!);
    }
  }


}
