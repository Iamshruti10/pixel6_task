import 'package:flutter/material.dart';
import 'package:pixel6_task/utils/colors_constant.dart';
import 'package:pixel6_task/widget/common_text_style.dart';

import '../utils/number_constant.dart';

class ThemeHelper {
  static ThemeData get lightTheme => ThemeData(
        useMaterial3: true,
        primaryColorLight: Colors.transparent,

        primaryColorDark: Colors.transparent,

        bottomSheetTheme: const BottomSheetThemeData(),
        bottomNavigationBarTheme: BottomNavigationBarThemeData(
          backgroundColor: primaryColor,
        ),
        floatingActionButtonTheme: const FloatingActionButtonThemeData(),
        inputDecorationTheme: const InputDecorationTheme(),
        textSelectionTheme: const TextSelectionThemeData(
          cursorColor: Colors.black,
        ),

        // textTheme: TextThemes.textTheme(),
        elevatedButtonTheme: ElevatedButtonThemeData(
          style: ElevatedButton.styleFrom(
              backgroundColor: primaryColor,
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(doubleTen))),
        ),
        primaryColor: Colors.green,
        textButtonTheme: const TextButtonThemeData(
          style: ButtonStyle(
            textStyle: MaterialStatePropertyAll(
              TextStyle(
                  fontWeight: FontWeight.bold,
                  // fontFamily: regular,
                  color: Colors.white),
            ),
          ),
        ),
      );
}

ThemeData get theme => ThemeHelper.lightTheme;
