import 'dart:convert';

List<InvestorModel> userFromJson(String str) => List<InvestorModel>.from(
    json.decode(str).map((x) => InvestorModel.fromJson(x)));

String userToJson(List<InvestorModel> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class InvestorModel {
  InvestorModel({
    required this.uid,
    this.fundingTo,
    this.amount,
  });
  String? uid;
  String? fundingTo;
  double? amount;

  factory InvestorModel.fromJson(Map<dynamic, dynamic> json) => InvestorModel(
        uid: json["uid"],
        fundingTo: json["fundingTo"],
        amount: json["amount"],
      );

  Map<String, dynamic> toJson() => {
        "uid": uid,
        "fundingTo": fundingTo,
        "amount": amount,
      };
}
