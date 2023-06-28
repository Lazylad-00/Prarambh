import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:prarambh_demo_1/models/roles.dart';
import 'package:prarambh_demo_1/pages/investor_homepage.dart';
import 'package:prarambh_demo_1/pages/splash_screen.dart';
import 'package:provider/provider.dart';

import '../models/FundingModel.dart';
import '../models/user.dart';
import '../pages/startup_homepage.dart';

class Wrapper extends StatefulWidget {
  const Wrapper({Key? key}) : super(key: key);

  @override
  State<Wrapper> createState() => _WrapperState();
}

class _WrapperState extends State<Wrapper> {
  @override
  Widget build(BuildContext context) {
    final user = Provider.of<CurrentUser?>(context);

    if (user == null) {
      return const SlashScreenWidget();
    } else {
      final Query<RolesModel> roleCheck = FirebaseFirestore.instance
          .collection('Users')
          .where('userId', isEqualTo: user.uid)
          .withConverter<RolesModel>(
            fromFirestore: (snapshots, _) =>
                RolesModel.fromJson(snapshots.data()!),
            toFirestore: (userModel, _) => userModel.toJson(),
          );

      return StreamBuilder<QuerySnapshot<RolesModel>>(
        stream: roleCheck.snapshots(),
        builder: (context, snapshot) {
          if (snapshot.hasError) {
            return Center(
              child: Text(snapshot.error.toString()),
            );
          }

          if (!snapshot.hasData) {
            return const Center(
                child: CircularProgressIndicator(
              color: Colors.transparent,
            ));
          }

          final data = snapshot.requireData;

          if (data.docs.isNotEmpty && data.docs[0].data().isInvestor == true) {
            return const HomepageInvestorWidget();
          } else if (data.docs.isNotEmpty &&
              data.docs[0].data().isInvestor == false) {
            return const StarupsHomepageWidget();
          } else {
            return const SlashScreenWidget();
          }
        },
      );
    }
  }
}
