import 'dart:io';

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:image_picker/image_picker.dart';
import 'package:prarambh_demo_1/authentication/auth_method.dart';
import 'package:prarambh_demo_1/database/startupConnect.dart';
import 'package:prarambh_demo_1/models/startupModel.dart';
import 'package:prarambh_demo_1/models/user.dart';
import 'package:prarambh_demo_1/pages/no_internet.dart';
import 'package:prarambh_demo_1/pages/startup_homepage.dart';
import 'package:provider/provider.dart';
import 'package:firebase_storage/firebase_storage.dart';
import '../others/connectivity.dart';
import '../others/constants.dart';

class StartupRegistrationWidget extends StatefulWidget {
  const StartupRegistrationWidget({Key? key}) : super(key: key);

  @override
  _StartupRegistrationWidgetState createState() =>
      _StartupRegistrationWidgetState();
}

class _StartupRegistrationWidgetState extends State<StartupRegistrationWidget> {
  TextEditingController nameController = TextEditingController();
  TextEditingController registration = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController contactController = TextEditingController();
  TextEditingController mailingController = TextEditingController();
  TextEditingController videoController = TextEditingController();
  TextEditingController revenueController = TextEditingController();
  TextEditingController equityController = TextEditingController();
  TextEditingController netController = TextEditingController();
  TextEditingController grossController = TextEditingController();
  TextEditingController reveGrowthController = TextEditingController();
  TextEditingController descController = TextEditingController();
  TextEditingController founderController = TextEditingController();

  @override
  void dispose() {
    nameController.dispose();
    registration.dispose();
    emailController.dispose();
    contactController.dispose();
    mailingController.dispose();
    videoController.dispose();
    revenueController.dispose();
    equityController.dispose();
    netController.dispose();
    grossController.dispose();
    reveGrowthController.dispose();
    descController.dispose();
    founderController.dispose();
    super.dispose();
  }

  Startup startup = Startup();

  void showAlert() {
    showDialog(
        context: context,
        builder: (BuildContext) {
          return AlertDialog(
            title: Text(
              "Enter the Link below.",
              style: GoogleFonts.carterOne(fontSize: 18),
            ),
            shape:
                RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
            content: Container(
              height: MediaQuery.of(context).size.height / 6,
              width: MediaQuery.of(context).size.width,
              child: Column(
                children: [
                  TextFormField(
                    decoration: inputDecor,
                  ),
                  IconButton(
                    onPressed: () {
                      Navigator.pop(context);
                    },
                    icon: Icon(
                      Icons.add_circle_rounded,
                      size: 50,
                    ),
                  )
                ],
              ),
            ),
          );
        });
  }

  void showDialogUtube() {
    showDialog(
        context: context,
        builder: (BuildContext) {
          return AlertDialog(
            title: Text(
              "Enter the Link below.",
              style: GoogleFonts.carterOne(fontSize: 18),
            ),
            shape:
                RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
            content: Container(
              height: MediaQuery.of(context).size.height / 6,
              width: MediaQuery.of(context).size.width,
              child: Column(
                children: [
                  TextFormField(
                    decoration: inputDecor.copyWith(
                        hintText: "Enter youtube video link only."),
                    controller: videoController,
                  ),
                  IconButton(
                    onPressed: () {},
                    icon: Icon(
                      Icons.add_circle_rounded,
                      size: 50,
                    ),
                  )
                ],
              ),
            ),
          );
        });
  }

  void showSaveDialog() {
    showDialog(
        context: context,
        builder: (BuildContext) {
          return AlertDialog(
            shape:
                RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
            content: Container(
              height: MediaQuery.of(context).size.height / 6,
              width: MediaQuery.of(context).size.width,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Spacer(),
                  Text(
                    "Data has been saved.",
                    style: GoogleFonts.carterOne(
                      fontSize: 18,
                    ),
                  ),
                  ElevatedButton(
                    onPressed: () {
                      Navigator.pop(context, true);
                    },
                    child: Text(
                      "OK",
                      style: GoogleFonts.carterOne(
                        fontSize: 15,
                      ),
                    ),
                  ),
                  Spacer(),
                ],
              ),
            ),
          );
        });
  }

  ImagePicker imagePicker = ImagePicker();
  late String imageUrl;
  String? image;

  void uploadLogo(String? filePath) async {
    String uniqueFileName = DateTime.now().millisecondsSinceEpoch.toString();
    Reference referenceRoot = FirebaseStorage.instance.ref();
    Reference referenceDirImages = referenceRoot.child('images');
    Reference referenceImageToUpload = referenceDirImages.child(uniqueFileName);
    try {
      //Store the file
      await referenceImageToUpload.putFile(File(filePath!));
      //Success: get the download URL
      image = await referenceImageToUpload.getDownloadURL();
    } catch (error) {
      //Some error occurred
    }
  }

  AuthService auth = AuthService();
  @override
  Widget build(BuildContext context) {
    final user = Provider.of<CurrentUser?>(context);
    Future<void> addUser() {
      return startup.startupInstance.add(StartupModel(
          companyName: nameController.text,
          registrationNo: registration.text,
          email: emailController.text,
          contactNumber: int.parse(contactController.text),
          mailingAddress: mailingController.text,
          videoLink: videoController.text,
          revenue: double.parse(revenueController.text),
          netIncome: double.parse(netController.text),
          revenueGrowth: double.parse(reveGrowthController.text),
          grossMargin: double.parse(grossController.text),
          equity: double.parse(equityController.text),
          uid: user!.uid,
          logoLink: image!,
          description: descController.text,
          founder: founderController.text,
          totalInvestment: 0.0));
    }

    return Consumer<ConnectivityProvider>(builder: (context, model, child) {
      if (model.isOnline != null) {
        return model.isOnline!
            ? Scaffold(
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
                    'Startup Profile',
                    style: GoogleFonts.satisfy(
                      color: secondaryBackground,
                      fontSize: 30,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  centerTitle: true,
                  elevation: 0,
                ),
                body: SafeArea(
                  child: Align(
                    alignment: AlignmentDirectional(0, 0),
                    child: Container(
                      width: double.infinity,
                      constraints: BoxConstraints(
                        maxWidth: 670,
                      ),
                      decoration: BoxDecoration(
                        color: secondaryBackground,
                      ),
                      child: Column(
                        mainAxisSize: MainAxisSize.max,
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Expanded(
                            child: Padding(
                              padding:
                                  EdgeInsetsDirectional.fromSTEB(12, 0, 12, 0),
                              child: SingleChildScrollView(
                                child: Column(
                                  mainAxisSize: MainAxisSize.max,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Padding(
                                      padding: EdgeInsetsDirectional.fromSTEB(
                                          10, 20, 10, 10),
                                      child: Text(
                                        'Add profile data of your startup/company.',
                                        textAlign: TextAlign.start,
                                        style: GoogleFonts.carterOne(
                                          fontWeight: FontWeight.normal,
                                        ),
                                      ),
                                    ),
                                    Padding(
                                      padding: EdgeInsetsDirectional.fromSTEB(
                                          10, 10, 10, 10),
                                      child: TextFormField(
                                        controller: nameController,
                                        obscureText: false,
                                        validator: (value) => value!.isEmpty
                                            ? "Company Name is mandetory"
                                            : null,
                                        decoration: InputDecoration(
                                          labelText: 'Company Name',
                                          labelStyle: GoogleFonts.carterOne(
                                              fontSize: 16),
                                          focusedBorder: UnderlineInputBorder(
                                            borderSide: BorderSide(
                                              color: primary,
                                              width: 2,
                                            ),
                                          ),
                                          errorBorder: UnderlineInputBorder(
                                            borderSide: BorderSide(
                                              color: Colors.red,
                                              width: 2,
                                            ),
                                            borderRadius:
                                                const BorderRadius.only(
                                              topLeft: Radius.circular(4.0),
                                              topRight: Radius.circular(4.0),
                                            ),
                                          ),
                                          contentPadding:
                                              EdgeInsetsDirectional.fromSTEB(
                                                  10, 0, 0, 8),
                                        ),
                                      ),
                                    ),
                                    Padding(
                                      padding: EdgeInsetsDirectional.fromSTEB(
                                          10, 5, 10, 0),
                                      child: TextFormField(
                                        controller: registration,
                                        obscureText: false,
                                        validator: (value) => value!.isEmpty
                                            ? "Registration number is mandetory"
                                            : null,
                                        decoration: InputDecoration(
                                          labelText: 'Registration No.',
                                          labelStyle: GoogleFonts.carterOne(
                                            fontSize: 16,
                                          ),
                                          focusedBorder: UnderlineInputBorder(
                                            borderSide: BorderSide(
                                              color: primary,
                                              width: 2,
                                            ),
                                            borderRadius:
                                                const BorderRadius.only(
                                              topLeft: Radius.circular(4.0),
                                              topRight: Radius.circular(4.0),
                                            ),
                                          ),
                                          errorBorder: UnderlineInputBorder(
                                            borderSide: BorderSide(
                                              color: Colors.red,
                                              width: 2,
                                            ),
                                          ),
                                          contentPadding:
                                              EdgeInsetsDirectional.fromSTEB(
                                                  10, 0, 0, 8),
                                        ),
                                      ),
                                    ),
                                    Padding(
                                      padding: EdgeInsetsDirectional.fromSTEB(
                                          10, 5, 10, 0),
                                      child: TextFormField(
                                        controller: emailController,
                                        obscureText: false,
                                        validator: (value) => value!.isEmpty
                                            ? "Enter valid email"
                                            : null,
                                        decoration: InputDecoration(
                                          labelText: 'Email',
                                          labelStyle: GoogleFonts.carterOne(
                                            fontSize: 16,
                                          ),
                                          focusedBorder: UnderlineInputBorder(
                                            borderSide: BorderSide(
                                              color: primary,
                                              width: 2,
                                            ),
                                            borderRadius:
                                                const BorderRadius.only(
                                              topLeft: Radius.circular(4.0),
                                              topRight: Radius.circular(4.0),
                                            ),
                                          ),
                                          errorBorder: UnderlineInputBorder(
                                            borderSide: BorderSide(
                                              color: Colors.red,
                                              width: 2,
                                            ),
                                          ),
                                          contentPadding:
                                              EdgeInsetsDirectional.fromSTEB(
                                                  10, 0, 0, 8),
                                        ),
                                      ),
                                    ),
                                    Padding(
                                      padding: EdgeInsetsDirectional.fromSTEB(
                                          10, 5, 10, 0),
                                      child: TextFormField(
                                        controller: contactController,
                                        obscureText: false,
                                        decoration: InputDecoration(
                                          labelText: 'Contact Number.',
                                          labelStyle: GoogleFonts.carterOne(
                                            fontSize: 16,
                                          ),
                                          focusedBorder: UnderlineInputBorder(
                                            borderSide: BorderSide(
                                              color: primary,
                                              width: 2,
                                            ),
                                            borderRadius:
                                                const BorderRadius.only(
                                              topLeft: Radius.circular(4.0),
                                              topRight: Radius.circular(4.0),
                                            ),
                                          ),
                                          errorBorder: UnderlineInputBorder(
                                            borderSide: BorderSide(
                                              color: Colors.red,
                                              width: 2,
                                            ),
                                          ),
                                          contentPadding:
                                              EdgeInsetsDirectional.fromSTEB(
                                                  10, 0, 0, 8),
                                        ),
                                      ),
                                    ),
                                    Padding(
                                      padding: EdgeInsetsDirectional.fromSTEB(
                                          10, 5, 10, 0),
                                      child: TextFormField(
                                        controller: founderController,
                                        maxLines: 3,
                                        obscureText: false,
                                        decoration: InputDecoration(
                                          labelText: 'Founders.',
                                          labelStyle: GoogleFonts.carterOne(
                                            fontSize: 16,
                                          ),
                                          focusedBorder: UnderlineInputBorder(
                                            borderSide: BorderSide(
                                              color: primary,
                                              width: 2,
                                            ),
                                            borderRadius:
                                                const BorderRadius.only(
                                              topLeft: Radius.circular(4.0),
                                              topRight: Radius.circular(4.0),
                                            ),
                                          ),
                                          errorBorder: UnderlineInputBorder(
                                            borderSide: BorderSide(
                                              color: Colors.red,
                                              width: 2,
                                            ),
                                          ),
                                          contentPadding:
                                              EdgeInsetsDirectional.fromSTEB(
                                                  10, 0, 0, 8),
                                        ),
                                      ),
                                    ),
                                    Padding(
                                      padding: EdgeInsetsDirectional.fromSTEB(
                                          10, 5, 10, 0),
                                      child: TextFormField(
                                        controller: mailingController,
                                        maxLines: 3,
                                        obscureText: false,
                                        validator: (value) => value!.isEmpty
                                            ? "Mailing address is mandetory"
                                            : null,
                                        decoration: InputDecoration(
                                          labelText: 'Mailing Address',
                                          labelStyle: GoogleFonts.carterOne(
                                            fontSize: 16,
                                          ),
                                          focusedBorder: UnderlineInputBorder(
                                            borderSide: BorderSide(
                                              color: primary,
                                              width: 2,
                                            ),
                                            borderRadius:
                                                const BorderRadius.only(
                                              topLeft: Radius.circular(4.0),
                                              topRight: Radius.circular(4.0),
                                            ),
                                          ),
                                          errorBorder: UnderlineInputBorder(
                                            borderSide: BorderSide(
                                              color: Colors.red,
                                              width: 2,
                                            ),
                                          ),
                                          contentPadding:
                                              EdgeInsetsDirectional.fromSTEB(
                                                  10, 0, 0, 8),
                                        ),
                                      ),
                                    ),
                                    Padding(
                                      padding: EdgeInsetsDirectional.fromSTEB(
                                          10, 5, 10, 0),
                                      child: TextFormField(
                                        controller: descController,
                                        maxLines: 5,
                                        obscureText: false,
                                        decoration: InputDecoration(
                                          labelText: 'Description',
                                          labelStyle: GoogleFonts.carterOne(
                                            fontSize: 16,
                                          ),
                                          hintText:
                                              "add 10 to 20 words about your company.",
                                          focusedBorder: UnderlineInputBorder(
                                            borderSide: BorderSide(
                                              color: primary,
                                              width: 2,
                                            ),
                                            borderRadius:
                                                const BorderRadius.only(
                                              topLeft: Radius.circular(4.0),
                                              topRight: Radius.circular(4.0),
                                            ),
                                          ),
                                          errorBorder: UnderlineInputBorder(
                                            borderSide: BorderSide(
                                              color: Colors.red,
                                              width: 2,
                                            ),
                                          ),
                                          contentPadding:
                                              EdgeInsetsDirectional.fromSTEB(
                                                  10, 0, 0, 8),
                                        ),
                                      ),
                                    ),
                                    Padding(
                                      padding: EdgeInsetsDirectional.fromSTEB(
                                          10, 10, 10, 0),
                                      child: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.start,
                                        children: [
                                          Text(
                                            "Upload Logo : ",
                                            style: GoogleFonts.carterOne(
                                                fontSize: 16),
                                          ),
                                          Spacer(),
                                          ElevatedButton(
                                            onPressed: () async {
                                              XFile? file =
                                                  await imagePicker.pickImage(
                                                      source:
                                                          ImageSource.gallery);
                                              if (file != null &&
                                                  file.path.isNotEmpty) {
                                                uploadLogo(file.path);
                                              }
                                            },
                                            child: Text(
                                              "Gallery",
                                            ),
                                            style: ElevatedButton.styleFrom(
                                              primary: Color(0xFFE09025),
                                              shape: RoundedRectangleBorder(
                                                borderRadius:
                                                    BorderRadius.circular(10),
                                              ),
                                            ),
                                          ),
                                          Spacer(),
                                        ],
                                      ),
                                    ),
                                    Padding(
                                      padding: EdgeInsetsDirectional.fromSTEB(
                                          10, 20, 10, 10),
                                      child: Row(
                                        children: [
                                          Text(
                                            "Startup Video : ",
                                            style: GoogleFonts.carterOne(
                                                fontSize: 16),
                                          ),
                                          Spacer(),
                                          ElevatedButton(
                                            onPressed: () {
                                              showDialogUtube();
                                            },
                                            child: Text(
                                              "Add Link",
                                            ),
                                            style: ElevatedButton.styleFrom(
                                              primary: Color(0xFFE09025),
                                              shape: RoundedRectangleBorder(
                                                borderRadius:
                                                    BorderRadius.circular(10),
                                              ),
                                            ),
                                          ),
                                          Spacer(),
                                        ],
                                      ),
                                    ),
                                    Padding(
                                      padding: EdgeInsetsDirectional.fromSTEB(
                                          10, 5, 10, 0),
                                      child: TextFormField(
                                        controller: revenueController,
                                        obscureText: false,
                                        validator: (value) =>
                                            value!.runtimeType != double
                                                ? "Enter valid Info"
                                                : null,
                                        decoration: InputDecoration(
                                          labelText: 'Revenue',
                                          labelStyle: GoogleFonts.carterOne(
                                            fontSize: 16,
                                          ),
                                          focusedBorder: UnderlineInputBorder(
                                            borderSide: BorderSide(
                                              color: primary,
                                              width: 2,
                                            ),
                                            borderRadius:
                                                const BorderRadius.only(
                                              topLeft: Radius.circular(4.0),
                                              topRight: Radius.circular(4.0),
                                            ),
                                          ),
                                          errorBorder: UnderlineInputBorder(
                                            borderSide: BorderSide(
                                              color: Colors.red,
                                              width: 2,
                                            ),
                                          ),
                                          contentPadding:
                                              EdgeInsetsDirectional.fromSTEB(
                                                  10, 0, 0, 8),
                                        ),
                                      ),
                                    ),
                                    Padding(
                                      padding: EdgeInsetsDirectional.fromSTEB(
                                          10, 5, 10, 0),
                                      child: TextFormField(
                                        controller: equityController,
                                        obscureText: false,
                                        validator: (value) =>
                                            value!.runtimeType != double
                                                ? "Enter valid Info"
                                                : null,
                                        decoration: InputDecoration(
                                          labelText: 'Equity in %',
                                          labelStyle: GoogleFonts.carterOne(
                                            fontSize: 16,
                                          ),
                                          focusedBorder: UnderlineInputBorder(
                                            borderSide: BorderSide(
                                              color: primary,
                                              width: 2,
                                            ),
                                            borderRadius:
                                                const BorderRadius.only(
                                              topLeft: Radius.circular(4.0),
                                              topRight: Radius.circular(4.0),
                                            ),
                                          ),
                                          errorBorder: UnderlineInputBorder(
                                            borderSide: BorderSide(
                                              color: Colors.red,
                                              width: 2,
                                            ),
                                          ),
                                          contentPadding:
                                              EdgeInsetsDirectional.fromSTEB(
                                                  10, 0, 0, 8),
                                        ),
                                      ),
                                    ),
                                    Padding(
                                      padding: EdgeInsetsDirectional.fromSTEB(
                                          10, 5, 10, 0),
                                      child: TextFormField(
                                        controller: netController,
                                        obscureText: false,
                                        validator: (value) =>
                                            value!.runtimeType != double
                                                ? "Enter valid Info"
                                                : null,
                                        decoration: InputDecoration(
                                          labelText: 'Net Income',
                                          labelStyle: GoogleFonts.carterOne(
                                            fontSize: 16,
                                          ),
                                          focusedBorder: UnderlineInputBorder(
                                            borderSide: BorderSide(
                                              color: primary,
                                              width: 2,
                                            ),
                                            borderRadius:
                                                const BorderRadius.only(
                                              topLeft: Radius.circular(4.0),
                                              topRight: Radius.circular(4.0),
                                            ),
                                          ),
                                          errorBorder: UnderlineInputBorder(
                                            borderSide: BorderSide(
                                              color: Colors.red,
                                              width: 2,
                                            ),
                                          ),
                                          contentPadding:
                                              EdgeInsetsDirectional.fromSTEB(
                                                  10, 0, 0, 8),
                                        ),
                                      ),
                                    ),
                                    Padding(
                                      padding: EdgeInsetsDirectional.fromSTEB(
                                          10, 5, 10, 0),
                                      child: TextFormField(
                                        controller: grossController,
                                        obscureText: false,
                                        validator: (value) =>
                                            value!.runtimeType != double
                                                ? "Enter valid Info"
                                                : null,
                                        decoration: InputDecoration(
                                          labelText: 'Gross margin',
                                          labelStyle: GoogleFonts.carterOne(
                                            fontSize: 16,
                                          ),
                                          focusedBorder: UnderlineInputBorder(
                                            borderSide: BorderSide(
                                              color: primary,
                                              width: 2,
                                            ),
                                            borderRadius:
                                                const BorderRadius.only(
                                              topLeft: Radius.circular(4.0),
                                              topRight: Radius.circular(4.0),
                                            ),
                                          ),
                                          errorBorder: UnderlineInputBorder(
                                            borderSide: BorderSide(
                                              color: Colors.red,
                                              width: 2,
                                            ),
                                          ),
                                          contentPadding:
                                              EdgeInsetsDirectional.fromSTEB(
                                                  10, 0, 0, 8),
                                        ),
                                      ),
                                    ),
                                    Padding(
                                      padding: EdgeInsetsDirectional.fromSTEB(
                                          10, 5, 10, 0),
                                      child: TextFormField(
                                        controller: reveGrowthController,
                                        obscureText: false,
                                        validator: (value) =>
                                            value!.runtimeType != double
                                                ? "Enter valid Info"
                                                : null,
                                        decoration: InputDecoration(
                                          labelText: 'Revenue growth',
                                          labelStyle: GoogleFonts.carterOne(
                                            fontSize: 16,
                                          ),
                                          focusedBorder: UnderlineInputBorder(
                                            borderSide: BorderSide(
                                              color: primary,
                                              width: 2,
                                            ),
                                            borderRadius:
                                                const BorderRadius.only(
                                              topLeft: Radius.circular(4.0),
                                              topRight: Radius.circular(4.0),
                                            ),
                                          ),
                                          errorBorder: UnderlineInputBorder(
                                            borderSide: BorderSide(
                                              color: Colors.red,
                                              width: 2,
                                            ),
                                          ),
                                          contentPadding:
                                              EdgeInsetsDirectional.fromSTEB(
                                                  10, 0, 0, 8),
                                        ),
                                      ),
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.all(10.0),
                                      child: ElevatedButton(
                                        style: ElevatedButton.styleFrom(
                                            primary: primaryText,
                                            shape: RoundedRectangleBorder(
                                                borderRadius:
                                                    BorderRadius.circular(
                                                        30.0)),
                                            minimumSize: Size(150, 50)),
                                        onPressed: () async {
                                          await addUser();
                                          showSaveDialog();
                                        },
                                        child: Text(
                                          "Save Details",
                                          style: GoogleFonts.carterOne(
                                              fontSize: 16.0),
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          )
                        ],
                      ),
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
