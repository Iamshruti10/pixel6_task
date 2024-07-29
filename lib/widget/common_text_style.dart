
import 'package:flutter/material.dart';

import '../utils/font_family.dart';

class CustomTextStyle {
  static TextTheme get textTheme => ThemeData.light().textTheme;

  // TODO: Regular Font Styles with Color
  static TextStyle regular({required double fontSize, Color color = Colors.black}) =>
      textTheme.bodyMedium!.copyWith(fontSize: fontSize, fontFamily: regularFontFamily, color: color);

  // TODO: Bold Font Styles with Color
  static TextStyle bold({required double fontSize, Color color = Colors.black}) =>
      textTheme.bodyMedium!.copyWith(fontSize: fontSize, fontFamily: boldFontFamily, color: color);

  // TODO: SemiBold Font Styles with Color
  static TextStyle semiBold({required double fontSize, Color color = Colors.black}) =>
      textTheme.bodyMedium!.copyWith(fontSize: fontSize, fontFamily: semiBoldFontFamily, color: color);


  // TODO: Medium Font Styles with Color
  static TextStyle medium({required double fontSize, Color color = Colors.black}) =>
      textTheme.bodyMedium!.copyWith(fontSize: fontSize, fontFamily: mediumFontFamily, color: color);

  // TODO: Italic Font Styles with Color
  static TextStyle italic({required double fontSize, Color color = Colors.black}) =>
      textTheme.bodyMedium!.copyWith(fontSize: fontSize, fontFamily: italicFontFamily, color: color, fontWeight: FontWeight.bold);
}
