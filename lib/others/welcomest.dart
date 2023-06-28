import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import 'package:prarambh_demo_1/pages/startup_homepage.dart';
import 'package:provider/provider.dart';

import '../database/startupConnect.dart';
import '../models/roles.dart';
import '../models/user.dart';

class WelcomeStartup extends StatelessWidget {
  const WelcomeStartup({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Startup startup = Startup();
    final user = Provider.of<CurrentUser?>(context);

    Future<void> addRoles() {
      return startup.roles.add(RolesModel(
        userId: user!.uid,
        isInvestor: false,
      ));
    }

    return Scaffold(
      body: Container(
        width: double.infinity,
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            colors: [Colors.orange, Colors.blue, Colors.yellow],
          ),
        ),
        child: Column(
          mainAxisSize: MainAxisSize.max,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              width: 120,
              height: 120,
              decoration: BoxDecoration(
                color: Colors.white,
                shape: BoxShape.circle,
              ),
              child: Padding(
                padding: EdgeInsetsDirectional.fromSTEB(8, 8, 8, 8),
                child: Image.asset(
                  'assets/rocketbg.png',
                  width: 180,
                  height: 180,
                  fit: BoxFit.cover,
                ),
              ),
            ),
            Padding(
              padding: EdgeInsetsDirectional.fromSTEB(0, 44, 0, 0),
              child: Text(
                'Welcome!',
                style: GoogleFonts.satisfy(
                    fontSize: 40.0, fontWeight: FontWeight.bold),
              ),
            ),
            Padding(
              padding: EdgeInsetsDirectional.fromSTEB(44, 8, 44, 0),
              child: Text(
                'Thanks for joining! Get started on your journey and showcase your startup on this platform!',
                textAlign: TextAlign.center,
                style: GoogleFonts.satisfy(
                  fontSize: 20.0,
                ),
              ),
            ),
            SizedBox(
              height: MediaQuery.of(context).size.height / 4,
            ),
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                  primary: Colors.white,
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(30.0)),
                  minimumSize: const Size(150, 50)),
              onPressed: () async {
                await addRoles();
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => const StarupsHomepageWidget()));
              },
              child: const Text(
                "Get started -->",
                style: TextStyle(fontSize: 20.0, color: Colors.black),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
