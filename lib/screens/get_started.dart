import 'package:flutter/material.dart';
import 'package:pixel6_task/screens/home_screen.dart';
import 'package:pixel6_task/utils/colors_constant.dart';
import 'package:pixel6_task/utils/number_constant.dart';
import 'package:pixel6_task/widget/common_text_style.dart';

import '../widget/background_screen.dart';
import 'customer_document_list.dart';

class GetStarted extends StatelessWidget {
  const GetStarted({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Stack(
        children: [
          const BackgroundScreen(),
          Align(
            alignment: Alignment.topCenter,
            child: Image.asset('assets/images/home_image.png'),
          ),
          Align(
            alignment: Alignment.center,
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Spacer(
                    flex: 4,
                  ),
                  Text(
                    'Document Management & TO-DO List',
                    style: CustomTextStyle.semiBold(
                        fontSize: doubleTwentyFour, color: textColor),
                    textAlign: TextAlign.center,
                  ),
                  const SizedBox(
                    height: doubleThirteen,
                  ),
                  Text(
                    'This productive tool is designed to help you better manage your task project-wise conveniently!',
                    style: CustomTextStyle.regular(
                        fontSize: doubleFourteen, color: textColor),
                    textAlign: TextAlign.center,
                  ),
                  const Spacer(
                    flex: 1,
                  ),
                  SizedBox(
                    height: 55,
                    width: double.infinity,
                    child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(doubleTwenty),
                        ),
                      ),
                      onPressed: () {
                        Navigator.pushAndRemoveUntil(
                            context,
                            MaterialPageRoute(
                                builder: (_) => const HomeScreen()),
                            (_) => false);
                      },
                      child: ListTile(
                        title: Text(
                          "Let's Start",
                          style: CustomTextStyle.semiBold(
                              fontSize: doubleNineteen, color: whiteColor),
                          textAlign: TextAlign.center,
                        ),
                        trailing: Image.asset(
                          'assets/images/arrow.png',
                          width: 25,
                        ),
                      ),
                    ),
                  ),
                  const Spacer(),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
