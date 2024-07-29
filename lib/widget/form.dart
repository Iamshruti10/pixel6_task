import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:swipeable_button_view/swipeable_button_view.dart';
import '../utils/colors_constant.dart';
import '../utils/number_constant.dart';
import 'common_text_form_field.dart';
import 'common_text_style.dart';

class RequiredForm extends StatelessWidget {
  final TextEditingController panNumberController,
      fullNameController,
      emailIdController,
      mobileNumberController,
      addressLine1Controller,
      addressLine2Controller,
      postCodeController,
      cityController,
      stateController;

  final Key globalKey;
  final bool isFinished;
  final void Function() onFinish;
  final void Function()? onEditingComplete;
  final void Function() onWaitingProcess;
  final bool showLoaderForPan;
  final bool showLoaderForPostCode;
  const RequiredForm(
      {super.key,
      required this.globalKey,
      required this.showLoaderForPostCode,
      required this.showLoaderForPan,
      required this.onWaitingProcess,
      required this.onFinish,
      required this.isFinished,
      this.onEditingComplete,
      required this.mobileNumberController,
      required this.addressLine1Controller,
      required this.addressLine2Controller,
      required this.cityController,
      required this.emailIdController,
      required this.panNumberController,
      required this.postCodeController,
      required this.stateController,
      required this.fullNameController});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(doubleEight),
      child: Form(
        autovalidateMode: AutovalidateMode.onUserInteraction,
        key: globalKey,
        child: ListView(
          padding: const EdgeInsets.all(doubleTwenty),
          children: [
            const SizedBox(
              height: doubleForty,
            ),
            Text(
              'Ensure all required fields are completed !',
              style: CustomTextStyle.semiBold(
                  fontSize: doubleTwentyFour, color: textColor),
            ),
            const SizedBox(
              height: doubleTwenty,
            ),

            //TODO: PAN CARD
            CommonTextFormField(
              suffixIcon: showLoaderForPan
                  ? Padding(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 10, vertical: 6),
                      child: CircularProgressIndicator(
                        backgroundColor: primaryColor,
                        color: whiteColor,
                      ),
                    )
                  : const SizedBox(),
              onEditingComplete: onEditingComplete,
              inputFormatters: [
                LengthLimitingTextInputFormatter(10),
                UpperCaseTextFormatter()
              ],
              controller: panNumberController,
              prefixIcon: Padding(
                padding: const EdgeInsets.all(doubleEight),
                child: Image.asset(
                  'assets/images/doc.png',
                  width: 1,
                ),
              ),
              label: Padding(
                padding: const EdgeInsets.only(left: doubleEight),
                child: Text(
                  'Enter Pan Number*',
                  style: CustomTextStyle.medium(
                      fontSize: doubleTwelve, color: labelColor),
                  textAlign: TextAlign.center,
                ),
              ),
              hintText: 'EX:ABCDE1222G',
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'Enter Pan Card Number';
                }

                // PAN card number should be 10 characters long
                if (value.length != 10) {
                  return 'PAN card number must be 10 characters';
                }

                // Validate if the first five characters are letters
                if (!RegExp(r'^[A-Z]+$').hasMatch(value.substring(0, 5))) {
                  return 'First five characters should be letters';
                }

                // Validate if the next four characters are digits
                if (!RegExp(r'^[0-9]+$').hasMatch(value.substring(5, 9))) {
                  return 'Next four characters should be digits';
                }

                // Validate if the last character is a letter
                if (!RegExp(r'^[A-Z]+$').hasMatch(value.substring(9))) {
                  return 'Last character should be a letter';
                }

                return null;
              },
            ),

            //TODO: FULL NAME
            CommonTextFormField(
              controller: fullNameController,
              prefixIcon: Padding(
                padding: const EdgeInsets.all(doubleEight),
                child: Image.asset(
                  'assets/images/boy.png',
                  width: doubleOne,
                ),
              ),
              label: Padding(
                padding: const EdgeInsets.only(left: doubleEight),
                child: Text(
                  'Enter Full Name*',
                  style: CustomTextStyle.medium(
                      fontSize: doubleTwelve, color: labelColor),
                  textAlign: TextAlign.center,
                ),
              ),
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'Enter Full Name';
                }

                // PAN card number should be 10 characters long
                if (value.length > 140) {
                  return 'Full name should be less than 140';
                }

                return null;
              },
              hintText: 'EX: Shriti Dixit',
            ),

            //TODO: EMAIL ADDRESS
            CommonTextFormField(
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'Please Enter Email Address';
                }
                if (value.length > 255) {
                  return 'Email Id should be less than 140';
                }
                if (!RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$')
                    .hasMatch(value)) {
                  return 'Please enter valid email address';
                }
                return null;
              },
              controller: emailIdController,
              prefixIcon: Padding(
                padding: const EdgeInsets.all(doubleEight),
                child: Image.asset(
                  'assets/images/email.png',
                  width: 1,
                ),
              ),
              label: Padding(
                padding: const EdgeInsets.all(doubleEight),
                child: Text(
                  'Enter Email Address*',
                  style: CustomTextStyle.medium(
                      fontSize: doubleTwelve, color: labelColor),
                  textAlign: TextAlign.center,
                ),
              ),
              hintText: 'EX:abc@gmail.com',
            ),

            //TODO: MOBILE NUMBER
            CommonTextFormField(
              controller: mobileNumberController,
              prefixIcon: Padding(
                padding: const EdgeInsets.all(doubleEight),
                child: Image.asset(
                  'assets/images/call.png',
                  width: 1,
                ),
              ),
              prefix: Text(
                '+91  ',
                style: CustomTextStyle.medium(
                    fontSize: doubleSixteen, color: textColor),
                textAlign: TextAlign.center,
              ),
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'Please Enter Mobile Number';
                }
                if (value.length != 10) {
                  return 'Please Enter valid Number';
                }
              },
              label: Padding(
                padding: const EdgeInsets.all(doubleEight),
                child: Text(
                  "Enter Mobile Number*",
                  style: CustomTextStyle.medium(
                      fontSize: doubleTwelve, color: labelColor),
                  textAlign: TextAlign.center,
                ),
              ),
              hintText: '1234567890',
            ),

            //TODO: ADDRESS : ADDRESS NUMBER ONE
            CommonTextFormField(
              controller: addressLine1Controller,
              prefixIcon: Padding(
                padding: const EdgeInsets.all(doubleEight),
                child: Image.asset(
                  'assets/images/home.png',
                  width: 1,
                ),
              ),
              label: Padding(
                padding: const EdgeInsets.all(doubleEight),
                child: Text(
                  'Enter Address Line 1*',
                  style: CustomTextStyle.medium(
                      fontSize: doubleTwelve, color: labelColor),
                  textAlign: TextAlign.center,
                ),
              ),
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'Please Enter Address Line 1';
                }
              },
              hintText: 'EX:',
            ),

            //TODO: ADDRESS LINE TWO
            CommonTextFormField(
              controller: addressLine2Controller,
              prefixIcon: Padding(
                padding: const EdgeInsets.all(doubleEight),
                child: Image.asset(
                  'assets/images/home.png',
                  width: doubleOne,
                ),
              ),
              label: Padding(
                padding: const EdgeInsets.all(doubleEight),
                child: Text(
                  'Enter Address Line 2',
                  style: CustomTextStyle.medium(
                      fontSize: doubleTwelve, color: labelColor),
                  textAlign: TextAlign.center,
                ),
              ),
              hintText: 'EX:',
            ),
            CommonTextFormField(
              suffixIcon:showLoaderForPostCode? Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
                child: CircularProgressIndicator(
                  backgroundColor: primaryColor,
                  color: whiteColor,
                ),
              ): const SizedBox(),
              controller: postCodeController,
              prefixIcon: Padding(
                padding: const EdgeInsets.all(doubleEight),
                child: Image.asset(
                  'assets/images/postcode.png',
                  width: doubleOne,
                ),
              ),
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'Please Enter Post Code Number';
                }
                return null;
              },
              inputFormatters: [LengthLimitingTextInputFormatter(6)],
              label: Padding(
                padding: const EdgeInsets.all(doubleEight),
                child: Text(
                  'Enter PostCode*',
                  style: CustomTextStyle.medium(
                      fontSize: doubleTwelve, color: labelColor),
                  textAlign: TextAlign.center,
                ),
              ),
              hintText: 'EX:411005',
            ),
            CommonTextFormField(
              controller: cityController,
              prefixIcon: Padding(
                padding: const EdgeInsets.all(doubleEight),
                child: Image.asset(
                  'assets/images/city.png',
                  width: doubleOne,
                ),
              ),
              label: Padding(
                padding: const EdgeInsets.all(doubleEight),
                child: Text(
                  'Enter City Name*',
                  style: CustomTextStyle.medium(
                      fontSize: doubleTwelve, color: labelColor),
                  textAlign: TextAlign.center,
                ),
              ),
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'Please Enter your city';
                }
                return null;
              },
              hintText: 'EX: Pune',
            ),
            CommonTextFormField(
              controller: stateController,
              prefixIcon: Padding(
                padding: const EdgeInsets.all(doubleEight),
                child: Image.asset(
                  'assets/images/india.png',
                  width: doubleOne,
                ),
              ),
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'Please Enter your state';
                }
                return null;
              },
              label: Padding(
                padding: const EdgeInsets.all(doubleEight),
                child: Text(
                  'Enter State Name',
                  style: CustomTextStyle.medium(
                      fontSize: doubleTwelve, color: labelColor),
                  textAlign: TextAlign.center,
                ),
              ),
              hintText: 'EX: INDIA',
            ),
            const SizedBox(
              height: doubleTwenty,
            ),
            SwipeableButtonView(
                buttonText: 'Swipe To Save',
                buttontextstyle: CustomTextStyle.medium(
                    fontSize: doubleSixteen, color: whiteColor),
                buttonWidget: Image.asset(
                  'assets/images/arrow.png',
                  width: doubleTwentyFive,
                  color: primaryColor,
                ),
                activeColor: primaryColor,
                indicatorColor:
                    const AlwaysStoppedAnimation<Color>(Colors.white),
                isFinished: isFinished,
                onFinish: onFinish,
                onWaitingProcess: onWaitingProcess),
          ],
        ),
      ),
    );
  }
}

class UpperCaseTextFormatter extends TextInputFormatter {
  @override
  TextEditingValue formatEditUpdate(
      TextEditingValue oldValue, TextEditingValue newValue) {
    return TextEditingValue(
      text: newValue.text.toUpperCase(),
      selection: newValue.selection,
    );
  }
}
