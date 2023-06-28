import 'dart:convert';

import 'package:cloud_firestore/cloud_firestore.dart';

List<FundingModel> userFromJson(String str) => List<FundingModel>.from(
    json.decode(str).map((x) => FundingModel.fromJson(x)));

String userToJson(List<FundingModel> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class FundingModel {
  FundingModel({
    required this.uid,
    this.fundingTo,
    this.amount,
    this.investorName,
    this.investmentPeriod,
  });
  String? uid;
  String? fundingTo;
  double? amount;
  String? investorName;
  Timestamp? investmentPeriod;

  factory FundingModel.fromJson(Map<dynamic, dynamic> json) => FundingModel(
        uid: json["uid"],
        fundingTo: json["fundingTo"],
        amount: json["amount"],
        investorName: json["investorName"],
        investmentPeriod: json["investmentPeriod"],
      );

  Map<String, dynamic> toJson() => {
        "uid": uid,
        "fundingTo": fundingTo,
        "amount": amount,
        "investorName": investorName,
        "investmentPeriod": investmentPeriod,
      };
}
