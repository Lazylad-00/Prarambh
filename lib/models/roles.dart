import 'dart:convert';

import 'package:cloud_firestore/cloud_firestore.dart';

List<RolesModel> userFromJson(String str) =>
    List<RolesModel>.from(json.decode(str).map((x) => RolesModel.fromJson(x)));

String userToJson(List<RolesModel> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class RolesModel {
  RolesModel({
    required this.userId,
    required this.isInvestor,
  });
  String? userId;
  bool? isInvestor;

  factory RolesModel.fromJson(Map<dynamic, dynamic> json) =>
      RolesModel(userId: json["userId"], isInvestor: json['isInvestor']);

  Map<String, dynamic> toJson() => {
        "userId": userId,
        "isInvestor": isInvestor,
      };
}
