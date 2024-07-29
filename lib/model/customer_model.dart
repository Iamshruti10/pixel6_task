class CustomerModel {
  String documentNumber;
  String fullName;
  String emailId;
  String mobileNumber;
  String address1;
  String address2;
  String postCode;
  String cityName;
  String state;

  CustomerModel({
    required this.documentNumber,
    required this.fullName,
    required this.emailId,
    required this.mobileNumber,
    required this.address1,
    required this.address2,
    required this.postCode,
    required this.cityName,
    required this.state,
  });

  Map<String, dynamic> toJson() {
    return {
      'documentNumber': documentNumber,
      'fullName': fullName,
      'emailId': emailId,
      'mobileNumber': mobileNumber,
      'address1': address1,
      'address2': address2,
      'postCode': postCode,
      'cityName': cityName,
      'state': state,
    };
  }

  factory CustomerModel.fromJson(Map<String, dynamic> json) {
    return CustomerModel(
      documentNumber: json['documentNumber'],
      fullName: json['fullName'],
      emailId: json['emailId'],
      mobileNumber: json['mobileNumber'],
      address1: json['address1'],
      address2: json['address2'],
      postCode: json['postCode'],
      cityName: json['cityName'],
      state: json['state'],
    );
  }
}
