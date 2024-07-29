import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:pixel6_task/utils/colors_constant.dart';
import 'package:pixel6_task/utils/number_constant.dart';
import 'package:pixel6_task/widget/common_text_style.dart';

class CommonTextFormField extends StatelessWidget {
  final Widget? prefix;
  final Widget? label;
  final Widget? suffixIcon;
  final Widget? prefixIcon;
  final TextInputType? keyboardType;
  final String? hintText;
  final TextEditingController? controller;
  final String? Function(String?)? validator;
  final int? maxLength;
  final void Function(String)? onChanged;
  final void Function()? onEditingComplete;
  final List<TextInputFormatter>? inputFormatters;

  const CommonTextFormField(
      {super.key,
      this.onChanged,
      this.hintText,
      this.prefixIcon,
      this.suffixIcon,
      this.label,
      this.onEditingComplete,
      this.keyboardType,
      this.prefix,
      this.maxLength,
      this.inputFormatters,
      this.controller,
      this.validator});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(doubleTwelve)),
      margin: const EdgeInsets.only(
        bottom: doubleTen,
      ),
      child: TextFormField(
        onEditingComplete: onEditingComplete,
        onChanged: onChanged,
        inputFormatters: inputFormatters,
        autofocus: true,
        autocorrect: true,
        maxLength: maxLength,
        validator: validator,
        controller: controller,
        keyboardType: keyboardType,
        style:
            CustomTextStyle.medium(fontSize: doubleSixteen, color: textColor),
        decoration: InputDecoration(
            enabled: true,
            prefixIcon: prefixIcon,
            suffixIcon: suffixIcon,
            floatingLabelStyle:
                CustomTextStyle.italic(fontSize: 12, color: labelColor),
            floatingLabelAlignment: FloatingLabelAlignment.start,
            fillColor: whiteColor,
            label: label,
            labelStyle: CustomTextStyle.regular(
                fontSize: doubleTwelve, color: labelColor),
            prefix: prefix,
            hintText: hintText,
            hintStyle: const TextStyle(
              color: Colors.grey,
              fontSize: doubleThirteen,
            ),
            focusedBorder: OutlineInputBorder(
              borderRadius: const BorderRadius.all(
                Radius.circular(doubleFifteen),
              ),
              borderSide: BorderSide(color: primaryColor),
            ),
            disabledBorder: InputBorder.none,
            border: InputBorder.none
            // border: const OutlineInputBorder(
            //
            //   borderRadius: BorderRadius.all(Radius.circular(doubleTwelve)),
            //
            // ),
            ),
      ),
    );
  }
}
