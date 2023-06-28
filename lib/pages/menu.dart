import 'package:cached_network_image/cached_network_image.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:prarambh_demo_1/authentication/auth_method.dart';
import 'package:prarambh_demo_1/pages/edu.dart';
import 'package:prarambh_demo_1/pages/no_internet.dart';
import 'package:prarambh_demo_1/pages/startup_profile.dart';
import 'package:provider/provider.dart';

import '../models/startupModel.dart';
import '../models/user.dart';
import '../others/connectivity.dart';
import '../others/constants.dart';

class MenuWidget extends StatefulWidget {
  MenuWidget({
    Key? key,
  }) : super(key: key);

  @override
  _MenuWidgetState createState() => _MenuWidgetState();
}

class _MenuWidgetState extends State<MenuWidget> {
  AuthService auth = AuthService();
  @override
  Widget build(BuildContext context) {
    final user = Provider.of<CurrentUser?>(context);

    final Query<StartupModel> currentStartup = FirebaseFirestore.instance
        .collection('Startups')
        .where('uid', isEqualTo: user!.uid)
        .withConverter<StartupModel>(
          fromFirestore: (snapshots, _) =>
              StartupModel.fromJson(snapshots.data()!),
          toFirestore: (userModel, _) => userModel.toJson(),
        );

    return Consumer<ConnectivityProvider>(builder: (context, model, child) {
      if (model.isOnline != null) {
        return model.isOnline!
            ? StreamBuilder<QuerySnapshot<StartupModel>>(
                stream: currentStartup.snapshots(),
                builder: (context, snapshot) {
                  if (snapshot.hasError) {
                    return Center(
                      child: Text(snapshot.error.toString()),
                    );
                  }

                  if (!snapshot.hasData) {
                    return const Center(child: CircularProgressIndicator());
                  }

                  final data = snapshot.requireData;

                  return Scaffold(
                    backgroundColor: primaryBackground,
                    appBar: AppBar(
                      backgroundColor: primaryText,
                      automaticallyImplyLeading: false,
                      leading: IconButton(
                        icon: const Icon(
                          Icons.arrow_left_rounded,
                          color: secondaryBackground,
                          size: 50,
                        ),
                        onPressed: () {
                          Navigator.pop(context);
                        },
                      ),
                      title: Text(
                        'Menu',
                        style: GoogleFonts.carterOne(fontSize: 18),
                      ),
                      centerTitle: true,
                      elevation: 0,
                    ),
                    body: SafeArea(
                      child: Column(
                        mainAxisSize: MainAxisSize.max,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Padding(
                            padding: EdgeInsetsDirectional.fromSTEB(0, 1, 0, 0),
                            child: Container(
                              width: double.infinity,
                              decoration: const BoxDecoration(
                                color: secondaryBackground,
                                boxShadow: [
                                  BoxShadow(
                                    blurRadius: 0,
                                    color: Colors.black,
                                    offset: Offset(0, 1),
                                  )
                                ],
                              ),
                              child: Padding(
                                padding: EdgeInsetsDirectional.fromSTEB(
                                    16, 8, 16, 8),
                                child: Row(
                                  mainAxisSize: MainAxisSize.max,
                                  children: [],
                                ),
                              ),
                            ),
                          ),
                          Padding(
                            padding:
                                EdgeInsetsDirectional.fromSTEB(16, 16, 0, 0),
                            child: Text(
                              'Account',
                              style: GoogleFonts.carterOne(
                                fontSize: 15,
                              ),
                            ),
                          ),
                          Padding(
                            padding:
                                EdgeInsetsDirectional.fromSTEB(16, 12, 16, 0),
                            child: Container(
                              width: double.infinity,
                              height: 60,
                              decoration: BoxDecoration(
                                color: secondaryBackground,
                                boxShadow: [
                                  BoxShadow(
                                    blurRadius: 5,
                                    color: Color(0x3416202A),
                                    offset: Offset(0, 2),
                                  )
                                ],
                                borderRadius: BorderRadius.circular(12),
                                shape: BoxShape.rectangle,
                              ),
                              child: Padding(
                                padding:
                                    EdgeInsetsDirectional.fromSTEB(8, 8, 8, 8),
                                child: Row(
                                  mainAxisSize: MainAxisSize.max,
                                  children: [
                                    Icon(
                                      Icons.account_circle_outlined,
                                      color: secondaryText,
                                      size: 24,
                                    ),
                                    Padding(
                                      padding: EdgeInsetsDirectional.fromSTEB(
                                          12, 0, 0, 0),
                                      child: Text(
                                        'Edit Profile',
                                        style: GoogleFonts.carterOne(
                                          fontSize: 12,
                                        ),
                                      ),
                                    ),
                                    Expanded(
                                      child: Align(
                                        alignment: AlignmentDirectional(0.9, 0),
                                        child: IconButton(
                                          icon: Icon(
                                            Icons.arrow_forward_ios,
                                            size: 18,
                                          ),
                                          color: secondaryText,
                                          onPressed: () {
                                            Navigator.push(
                                                context,
                                                MaterialPageRoute(
                                                    builder: ((context) =>
                                                        StartupRegistrationWidget())));
                                          },
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ),
                          Padding(
                            padding:
                                EdgeInsetsDirectional.fromSTEB(16, 16, 0, 0),
                            child: Text(
                              'General',
                              style: GoogleFonts.carterOne(
                                fontSize: 15,
                              ),
                            ),
                          ),
                          Padding(
                            padding:
                                EdgeInsetsDirectional.fromSTEB(16, 12, 16, 0),
                            child: Container(
                              width: double.infinity,
                              height: 60,
                              decoration: BoxDecoration(
                                color: secondaryBackground,
                                boxShadow: [
                                  BoxShadow(
                                    blurRadius: 5,
                                    color: Color(0x3416202A),
                                    offset: Offset(0, 2),
                                  )
                                ],
                                borderRadius: BorderRadius.circular(12),
                                shape: BoxShape.rectangle,
                              ),
                              child: Padding(
                                padding:
                                    EdgeInsetsDirectional.fromSTEB(8, 8, 8, 8),
                                child: Row(
                                  mainAxisSize: MainAxisSize.max,
                                  children: [
                                    Icon(
                                      Icons.help_outline_rounded,
                                      color: secondaryText,
                                      size: 24,
                                    ),
                                    Padding(
                                      padding: EdgeInsetsDirectional.fromSTEB(
                                          12, 0, 0, 0),
                                      child: Text(
                                        'Info Center',
                                        style: GoogleFonts.carterOne(
                                          fontSize: 12,
                                        ),
                                      ),
                                    ),
                                    Expanded(
                                      child: Align(
                                        alignment: AlignmentDirectional(0.9, 0),
                                        child: IconButton(
                                          onPressed: () {
                                            Navigator.push(
                                                context,
                                                MaterialPageRoute(
                                                    builder: ((context) =>
                                                        const EducationalPlatform())));
                                          },
                                          icon: Icon(
                                            Icons.arrow_forward_ios,
                                            size: 18,
                                          ),
                                          color: secondaryText,
                                        ),
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
                  );
                })
            : const NoInternet();
      }
      return const Center(
        child: CircularProgressIndicator(),
      );
    });
  }
}
