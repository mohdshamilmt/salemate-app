// To parse this JSON data, do
//
//     final userData = userDataFromJson(jsonString);

import 'dart:convert';

UserData userDataFromJson(String str) => UserData.fromJson(json.decode(str));

String userDataToJson(UserData data) => json.encode(data.toJson());

class UserData {
  int? statusCode;
  Data? data;
  CustomerData? customerData;

  UserData({this.statusCode, this.data, this.customerData});

  factory UserData.fromJson(Map<String, dynamic> json) => UserData(
    statusCode: json["StatusCode"],
    data: json["data"] == null ? null : Data.fromJson(json["data"]),
    customerData: json["customer_data"] == null
        ? null
        : CustomerData.fromJson(json["customer_data"]),
  );

  Map<String, dynamic> toJson() => {
    "StatusCode": statusCode,
    "data": data?.toJson(),
    "customer_data": customerData?.toJson(),
  };
}

class CustomerData {
  DateTime? dateOfBirth;
  String? country;
  int? phone;
  String? state;
  dynamic city;
  String? address;
  String? photo;
  String? countryName;
  String? stateName;

  CustomerData({
    this.dateOfBirth,
    this.country,
    this.phone,
    this.state,
    this.city,
    this.address,
    this.photo,
    this.countryName,
    this.stateName,
  });

  factory CustomerData.fromJson(Map<String, dynamic> json) => CustomerData(
    dateOfBirth: json["DateOfBirth"] == null
        ? null
        : DateTime.parse(json["DateOfBirth"]),
    country: json["Country"],
    phone: json["Phone"],
    state: json["State"],
    city: json["City"],
    address: json["Address"],
    photo: json["photo"],
    countryName: json["CountryName"],
    stateName: json["StateName"],
  );

  Map<String, dynamic> toJson() => {
    "DateOfBirth":
        "${dateOfBirth!.year.toString().padLeft(4, '0')}-${dateOfBirth!.month.toString().padLeft(2, '0')}-${dateOfBirth!.day.toString().padLeft(2, '0')}",
    "Country": country,
    "Phone": phone,
    "State": state,
    "City": city,
    "Address": address,
    "photo": photo,
    "CountryName": countryName,
    "StateName": stateName,
  };
}

class Data {
  String? firstName;
  String? lastName;
  String? username;
  String? email;

  Data({this.firstName, this.lastName, this.username, this.email});

  factory Data.fromJson(Map<String, dynamic> json) => Data(
    firstName: json["first_name"],
    lastName: json["last_name"],
    username: json["username"],
    email: json["email"],
  );

  Map<String, dynamic> toJson() => {
    "first_name": firstName,
    "last_name": lastName,
    "username": username,
    "email": email,
  };
}
