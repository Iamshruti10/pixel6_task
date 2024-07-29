import 'dart:ui';
import 'package:flutter/material.dart';
import '../utils/colors_constant.dart';

class BackgroundScreen extends StatelessWidget {
  const BackgroundScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Align(
          alignment: Alignment.topRight,
          child: CircleAvatar(
            radius: 70,
            backgroundColor: Colors.yellow[100],
          ),
        ),
        Positioned(
          top: 100,
          left: 0,
          child: CircleAvatar(
            radius: 70,
            backgroundColor: Colors.green[50],
          ),
        ),
        Positioned(
          top: 300,
          right: 0,
          child: CircleAvatar(
            radius: 70,
            backgroundColor: primaryColor.withOpacity(0.2),
          ),
        ),
        Positioned(
          top: 500,
          child: CircleAvatar(
            radius: 70,
            backgroundColor: Colors.cyan[50],
          ),
        ),
        Align(
          alignment: Alignment.bottomRight,
          child: CircleAvatar(
            radius: 80,
            backgroundColor: Colors.yellow[50],
          ),
        ),
        Positioned.fill(
          child: BackdropFilter(
            filter: ImageFilter.blur(
              sigmaX: 20,
              sigmaY: 20,
            ),
            child: const SizedBox(),
          ),
        )
      ],
    );
  }
}
