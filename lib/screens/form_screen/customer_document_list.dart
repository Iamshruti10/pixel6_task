import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:pixel6_task/model/customer_model.dart';
import '../widget/background_screen.dart';
import '../widget/form.dart';

class CustomerDocumentList extends StatefulWidget {
  final void Function({required CustomerModel customer})? saveData;
  final void Function({required CustomerModel customer, required int? index})?
      editData;
  final CustomerModel? customerModel;
  final int? index;

  const CustomerDocumentList(
      {super.key,
      this.saveData,
      this.customerModel,
      this.index,
      this.editData});

  @override
  State<CustomerDocumentList> createState() => _CustomerDocumentListState();
}

class _CustomerDocumentListState extends State<CustomerDocumentList> {
  // TODO: CRATING LIST

  //TODO: TEXT EDITING CONTROLLERS
  TextEditingController panNumberController = TextEditingController();
  TextEditingController fullNameController = TextEditingController();
  TextEditingController emailIdController = TextEditingController();
  TextEditingController mobileNumberController = TextEditingController();
  TextEditingController address1Controller = TextEditingController();
  TextEditingController address2Controller = TextEditingController();
  TextEditingController postCodeController = TextEditingController();
  TextEditingController cityController = TextEditingController();
  TextEditingController stateController = TextEditingController();

  var isFinished = false;

  var isPanLoading = false;

  GlobalKey<FormState> globalKey = GlobalKey<FormState>();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    panNumberController.addListener(_checkPanNumber);
    postCodeController.addListener(_checkPostCodeNumber);
    setData();
  }

  void setData() {
    if (widget.customerModel != null) {
      fullNameController.text = widget.customerModel?.fullName ?? '';
      emailIdController.text = widget.customerModel?.emailId ?? '';
      mobileNumberController.text = widget.customerModel?.mobileNumber ?? '';
      address1Controller.text = widget.customerModel?.address1 ?? '';
      address2Controller.text = widget.customerModel?.address2 ?? '';
      postCodeController.text = widget.customerModel?.postCode ?? '';
      cityController.text = widget.customerModel?.cityName ?? '';
      stateController.text = widget.customerModel?.state ?? '';
      panNumberController.text = widget.customerModel?.documentNumber ?? '';
    }
  }

  void _checkPanNumber() {
    if (panNumberController.text.length == 10) {
      getPanCardData(panNumber: panNumberController.text);
      setState(() {});
    }
  }

  void _checkPostCodeNumber() {
    if (postCodeController.text.length == 6) {
      getPostCodeData(postCode: postCodeController.text);
      setState(() {});
    }
  }

  var isPostCodeLoading = false;
  Future<dynamic> getPostCodeData({postCode}) async {
    var endPoint = "https://lab.pixel6.co/api/get-postcode-details.php";
    var body = {"postcode": postCode};
    setState(() {
      isPostCodeLoading = true;
    });
    var response = await http.post(Uri.parse(endPoint), body: jsonEncode(body));
    if (response.statusCode == 200) {
      var city = jsonDecode(response.body)['city'][0]['name'];
      var state = jsonDecode(response.body)['state'][0]['name'];

      setState(() {
        isPostCodeLoading = false;
        cityController.text = city;
        stateController.text = state;
      });
    }
  }

  Future<dynamic> getPanCardData({panNumber}) async {
    var endPoint = "https://lab.pixel6.co/api/verify-pan.php";
    var body = {"panNumber": panNumber};
    setState(() {
      isPanLoading = true;
    });
    var response = await http.post(Uri.parse(endPoint), body: jsonEncode(body));
    if (response.statusCode == 200) {
      var fullName = jsonDecode(response.body)['fullName'];

      setState(() {
        isPanLoading = false;
        fullNameController.text = fullName;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          const BackgroundScreen(),
          RequiredForm(
            showLoaderForPostCode: isPostCodeLoading,
            showLoaderForPan: isPanLoading,
            onEditingComplete: () async {
              await getPanCardData(panNumber: panNumberController.text);
            },
            globalKey: globalKey,
            isFinished: isFinished,
            onWaitingProcess: () {
              setState(() {
                isFinished = true;
              });
              Future.delayed(const Duration(seconds: 2), () {
                setState(() {
                  isFinished = false;
                });
              });
            },
            onFinish: () {
              if (globalKey.currentState!.validate()) {
                if (widget.customerModel == null) {
                  var user = CustomerModel(
                      documentNumber: panNumberController.text,
                      fullName: fullNameController.text,
                      emailId: emailIdController.text,
                      mobileNumber: mobileNumberController.text,
                      address1: address1Controller.text,
                      address2: address2Controller.text,
                      postCode: postCodeController.text,
                      cityName: cityController.text,
                      state: stateController.text);

                  widget.saveData!(customer: user);
                  Navigator.pop(context);
                } else {
                  var user = CustomerModel(
                      documentNumber: panNumberController.text,
                      fullName: fullNameController.text,
                      emailId: emailIdController.text,
                      mobileNumber: mobileNumberController.text,
                      address1: address1Controller.text,
                      address2: address2Controller.text,
                      postCode: postCodeController.text,
                      cityName: cityController.text,
                      state: stateController.text);
                  widget.editData!(index: widget.index, customer: user);
                  Navigator.pop(context);
                }
              }
            },
            panNumberController: panNumberController,
            fullNameController: fullNameController,
            emailIdController: emailIdController,
            mobileNumberController: mobileNumberController,
            addressLine1Controller: address1Controller,
            addressLine2Controller: address2Controller,
            postCodeController: postCodeController,
            cityController: cityController,
            stateController: stateController,
          ),
        ],
      ),
    );
  }
}

// validator: (value) {
//                       if (value == null || value.isEmpty) {
//                         return 'enter_pan_card'.tr;
//                       }
//
//                       // PAN card number should be 10 characters long
//                       if (value.length != 10) {
//                         return 'pan_10_characters'.tr;
//                       }
//
//                       // Validate if the first five characters are letters
//                       if (!RegExp(r'^[A-Z]+$')
//                           .hasMatch(value.substring(0, 5))) {
//                         return 'first_five_letters'.tr;
//                       }
//
//                       // Validate if the next four characters are digits
//                       if (!RegExp(r'^[0-9]+$')
//                           .hasMatch(value.substring(5, 9))) {
//                         return 'next_four_digits'.tr;
//                       }
//
//                       // Validate if the last character is a letter
//                       if (!RegExp(r'^[A-Z]+$').hasMatch(value.substring(9))) {
//                         return 'last_letter'.tr;
//                       }
//
//
//                       return null;
//                     },
// inputFormatters: [
// LengthLimitingTextInputFormatter(10),
// UpperCaseTextFormatter()
// ],
