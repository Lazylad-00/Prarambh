import 'dart:convert';

List<StartupModel> userFromJson(String str) => List<StartupModel>.from(
    json.decode(str).map((x) => StartupModel.fromJson(x)));

String userToJson(List<StartupModel> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class StartupModel {
  StartupModel({
    required this.uid,
    required this.companyName,
    required this.registrationNo,
    this.email,
    this.contactNumber,
    this.mailingAddress,
    this.videoLink,
    required this.revenue,
    required this.equity,
    this.netIncome,
    this.grossMargin,
    this.revenueGrowth,
    required this.logoLink,
    required this.description,
    this.images,
    required this.founder,
    this.totalInvestment,
  });
  String? uid;
  String? companyName;
  String? registrationNo;
  String? email;
  int? contactNumber;
  String? mailingAddress;
  String? videoLink;
  double? revenue;
  double? equity;
  double? netIncome;
  double? grossMargin;
  double? revenueGrowth;
  String? logoLink;
  String? description;
  List<dynamic>? images;
  String? founder;
  num? totalInvestment;

  factory StartupModel.fromJson(Map<dynamic, dynamic> json) => StartupModel(
        uid: json["uid"],
        companyName: json["companyName"],
        registrationNo: json["registrationNo"],
        email: json["email"],
        contactNumber: json["contactNumber"],
        mailingAddress: json["mailingAddress"],
        videoLink: json["videoLink"],
        revenue: json["revenue"],
        equity: json["equity"],
        netIncome: json["netIncome"],
        grossMargin: json["grossMargin"],
        revenueGrowth: json["revenueGrowth"],
        logoLink: json["logoLink"],
        description: json["description"],
        images: json["images"],
        founder: json["founder"],
        totalInvestment: json["totalInvestment"],
      );

  Map<String, dynamic> toJson() => {
        "uid": uid,
        "companyName": companyName,
        "registrationNo": registrationNo,
        "email": email,
        "contactNumber": contactNumber,
        "mailingAddress": mailingAddress,
        "videoLink": videoLink,
        "revenue": revenue,
        "equity": equity,
        "netIncome": netIncome,
        "grossMargin": grossMargin,
        "revenueGrowth": revenueGrowth,
        "logoLink": logoLink,
        "description": description,
        "images": images,
        "founder": founder,
        "totalInvestment": totalInvestment,
      };
}
