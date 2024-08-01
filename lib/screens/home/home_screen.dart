import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:pixel6_task/screens/customer_document_list.dart';
import 'package:pixel6_task/utils/colors_constant.dart';
import 'package:pixel6_task/utils/number_constant.dart';
import 'package:pixel6_task/widget/background_screen.dart';
import 'package:pixel6_task/widget/common_text_form_field.dart';
import 'package:pixel6_task/widget/common_text_style.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../model/customer_model.dart';
import '../widget/form.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
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

  static List<CustomerModel> customers = [];

  //TODO: ADDING INTO LIST

  var isLoading = false;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    loadData();
  }

  loadData() {
    setState(() {
      isLoading = true;
    });
    Future.delayed(const Duration(seconds: 2), () {
      setState(() {
        isLoading = false;
      });
      getCustomerList();
    });
  }

  saveData({
    required CustomerModel customer,
  }) {
    setState(() {
      customers.add(customer);
      saveCustomerList();
    });
  }

  editData({required CustomerModel customer, int? index}) {
    setState(() {
      if (index != null) {
        customers[index] = customer;
        saveCustomerList();
      }
    });
  }

  Future<void> getCustomerList() async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    var customerData = sharedPreferences.getString('customerList');
    if (customerData != null) {
      setState(() {
        customers = (jsonDecode(customerData) as List)
            .map((e) => CustomerModel.fromJson(e))
            .toList();
      });
    }
  }

  Future<void> saveCustomerList() async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    sharedPreferences.setString(
      'customerList',
      jsonEncode(
        customers.map((e) => e.toJson()).toList(),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        centerTitle: false,
        title: Text(
          'Welcome',
          style: CustomTextStyle.semiBold(fontSize: 24, color: textColor),
        ),
        actions: [
          Padding(
            padding: const EdgeInsets.only(right: 8.0),
            child: GestureDetector(
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) =>
                        CustomerDocumentList(saveData: saveData),
                  ),
                );
              },
              child: Chip(
                backgroundColor: primaryColor,
                avatar: Icon(
                  Icons.add,
                  color: whiteColor,
                ),
                label: Text(
                  'Add Document',
                  style: CustomTextStyle.medium(
                      fontSize: doubleTwelve, color: whiteColor),
                ),
              ),
            ),
          ),
        ],
      ),
      body: Stack(
        children: [
          const BackgroundScreen(),
          isLoading
              ? Align(
                  alignment: Alignment.center,
                  child: CircleAvatar(
                    backgroundColor: primaryColor,
                    radius: 35,
                    child: CircularProgressIndicator(
                      backgroundColor: whiteColor,
                    ),
                  ),
                )
              : customers.isEmpty
                  ? Center(
                      child: Text(
                        'Data Not Found!',
                        style: CustomTextStyle.semiBold(
                            fontSize: doubleTwenty, color: textColor),
                      ),
                    )
                  : Align(
                      alignment: Alignment.topCenter,
                      child: ListView.builder(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 10, vertical: 10),
                        itemCount: customers.length,
                        itemBuilder: (_, index) {
                          return Card(
                            elevation: 20,
                            child: Container(
                              padding: const EdgeInsets.all(doubleEight),
                              decoration: BoxDecoration(
                                color: Colors.white,
                                borderRadius: BorderRadius.circular(doubleTen),
                              ),
                              width: double.infinity,
                              child: Column(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceAround,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.start,
                                        crossAxisAlignment:
                                            CrossAxisAlignment.center,
                                        children: [
                                          const CircleAvatar(
                                            radius: 20,
                                            backgroundImage: AssetImage(
                                                'assets/images/boy.png'),
                                          ),
                                          Text(
                                            ' ${customers[index].fullName}',
                                            style: CustomTextStyle.semiBold(
                                                fontSize: 20, color: textColor),
                                          ),
                                        ],
                                      ),
                                      TextButton(
                                          onPressed: () {
                                            Navigator.push(
                                              context,
                                              MaterialPageRoute(
                                                builder: (_) =>
                                                    CustomerDocumentList(
                                                        index: index,
                                                        customerModel:
                                                            customers[index],
                                                        editData: editData),
                                              ),
                                            );
                                          },
                                          child: const Text('Edit'))
                                    ],
                                  ),
                                  const SizedBox(
                                    height: 10,
                                  ),
                                  Text(
                                    'PAN Number: ${customers[index].documentNumber}',
                                    style: CustomTextStyle.semiBold(
                                        fontSize: doubleSixteen,
                                        color: textColor),
                                  ),
                                  Text(
                                    'Email ID: ${customers[index].emailId}',
                                    style: CustomTextStyle.semiBold(
                                        fontSize: doubleSixteen,
                                        color: textColor),
                                  ),
                                  Text(
                                    'Mobile Number: ${customers[index].mobileNumber}',
                                    style: CustomTextStyle.semiBold(
                                        fontSize: doubleSixteen,
                                        color: textColor),
                                  ),
                                  Text(
                                    'Address: ${customers[index].address1} ${customers[index].address2}',
                                    style: CustomTextStyle.semiBold(
                                        fontSize: doubleSixteen,
                                        color: textColor),
                                  ),
                                  Text(
                                    'PostCode: ${customers[index].postCode}',
                                    style: CustomTextStyle.semiBold(
                                        fontSize: doubleSixteen,
                                        color: textColor),
                                  ),
                                  Text(
                                    'City: ${customers[index].cityName}',
                                    style: CustomTextStyle.semiBold(
                                        fontSize: doubleSixteen,
                                        color: textColor),
                                  ),
                                  Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Text(
                                        'State: ${customers[index].state}',
                                        style: CustomTextStyle.semiBold(
                                            fontSize: doubleSixteen,
                                            color: textColor),
                                      ),
                                      TextButton(
                                        onPressed: () {
                                          setState(() {
                                            customers.removeAt(index);
                                          });
                                        },
                                        child: Text(
                                          'Delete',
                                          style: CustomTextStyle.medium(
                                              fontSize: doubleFourteen,
                                              color: Colors.redAccent),
                                        ),
                                      )
                                    ],
                                  ),
                                ],
                              ),
                            ),
                          );
                        },
                      ),
                    )
        ],
      ),
    );
  }
}
