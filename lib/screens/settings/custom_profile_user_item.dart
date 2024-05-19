import 'package:airplane/core/utils/app_size.dart';
import 'package:airplane/widgets/app_text.dart';
import 'package:airplane/widgets/custom_text_form_field.dart';
import 'package:flutter/material.dart';

class CustomProfileUserItem extends StatelessWidget {
  final String label;
  final TextEditingController controller;
  final FormFieldValidator<String>? validate;
  final TextInputType type;

  const CustomProfileUserItem(
      {Key? key,
      required this.label,
      required this.controller,
      this.type = TextInputType.text,
      required this.validate})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        AppText(text: label, textSize: 16),
        SizedBox(height: getProportionateScreenHeight(8)),

      ],
    );
  }
}
