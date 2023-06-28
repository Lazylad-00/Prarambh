import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:prarambh_demo_1/models/investorModel.dart';
import 'package:prarambh_demo_1/models/roles.dart';
import 'package:prarambh_demo_1/models/startupModel.dart';
import 'package:provider/provider.dart';

import '../models/FundingModel.dart';
import '../models/user.dart';

class Startup {
  final CollectionReference<StartupModel> startupInstance = FirebaseFirestore
      .instance
      .collection("Startups")
      .withConverter<StartupModel>(
        fromFirestore: (snapshots, _) =>
            StartupModel.fromJson(snapshots.data()!),
        toFirestore: (userModel, _) => userModel.toJson(),
      );

  final CollectionReference<FundingModel> fundingInstance =
      FirebaseFirestore.instance.collection("Funding").withConverter(
            fromFirestore: ((snapshots, _) =>
                FundingModel.fromJson(snapshots.data()!)),
            toFirestore: (userModel, _) => userModel.toJson(),
          );

  Future<void> addinvestAmount(String id, double amount) {
    return startupInstance
        .doc(id)
        .update({"totalInvestment": FieldValue.increment(amount)});
  }

  final Query<StartupModel> topStartups = FirebaseFirestore.instance
      .collection('Startups')
      .orderBy("totalInvestment", descending: true)
      .withConverter<StartupModel>(
        fromFirestore: (snapshots, _) =>
            StartupModel.fromJson(snapshots.data()!),
        toFirestore: (userModel, _) => userModel.toJson(),
      );

  final CollectionReference<RolesModel> roles = FirebaseFirestore.instance
      .collection("Users")
      .withConverter<RolesModel>(
        fromFirestore: (snapshots, _) => RolesModel.fromJson(snapshots.data()!),
        toFirestore: (userModel, _) => userModel.toJson(),
      );
}
