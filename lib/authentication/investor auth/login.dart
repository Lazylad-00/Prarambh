import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:prarambh_demo_1/authentication/investor%20auth/register.dart';
import 'package:prarambh_demo_1/database/startupConnect.dart';
import 'package:prarambh_demo_1/others/loading.dart';
import 'package:prarambh_demo_1/pages/splash_screen.dart';
import 'package:provider/provider.dart';

import '../../models/user.dart';
import '../../others/constants.dart';

import '../../pages/investor_homepage.dart';
import '../../pages/startup_homepage.dart';
import '../auth_method.dart';

class LoginWidget extends StatefulWidget {
  LoginWidget({
    Key? key,
  }) : super(key: key);

  @override
  _LoginWidgetState createState() => _LoginWidgetState();
}

class _LoginWidgetState extends State<LoginWidget> {
  String email = '';
  String password = '';
  String error = '';
  bool loading = false;

  final AuthService _auth = AuthService();
  final _formkey = GlobalKey<FormState>();

  // void assignRole() {
  //   if (isInv == true) {
  //     Navigator.push(
  //         context,
  //         MaterialPageRoute(
  //             builder: (context) => const HomepageInvestorWidget()));
  //   } else {
  //     Navigator.push(
  //         context,
  //         MaterialPageRoute(
  //             builder: (context) => const StarupsHomepageWidget()));
  //   }
  // }

  @override
  Widget build(BuildContext context) {
    final user = Provider.of<CurrentUser?>(context);
    // checkInLog() {
    //   if (user!.isInvestor == true) {
    //     Navigator.push(context,
    //         MaterialPageRoute(builder: (context) => HomepageInvestorWidget()));
    //   } else {
    //     Navigator.push(context,
    //         MaterialPageRoute(builder: (context) => StarupsHomepageWidget()));
    //   }
    // }

    return loading
        ? const Loading()
        : Scaffold(
            backgroundColor: secondaryBackground,
            appBar: AppBar(
              backgroundColor: primaryText,
              leading: IconButton(
                icon: Icon(
                  Icons.arrow_left_rounded,
                  size: 50.0,
                ),
                onPressed: () {
                  Navigator.pop(context);
                },
              ),
              title: Text(
                'Prarambh',
                style: GoogleFonts.satisfy(
                  color: primaryBackground,
                  fontSize: 30,
                  fontWeight: FontWeight.bold,
                ),
              ),
              actions: [],
              centerTitle: true,
              elevation: 4,
            ),
            body: SingleChildScrollView(
              child: Column(
                mainAxisSize: MainAxisSize.max,
                children: [
                  Padding(
                    padding: EdgeInsetsDirectional.fromSTEB(20, 0, 20, 0),
                    child: Form(
                      key: _formkey,
                      child: Column(
                        mainAxisSize: MainAxisSize.max,
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Padding(
                            padding:
                                EdgeInsetsDirectional.fromSTEB(0, 10, 0, 0),
                            child: Text(
                              'Welcome Back!',
                              style: GoogleFonts.carterOne(
                                color: Color(0xFF0F1113),
                                fontSize: 30,
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                          ),
                          Padding(
                            padding: EdgeInsetsDirectional.fromSTEB(0, 4, 0, 0),
                            child: Text(
                              'Use the form below to access your account.',
                              style: TextStyle(
                                color: primaryText,
                              ),
                            ),
                          ),
                          Padding(
                            padding:
                                EdgeInsetsDirectional.fromSTEB(0, 16, 0, 0),
                            child: Row(
                              mainAxisSize: MainAxisSize.max,
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Expanded(
                                  child: Padding(
                                    padding: EdgeInsetsDirectional.fromSTEB(
                                        0, 16, 0, 0),
                                    child: TextFormField(
                                      keyboardType: TextInputType.emailAddress,
                                      onChanged: (value) {
                                        setState(() => email = value);
                                      },
                                      validator: (value) => value!.isEmpty
                                          ? "Enter valid email"
                                          : null,
                                      obscureText: false,
                                      decoration: InputDecoration(
                                        labelText: 'Email Address',
                                        labelStyle: const TextStyle(
                                          color: Color(0xFF57636C),
                                          fontSize: 14,
                                          fontWeight: FontWeight.normal,
                                        ),
                                        hintText: 'Enter your email here...',
                                        hintStyle: TextStyle(
                                          color: Color(0xFF57636C),
                                          fontSize: 14,
                                          fontWeight: FontWeight.normal,
                                        ),
                                        enabledBorder: OutlineInputBorder(
                                          borderSide: BorderSide(
                                            color: Colors.grey[700]!,
                                            width: 2,
                                          ),
                                          borderRadius:
                                              BorderRadius.circular(40),
                                        ),
                                        focusedBorder: OutlineInputBorder(
                                          borderSide: BorderSide(
                                            color: Color(0x00000000),
                                            width: 2,
                                          ),
                                          borderRadius:
                                              BorderRadius.circular(40),
                                        ),
                                        errorBorder: OutlineInputBorder(
                                          borderSide: BorderSide(
                                            color: Color(0x00000000),
                                            width: 2,
                                          ),
                                          borderRadius:
                                              BorderRadius.circular(40),
                                        ),
                                        focusedErrorBorder: OutlineInputBorder(
                                          borderSide: BorderSide(
                                            color: Color(0x00000000),
                                            width: 2,
                                          ),
                                          borderRadius:
                                              BorderRadius.circular(40),
                                        ),
                                        filled: true,
                                        fillColor: Colors.white,
                                        contentPadding:
                                            EdgeInsetsDirectional.fromSTEB(
                                                16, 24, 0, 24),
                                      ),
                                      style: TextStyle(
                                        color: Color(0xFF0F1113),
                                        fontSize: 14,
                                        fontWeight: FontWeight.normal,
                                      ),
                                      maxLines: null,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                          Padding(
                            padding:
                                EdgeInsetsDirectional.fromSTEB(0, 16, 0, 0),
                            child: Row(
                              mainAxisSize: MainAxisSize.max,
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Expanded(
                                  child: TextFormField(
                                    keyboardType: TextInputType.number,
                                    obscureText: false,
                                    onChanged: (value) {
                                      setState(() => password = value);
                                    },
                                    validator: (value) => value!.length < 8
                                        ? "length must be greater than or equal to 8"
                                        : null,
                                    decoration: InputDecoration(
                                      labelText: 'Password',
                                      labelStyle: TextStyle(
                                        color: Color(0xFF57636C),
                                        fontSize: 14,
                                        fontWeight: FontWeight.normal,
                                      ),
                                      hintText: 'Enter password here...',
                                      hintStyle: TextStyle(
                                        color: Color(0xFF57636C),
                                        fontSize: 14,
                                        fontWeight: FontWeight.normal,
                                      ),
                                      enabledBorder: OutlineInputBorder(
                                        borderSide: BorderSide(
                                          color: Colors.grey[700]!,
                                          width: 2,
                                        ),
                                        borderRadius: BorderRadius.circular(40),
                                      ),
                                      focusedBorder: OutlineInputBorder(
                                        borderSide: BorderSide(
                                          color: Color(0x00000000),
                                          width: 2,
                                        ),
                                        borderRadius: BorderRadius.circular(40),
                                      ),
                                      errorBorder: OutlineInputBorder(
                                        borderSide: BorderSide(
                                          color: Color(0x00000000),
                                          width: 2,
                                        ),
                                        borderRadius: BorderRadius.circular(40),
                                      ),
                                      focusedErrorBorder: OutlineInputBorder(
                                        borderSide: BorderSide(
                                          color: Color(0x00000000),
                                          width: 2,
                                        ),
                                        borderRadius: BorderRadius.circular(40),
                                      ),
                                      filled: true,
                                      fillColor: secondaryBackground,
                                      contentPadding:
                                          EdgeInsetsDirectional.fromSTEB(
                                              16, 24, 24, 24),
                                      suffixIcon: InkWell(
                                        onTap: () {},
                                        focusNode:
                                            FocusNode(skipTraversal: true),
                                        child: Icon(
                                          Icons.visibility_off_outlined,
                                          color: Color(0xFF57636C),
                                          size: 22,
                                        ),
                                      ),
                                    ),
                                    style: TextStyle(
                                      color: Color(0xFF0F1113),
                                      fontSize: 14,
                                      fontWeight: FontWeight.normal,
                                    ),
                                    maxLines: null,
                                  ),
                                ),
                              ],
                            ),
                          ),
                          Padding(
                            padding:
                                EdgeInsetsDirectional.fromSTEB(0, 24, 0, 0),
                            child: Row(
                              mainAxisSize: MainAxisSize.max,
                              mainAxisAlignment: MainAxisAlignment.end,
                              children: [
                                ElevatedButton(
                                  style: ElevatedButton.styleFrom(
                                      primary: Colors.blue[900],
                                      shape: RoundedRectangleBorder(
                                          borderRadius:
                                              BorderRadius.circular(30.0)),
                                      minimumSize: Size(150, 50)),
                                  onPressed: () async {
                                    if (_formkey.currentState!.validate()) {
                                      setState(() => loading = true);
                                      dynamic result =
                                          await _auth.signInUsingCredentials(
                                              email, password);
                                      Navigator.push(
                                          context,
                                          MaterialPageRoute(
                                              builder: (context) =>
                                                  HomepageInvestorWidget()));
                                      if (result == null) {
                                        setState(() {
                                          error = "Couldn't sign in.";
                                          loading = false;
                                        });
                                      }
                                    }
                                  },
                                  child: Text(
                                    "Log In",
                                    style: TextStyle(fontSize: 20.0),
                                  ),
                                ),
                              ],
                            ),
                          ),
                          Padding(
                            padding:
                                EdgeInsetsDirectional.fromSTEB(0, 24, 0, 12),
                            child: Row(
                              mainAxisSize: MainAxisSize.max,
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                AutoSizeText(
                                  'Use a social platform to continue',
                                  textAlign: TextAlign.center,
                                  style: TextStyle(
                                    color: Color(0xFF57636C),
                                    fontSize: 14,
                                    fontWeight: FontWeight.normal,
                                  ),
                                ),
                              ],
                            ),
                          ),
                          Padding(
                            padding: EdgeInsetsDirectional.fromSTEB(8, 8, 8, 8),
                            child: Row(
                              mainAxisSize: MainAxisSize.max,
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              children: [
                                ElevatedButton(
                                  onPressed: () async {
                                    // final provider =
                                    //     Provider.of<GoogleSignInProvider>(context,
                                    //         listen: false);

                                    // provider.googleLogin();
                                    // assignRole();
                                  },
                                  child: FaIcon(
                                    FontAwesomeIcons.google,
                                    color: Colors.white,
                                    size: 22,
                                  ),
                                  style: ElevatedButton.styleFrom(
                                    shape: CircleBorder(),
                                    padding: EdgeInsets.all(20),
                                    primary: Colors.black, // <-- Button color
                                    onPrimary: Colors.red, // <-- Splash color
                                  ),
                                ),
                                ElevatedButton(
                                  onPressed: () {},
                                  child: FaIcon(
                                    FontAwesomeIcons.facebookF,
                                    color: Colors.white,
                                    size: 22,
                                  ),
                                  style: ElevatedButton.styleFrom(
                                    shape: CircleBorder(),
                                    padding: EdgeInsets.all(20),
                                    primary: Colors.black, // <-- Button color
                                    onPrimary: Colors.red, // <-- Splash color
                                  ),
                                ),
                              ],
                            ),
                          ),
                          Padding(
                            padding:
                                EdgeInsetsDirectional.fromSTEB(0, 24, 0, 24),
                            child: Row(
                              mainAxisSize: MainAxisSize.max,
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Text(
                                  'Don\'t have an account?',
                                  style: TextStyle(
                                    fontFamily: 'Outfit',
                                    color: Color(0xFF0F1113),
                                    fontSize: 14,
                                    fontWeight: FontWeight.normal,
                                  ),
                                ),
                                TextButton(
                                  onPressed: () async {
                                    Navigator.pop(
                                      context,
                                      MaterialPageRoute(
                                          builder: (context) =>
                                              RegistrationWidget()),
                                    );
                                  },
                                  child: Text(
                                    "Create Account.",
                                    style: TextStyle(
                                        fontSize: 18, color: Colors.blue[900]),
                                  ),
                                ),
                              ],
                            ),
                          ),
                          Text(error),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
          );
  }
}
