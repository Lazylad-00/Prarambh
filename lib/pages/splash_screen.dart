import 'dart:async';

import 'package:google_fonts/google_fonts.dart';
import 'package:prarambh_demo_1/authentication/investor%20auth/register.dart';
import 'package:prarambh_demo_1/authentication/startup%20auth/startupRegister.dart';
import 'package:prarambh_demo_1/others/constants.dart';
import 'package:flutter/material.dart';

import 'package:prarambh_demo_1/pages/investor_homepage.dart';
import 'package:prarambh_demo_1/pages/no_internet.dart';
import 'package:prarambh_demo_1/pages/startup_homepage.dart';

import 'package:provider/provider.dart';

import '../models/user.dart';
import '../others/connectivity.dart';

class SlashScreenWidget extends StatefulWidget {
  const SlashScreenWidget({Key? key}) : super(key: key);

  @override
  _SlashScreenWidgetState createState() => _SlashScreenWidgetState();
}

class _SlashScreenWidgetState extends State<SlashScreenWidget> {
  //CurrentUser currentUser = CurrentUser();

  @override
  void initState() {
    super.initState();
    Provider.of<ConnectivityProvider>(context, listen: false).startMonitoring();
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<ConnectivityProvider>(builder: (context, model, child) {
      if (model.isOnline != null) {
        return model.isOnline!
            ? Scaffold(
                backgroundColor: primaryBackground,
                appBar: AppBar(
                  backgroundColor: Color(0xFF010004),
                  title: Text(
                    'Prarambh',
                    style: GoogleFonts.satisfy(
                      color: Colors.white,
                      fontSize: 30,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  actions: [],
                  centerTitle: false,
                  elevation: 2,
                ),
                body: SafeArea(
                  child: Padding(
                    padding: const EdgeInsetsDirectional.fromSTEB(5, 5, 5, 5),
                    child: Column(
                      mainAxisSize: MainAxisSize.max,
                      children: [
                        Expanded(
                          child: Container(
                            width: double.infinity,
                            height: 500,
                            child: Stack(
                              children: [
                                Padding(
                                  padding: EdgeInsetsDirectional.fromSTEB(
                                      0, 0, 0, 50),
                                  child: Column(
                                    mainAxisSize: MainAxisSize.max,
                                    children: [
                                      Spacer(),
                                      Container(
                                        width: 250,
                                        height: 250,
                                        decoration: const BoxDecoration(
                                          color: secondaryBackground,
                                          shape: BoxShape.circle,
                                        ),
                                        child: const Image(
                                          image:
                                              AssetImage("assets/rocketbg.png"),
                                          width: 100,
                                          height: 200,
                                          fit: BoxFit.cover,
                                        ),
                                      ),
                                      Text(
                                        'Prarambh',
                                        textAlign: TextAlign.center,
                                        style: GoogleFonts.carterOne(
                                          color:
                                              Color.fromARGB(255, 16, 16, 16),
                                          fontSize: 50,
                                          fontWeight: FontWeight.w800,
                                        ),
                                      ),
                                      Padding(
                                        padding: EdgeInsetsDirectional.fromSTEB(
                                            5, 5, 5, 5),
                                        child: Text(
                                          'User-friendly platform to establish relation between investor and early startups and ease the process of investing and growing business.\n',
                                          textAlign: TextAlign.center,
                                          style: GoogleFonts.satisfy(
                                            color: Colors.grey[700],
                                            fontSize: 26,
                                          ),
                                        ),
                                      ),
                                      const Spacer(),
                                      Container(
                                        width:
                                            MediaQuery.of(context).size.width,
                                        height: 100,
                                        decoration: BoxDecoration(
                                          borderRadius:
                                              BorderRadius.circular(30.0),
                                          color: secondaryBackground,
                                        ),
                                        child: Row(
                                          mainAxisSize: MainAxisSize.max,
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceAround,
                                          children: [
                                            ElevatedButton(
                                              onPressed: () {
                                                Navigator.push(
                                                    context,
                                                    MaterialPageRoute(
                                                        builder: (context) =>
                                                            RegistrationWidget()));
                                                // if (_user == null) {
                                                //   print("No User");
                                                //   Navigator.push(
                                                //     context,
                                                //     MaterialPageRoute(
                                                //         builder: (context) =>
                                                //             RegistrationWidget()),
                                                //   );
                                                // } else {
                                                //   const HomepageInvestorWidget();
                                                //   print("User");
                                                // }
                                              },
                                              style: ElevatedButton.styleFrom(
                                                elevation: 8.0,
                                                primary: Colors.black,
                                                shape: RoundedRectangleBorder(
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            32.0)),
                                                minimumSize: Size(150, 60),
                                              ),
                                              child: Text(
                                                "Investor",
                                                style: GoogleFonts.carterOne(
                                                  fontSize: 19,
                                                  color: Colors.white,
                                                ),
                                              ),
                                            ),
                                            ElevatedButton(
                                              onPressed: () {
                                                Navigator.push(
                                                    context,
                                                    MaterialPageRoute(
                                                        builder: (context) =>
                                                            StartupRegistrationWidget()));
                                              },
                                              style: ElevatedButton.styleFrom(
                                                  elevation: 8.0,
                                                  primary: Colors.black,
                                                  shape: RoundedRectangleBorder(
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              30.0)),
                                                  minimumSize: Size(150, 60)),
                                              child: Text(
                                                "Startup",
                                                style: GoogleFonts.carterOne(
                                                  fontSize: 19,
                                                  color: Colors.white,
                                                ),
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                      Spacer(),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              )
            : const NoInternet();
      }
      return const Center(
        child: CircularProgressIndicator(),
      );
    });
  }
}
