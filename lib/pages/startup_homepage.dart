import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';

import 'package:google_fonts/google_fonts.dart';
import 'package:percent_indicator/percent_indicator.dart';
import 'package:prarambh_demo_1/authentication/auth_method.dart';
import 'package:prarambh_demo_1/database/startupConnect.dart';
import 'package:prarambh_demo_1/models/FundingModel.dart';
import 'package:prarambh_demo_1/models/user.dart';
import 'package:prarambh_demo_1/others/chart.dart';
import 'package:prarambh_demo_1/pages/menu.dart';
import 'package:prarambh_demo_1/pages/no_internet.dart';
import 'package:prarambh_demo_1/pages/splash_screen.dart';
import 'package:provider/provider.dart';
import 'package:provider/single_child_widget.dart';

import '../models/startupModel.dart';
import '../others/connectivity.dart';
import '../others/constants.dart';

class StarupsHomepageWidget extends StatefulWidget {
  const StarupsHomepageWidget({
    Key? key,
  }) : super(key: key);

  @override
  _StarupsHomepageWidgetState createState() => _StarupsHomepageWidgetState();
}

class _StarupsHomepageWidgetState extends State<StarupsHomepageWidget> {
  Startup startup = Startup();
  String? tAmount;
  AuthService _auth = AuthService();

  @override
  Widget build(BuildContext context) {
    final user = Provider.of<CurrentUser?>(context);

    if (user == null) {
      return SlashScreenWidget();
    } else {
      final Query<FundingModel> currentStartupFund = FirebaseFirestore.instance
          .collection('Funding')
          .where('uid', isEqualTo: user.uid)
          .withConverter<FundingModel>(
            fromFirestore: (snapshots, _) =>
                FundingModel.fromJson(snapshots.data()!),
            toFirestore: (userModel, _) => userModel.toJson(),
          );

      return Consumer<ConnectivityProvider>(builder: (context, model, child) {
        if (model.isOnline != null) {
          return model.isOnline!
              ? StreamBuilder<QuerySnapshot<FundingModel>>(
                  stream: currentStartupFund.snapshots(),
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

                    String totalAmount() {
                      double amount = 0.0;
                      for (var i = 0; i < data.docs.length; i++) {
                        amount += data.docs[i].data().amount!.toDouble();
                      }

                      return amount.toString();
                    }

                    return Scaffold(
                      backgroundColor: primaryBackground,
                      appBar: AppBar(
                        backgroundColor: primaryText,
                        leading: IconButton(
                          icon: const Icon(Icons.menu),
                          onPressed: () {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => MenuWidget()));
                          },
                        ),
                        title: Text(
                          'Dashboard',
                          style: GoogleFonts.satisfy(
                            fontSize: 30,
                            color: primaryBackground,
                          ),
                        ),
                        actions: [
                          IconButton(
                            onPressed: () async {
                              await _auth.signOut();
                            },
                            icon: Icon(
                              Icons.logout_rounded,
                              size: 30.0,
                            ),
                          )
                        ],
                        centerTitle: false,
                        elevation: 0,
                      ),
                      body: SafeArea(
                        child: SingleChildScrollView(
                          child: Column(
                            mainAxisSize: MainAxisSize.max,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Container(
                                height: 160,
                                child: Stack(
                                  children: [
                                    Container(
                                      width: double.infinity,
                                      height: 100,
                                      decoration: const BoxDecoration(
                                        color: primaryText,
                                      ),
                                      child: Padding(
                                        padding: EdgeInsetsDirectional.fromSTEB(
                                            16, 0, 0, 0),
                                        child: Text(
                                          'Summary of your Startup',
                                          textAlign: TextAlign.start,
                                          style: GoogleFonts.carterOne(
                                            color: Color(0xB3FFFFFF),
                                          ),
                                        ),
                                      ),
                                    ),
                                    Padding(
                                      padding: EdgeInsetsDirectional.fromSTEB(
                                          0, 30, 0, 0),
                                      child: ListView(
                                        padding: EdgeInsets.zero,
                                        primary: false,
                                        shrinkWrap: true,
                                        scrollDirection: Axis.horizontal,
                                        children: [
                                          Padding(
                                            padding:
                                                EdgeInsetsDirectional.fromSTEB(
                                                    16, 0, 0, 12),
                                            child: Container(
                                              height: 120,
                                              decoration: BoxDecoration(
                                                color: secondaryBackground,
                                                boxShadow: [
                                                  BoxShadow(
                                                    blurRadius: 4,
                                                    color: Color(0x1F000000),
                                                    offset: Offset(0, 2),
                                                  )
                                                ],
                                                borderRadius:
                                                    BorderRadius.circular(8),
                                                border: Border.all(
                                                  color: primaryBackground,
                                                  width: 1,
                                                ),
                                              ),
                                              child: Padding(
                                                padding: EdgeInsetsDirectional
                                                    .fromSTEB(12, 0, 12, 0),
                                                child: Row(
                                                  mainAxisSize:
                                                      MainAxisSize.max,
                                                  children: [
                                                    Container(
                                                      width: 60,
                                                      height: 60,
                                                      decoration: BoxDecoration(
                                                        color:
                                                            primaryBackground,
                                                        shape: BoxShape.circle,
                                                      ),
                                                      alignment:
                                                          AlignmentDirectional(
                                                              0, 0),
                                                      child: Card(
                                                        clipBehavior: Clip
                                                            .antiAliasWithSaveLayer,
                                                        color:
                                                            Color(0xFFE09025),
                                                        shape:
                                                            RoundedRectangleBorder(
                                                          borderRadius:
                                                              BorderRadius
                                                                  .circular(40),
                                                        ),
                                                        child: Padding(
                                                          padding:
                                                              EdgeInsetsDirectional
                                                                  .fromSTEB(
                                                                      12,
                                                                      12,
                                                                      12,
                                                                      12),
                                                          child: Icon(
                                                            Icons
                                                                .group_outlined,
                                                            color:
                                                                primaryBackground,
                                                            size: 24,
                                                          ),
                                                        ),
                                                      ),
                                                    ),
                                                    Padding(
                                                      padding:
                                                          EdgeInsetsDirectional
                                                              .fromSTEB(12, 12,
                                                                  12, 12),
                                                      child: Column(
                                                        mainAxisSize:
                                                            MainAxisSize.max,
                                                        mainAxisAlignment:
                                                            MainAxisAlignment
                                                                .center,
                                                        crossAxisAlignment:
                                                            CrossAxisAlignment
                                                                .start,
                                                        children: [
                                                          Text('New Investors',
                                                              style: GoogleFonts
                                                                  .carterOne(
                                                                fontSize: 15,
                                                              )),
                                                          Padding(
                                                            padding:
                                                                EdgeInsetsDirectional
                                                                    .fromSTEB(
                                                                        0,
                                                                        8,
                                                                        0,
                                                                        0),
                                                            child: Text(
                                                                data.docs.length
                                                                    .toString(),
                                                                style: GoogleFonts
                                                                    .carterOne(
                                                                  fontSize: 15,
                                                                )),
                                                          ),
                                                        ],
                                                      ),
                                                    ),
                                                  ],
                                                ),
                                              ),
                                            ),
                                          ),
                                          Padding(
                                            padding:
                                                EdgeInsetsDirectional.fromSTEB(
                                                    16, 0, 16, 12),
                                            child: Container(
                                              height: 120,
                                              decoration: BoxDecoration(
                                                color: secondaryBackground,
                                                boxShadow: [
                                                  BoxShadow(
                                                    blurRadius: 4,
                                                    color: Color(0x1F000000),
                                                    offset: Offset(0, 2),
                                                  )
                                                ],
                                                borderRadius:
                                                    BorderRadius.circular(8),
                                                border: Border.all(
                                                  color: primaryBackground,
                                                  width: 1,
                                                ),
                                              ),
                                              child: Padding(
                                                padding: EdgeInsetsDirectional
                                                    .fromSTEB(12, 0, 12, 0),
                                                child: Row(
                                                  mainAxisSize:
                                                      MainAxisSize.max,
                                                  children: [
                                                    Container(
                                                      width: 60,
                                                      height: 60,
                                                      decoration: BoxDecoration(
                                                        color:
                                                            primaryBackground,
                                                        shape: BoxShape.circle,
                                                      ),
                                                      alignment:
                                                          AlignmentDirectional(
                                                              0, 0),
                                                      child: Card(
                                                        clipBehavior: Clip
                                                            .antiAliasWithSaveLayer,
                                                        color:
                                                            Color(0xFFE09025),
                                                        shape:
                                                            RoundedRectangleBorder(
                                                          borderRadius:
                                                              BorderRadius
                                                                  .circular(40),
                                                        ),
                                                        child: Padding(
                                                          padding:
                                                              EdgeInsetsDirectional
                                                                  .fromSTEB(
                                                                      12,
                                                                      12,
                                                                      12,
                                                                      12),
                                                          child: Icon(
                                                            Icons.contacts,
                                                            color:
                                                                primaryBackground,
                                                            size: 24,
                                                          ),
                                                        ),
                                                      ),
                                                    ),
                                                    Padding(
                                                      padding:
                                                          EdgeInsetsDirectional
                                                              .fromSTEB(12, 12,
                                                                  12, 12),
                                                      child: Column(
                                                        mainAxisSize:
                                                            MainAxisSize.max,
                                                        mainAxisAlignment:
                                                            MainAxisAlignment
                                                                .center,
                                                        crossAxisAlignment:
                                                            CrossAxisAlignment
                                                                .start,
                                                        children: [
                                                          Text(
                                                              'Total Investment',
                                                              style: GoogleFonts
                                                                  .carterOne(
                                                                fontSize: 15,
                                                              )),
                                                          Padding(
                                                            padding:
                                                                EdgeInsetsDirectional
                                                                    .fromSTEB(
                                                                        0,
                                                                        8,
                                                                        0,
                                                                        0),
                                                            child: Text(
                                                                totalAmount(),
                                                                style: GoogleFonts
                                                                    .carterOne(
                                                                  fontSize: 15,
                                                                )),
                                                          ),
                                                        ],
                                                      ),
                                                    ),
                                                  ],
                                                ),
                                              ),
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              Padding(
                                padding:
                                    EdgeInsetsDirectional.fromSTEB(16, 8, 0, 0),
                                child: Text('Funding stats and Investors',
                                    textAlign: TextAlign.start,
                                    style: GoogleFonts.carterOne(
                                      fontSize: 16,
                                    )),
                              ),
                              Padding(
                                  padding: EdgeInsetsDirectional.fromSTEB(
                                      16, 12, 16, 0),
                                  child: Chart(
                                    uid: user.uid,
                                  )),
                              Container(
                                height: 100,
                                child: ListView.builder(
                                  scrollDirection: Axis.horizontal,
                                  shrinkWrap: true,
                                  itemCount: data.size,
                                  itemBuilder: (context, index) {
                                    return Padding(
                                      padding: EdgeInsetsDirectional.fromSTEB(
                                          5, 5, 0, 2),
                                      child: Container(
                                        height: 100,
                                        width: 180,
                                        decoration: BoxDecoration(
                                          color: secondaryBackground,
                                          boxShadow: [
                                            BoxShadow(
                                              blurRadius: 4,
                                              color: Color(0x1F000000),
                                              offset: Offset(0, 2),
                                            )
                                          ],
                                          borderRadius:
                                              BorderRadius.circular(8),
                                          border: Border.all(
                                            color: primaryBackground,
                                            width: 1,
                                          ),
                                        ),
                                        child: Padding(
                                          padding:
                                              EdgeInsetsDirectional.fromSTEB(
                                                  0, 0, 0, 5),
                                          child: Column(
                                            mainAxisSize: MainAxisSize.max,
                                            crossAxisAlignment:
                                                CrossAxisAlignment.center,
                                            children: [
                                              Padding(
                                                padding: EdgeInsetsDirectional
                                                    .fromSTEB(12, 8, 16, 4),
                                                child: Row(
                                                  mainAxisSize:
                                                      MainAxisSize.max,
                                                  children: [
                                                    Padding(
                                                      padding:
                                                          EdgeInsetsDirectional
                                                              .fromSTEB(4, 12,
                                                                  12, 12),
                                                      child: Column(
                                                        mainAxisSize:
                                                            MainAxisSize.max,
                                                        mainAxisAlignment:
                                                            MainAxisAlignment
                                                                .center,
                                                        crossAxisAlignment:
                                                            CrossAxisAlignment
                                                                .start,
                                                        children: [
                                                          Text(
                                                              data.docs[index]
                                                                  .data()
                                                                  .investorName
                                                                  .toString(),
                                                              style: GoogleFonts
                                                                  .carterOne(
                                                                fontSize: 18.0,
                                                              )),
                                                          Padding(
                                                            padding:
                                                                EdgeInsetsDirectional
                                                                    .fromSTEB(
                                                                        0,
                                                                        4,
                                                                        0,
                                                                        0),
                                                            child: Text(
                                                              data.docs[index]
                                                                  .data()
                                                                  .amount
                                                                  .toString(),
                                                              style: GoogleFonts
                                                                  .carterOne(
                                                                fontSize: 12,
                                                              ),
                                                            ),
                                                          ),
                                                        ],
                                                      ),
                                                    ),
                                                    Container(
                                                      width: 60,
                                                      height: 60,
                                                      decoration: BoxDecoration(
                                                        color:
                                                            primaryBackground,
                                                        shape: BoxShape.circle,
                                                      ),
                                                      alignment:
                                                          AlignmentDirectional(
                                                              0, 0),
                                                      child: Card(
                                                        clipBehavior: Clip
                                                            .antiAliasWithSaveLayer,
                                                        color: Colors.white,
                                                        shape:
                                                            RoundedRectangleBorder(
                                                          borderRadius:
                                                              BorderRadius
                                                                  .circular(40),
                                                        ),
                                                        child: Padding(
                                                          padding:
                                                              EdgeInsetsDirectional
                                                                  .fromSTEB(
                                                                      12,
                                                                      12,
                                                                      12,
                                                                      12),
                                                          child: Icon(
                                                            Icons.person,
                                                            color: primaryText,
                                                            size: 24,
                                                          ),
                                                        ),
                                                      ),
                                                    ),
                                                  ],
                                                ),
                                              ),
                                            ],
                                          ),
                                        ),
                                      ),
                                    );
                                  },
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    );
                  },
                )
              : const NoInternet();
        }
        return const Center(
          child: CircularProgressIndicator(),
        );
      });
    }
  }
}
