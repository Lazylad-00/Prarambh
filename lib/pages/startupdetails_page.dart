import 'dart:ffi';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:prarambh_demo_1/models/startupModel.dart';
import 'package:prarambh_demo_1/pages/no_internet.dart';
import 'package:provider/provider.dart';
import 'package:expandable/expandable.dart';
import '../database/startupConnect.dart';
import '../models/FundingModel.dart';
import '../models/user.dart';
import '../others/connectivity.dart';
import '../others/constants.dart';
import 'package:youtube_player_flutter/youtube_player_flutter.dart';

class StarupViewPageWidget extends StatefulWidget {
  String desc;
  String logo;
  String video;
  //List<dynamic>? images;
  String founders;
  double revenue;
  String registration;
  double equity;
  double grossMargin;
  String companyName;
  String email;
  String? uid;
  String dataId;

  StarupViewPageWidget({
    Key? key,
    required this.uid,
    required this.desc,
    required this.equity,
    required this.founders,
    required this.grossMargin,
    //required this.images,
    required this.logo,
    required this.registration,
    required this.revenue,
    required this.video,
    required this.companyName,
    required this.email,
    required this.dataId,
  }) : super(key: key);

  @override
  _StarupViewPageWidgetState createState() => _StarupViewPageWidgetState();
}

class _StarupViewPageWidgetState extends State<StarupViewPageWidget> {
  YoutubePlayerController? _controller;
  Startup startup = Startup();
  TextEditingController amountController = TextEditingController();
  TextEditingController nameController = TextEditingController();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _controller = YoutubePlayerController(
      initialVideoId: YoutubePlayer.convertUrlToId(widget.video)!,
      flags: const YoutubePlayerFlags(
        autoPlay: false,
      ),
    );
  }

  @override
  void dispose() {
    amountController.dispose();
    nameController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final user = Provider.of<CurrentUser?>(context);

    Future<void> addFundingDetails(TextEditingController controller) {
      return startup.fundingInstance.add(FundingModel(
          investmentPeriod: Timestamp.now(),
          investorName: nameController.text,
          uid: widget.uid,
          fundingTo: widget.companyName,
          amount: double.parse(
              controller.text.replaceAll(RegExp(r'[^0-9.]'), ''))));
    }

    void showFundDialog() {
      showDialog(
          context: context,
          builder: (BuildContext) {
            return AlertDialog(
              title: Text(
                widget.companyName,
                style: GoogleFonts.carterOne(fontSize: 18),
              ),
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10)),
              content: Container(
                height: MediaQuery.of(context).size.height / 4,
                width: MediaQuery.of(context).size.width,
                child: Column(
                  children: [
                    TextFormField(
                      decoration: inputDecor.copyWith(
                          labelText: "Name", hintText: "Enter your name here "),
                      controller: nameController,
                    ),
                    SizedBox(
                      height: 5.0,
                    ),
                    TextFormField(
                      decoration: inputDecor.copyWith(
                          labelText: "Amount",
                          hintText:
                              "Enter amount here only in numbers without ',' "),
                      controller: amountController,
                    ),
                    IconButton(
                      onPressed: () async {
                        await addFundingDetails(amountController);
                        startup.addinvestAmount(
                            widget.dataId, double.parse(amountController.text));
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

    return Consumer<ConnectivityProvider>(builder: (context, model, child) {
      if (model.isOnline != null) {
        return model.isOnline!
            ? YoutubePlayerBuilder(
                player: YoutubePlayer(
                  controller: _controller!,
                  progressIndicatorColor: Colors.red,
                  progressColors: ProgressBarColors(
                    backgroundColor: Colors.white,
                    playedColor: Colors.red,
                    handleColor: Colors.red,
                  ),
                ),
                builder: (context, player) {
                  return Scaffold(
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
                        widget.companyName,
                        style: GoogleFonts.carterOne(
                          color: primaryBackground,
                        ),
                      ),
                      centerTitle: true,
                      elevation: 0,
                    ),
                    body: SafeArea(
                      child: Column(
                        mainAxisSize: MainAxisSize.max,
                        children: [
                          Expanded(
                            child: SingleChildScrollView(
                              child: Column(
                                mainAxisSize: MainAxisSize.max,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Padding(
                                    padding: EdgeInsetsDirectional.fromSTEB(
                                        16, 0, 16, 0),
                                    child: Column(
                                      mainAxisSize: MainAxisSize.max,
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Padding(
                                          padding:
                                              EdgeInsetsDirectional.fromSTEB(
                                                  0, 16, 0, 0),
                                          child: Container(
                                              width: double.infinity,
                                              height: 230,
                                              decoration: BoxDecoration(
                                                color: Colors.white,
                                                boxShadow: [
                                                  BoxShadow(
                                                    blurRadius: 12,
                                                    color: Color(0x33000000),
                                                    offset: Offset(0, 5),
                                                  )
                                                ],
                                                borderRadius:
                                                    BorderRadius.circular(12),
                                              ),
                                              child: player),
                                        ),
                                      ],
                                    ),
                                  ),
                                  Padding(
                                    padding: EdgeInsetsDirectional.fromSTEB(
                                        16, 10, 0, 5),
                                    child: Row(
                                      children: [
                                        Text(
                                          "Email : ",
                                          style: GoogleFonts.carterOne(
                                            fontSize: 15,
                                          ),
                                        ),
                                        Text(widget.email)
                                      ],
                                    ),
                                  ),
                                  Padding(
                                    padding: EdgeInsetsDirectional.fromSTEB(
                                        16, 0, 16, 0),
                                    child: Container(
                                      width: double.infinity,
                                      color: secondaryBackground,
                                      child: ExpandableNotifier(
                                        initialExpanded: false,
                                        child: ExpandablePanel(
                                          header: Padding(
                                            padding:
                                                EdgeInsetsDirectional.fromSTEB(
                                                    0, 8, 0, 0),
                                            child: Text(
                                              'Description',
                                              style: GoogleFonts.carterOne(
                                                  fontSize: 15,
                                                  fontWeight:
                                                      FontWeight.normal),
                                            ),
                                          ),
                                          collapsed: Container(
                                            width: MediaQuery.of(context)
                                                .size
                                                .width,
                                            height: 50,
                                            decoration: BoxDecoration(
                                              color: secondaryBackground,
                                            ),
                                            child: Padding(
                                              padding: EdgeInsetsDirectional
                                                  .fromSTEB(0, 8, 0, 0),
                                              child: Text(
                                                  'Tap on this text to see description.',
                                                  style: TextStyle(
                                                    fontSize: 15,
                                                    fontWeight:
                                                        FontWeight.normal,
                                                  )),
                                            ),
                                          ),
                                          expanded: Column(
                                            mainAxisSize: MainAxisSize.max,
                                            children: [
                                              Padding(
                                                padding: EdgeInsetsDirectional
                                                    .fromSTEB(0, 8, 0, 12),
                                                child: Text(
                                                  widget.desc,
                                                  style: TextStyle(
                                                    fontSize: 16,
                                                  ),
                                                ),
                                              ),
                                              Image.network(
                                                widget.logo,
                                                width: 150,
                                                height: 150.0,
                                              ),
                                            ],
                                          ),
                                          theme: ExpandableThemeData(
                                            tapHeaderToExpand: true,
                                            tapBodyToExpand: true,
                                            tapBodyToCollapse: true,
                                            headerAlignment:
                                                ExpandablePanelHeaderAlignment
                                                    .center,
                                            hasIcon: false,
                                          ),
                                        ),
                                      ),
                                    ),
                                  ),
                                  Padding(
                                    padding: EdgeInsetsDirectional.fromSTEB(
                                        16, 12, 0, 0),
                                    child: Text(
                                      'Images',
                                      style: GoogleFonts.carterOne(
                                        fontSize: 18,
                                      ),
                                    ),
                                  ),
                                  Padding(
                                    padding: EdgeInsetsDirectional.fromSTEB(
                                        16, 12, 16, 12),
                                    child: Row(
                                      mainAxisSize: MainAxisSize.max,
                                      children: [
                                        Padding(
                                          padding:
                                              EdgeInsetsDirectional.fromSTEB(
                                                  2, 2, 12, 2),
                                          child: ClipRRect(
                                            borderRadius:
                                                BorderRadius.circular(12),
                                            child: Image.network(
                                              'https://images.unsplash.com/photo-1500648767791-00dcc994a43e?ixlib=rb-4.0.3&ixid=MnwxMjA3fDB8MHxzZWFyY2h8MjB8fHVzZXJ8ZW58MHx8MHx8&auto=format&fit=crop&w=800&q=60',
                                              width: 80,
                                              height: 80,
                                              fit: BoxFit.cover,
                                            ),
                                          ),
                                        ),
                                        Padding(
                                          padding:
                                              EdgeInsetsDirectional.fromSTEB(
                                                  2, 2, 12, 2),
                                          child: ClipRRect(
                                            borderRadius:
                                                BorderRadius.circular(12),
                                            child: Image.network(
                                              'https://images.unsplash.com/photo-1614436163996-25cee5f54290?ixlib=rb-4.0.3&ixid=MnwxMjA3fDB8MHxzZWFyY2h8MTR8fHVzZXJ8ZW58MHx8MHx8&auto=format&fit=crop&w=800&q=60',
                                              width: 80,
                                              height: 80,
                                              fit: BoxFit.cover,
                                            ),
                                          ),
                                        ),
                                        Padding(
                                          padding:
                                              EdgeInsetsDirectional.fromSTEB(
                                                  2, 2, 12, 2),
                                          child: ClipRRect(
                                            borderRadius:
                                                BorderRadius.circular(12),
                                            child: Image.network(
                                              'https://images.unsplash.com/photo-1508214751196-bcfd4ca60f91?ixlib=rb-4.0.3&ixid=MnwxMjA3fDB8MHxzZWFyY2h8MTB8fHVzZXJ8ZW58MHx8MHx8&auto=format&fit=crop&w=800&q=60',
                                              width: 80,
                                              height: 80,
                                              fit: BoxFit.cover,
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                  Padding(
                                    padding:
                                        const EdgeInsetsDirectional.fromSTEB(
                                            16, 0, 0, 0),
                                    child: Text(
                                      'Founder and Funding details.',
                                      style: GoogleFonts.carterOne(
                                        fontSize: 16,
                                      ),
                                    ),
                                  ),
                                  Padding(
                                    padding: EdgeInsetsDirectional.fromSTEB(
                                        16, 8, 0, 0),
                                    child: Text(
                                      "Registration id :- " +
                                          widget.registration,
                                      style: TextStyle(
                                        fontSize: 16,
                                      ),
                                    ),
                                  ),
                                  Padding(
                                    padding: EdgeInsetsDirectional.fromSTEB(
                                        16, 8, 0, 0),
                                    child: Text(
                                      'Founders :- ' + widget.founders,
                                      style: TextStyle(
                                        fontSize: 16,
                                      ),
                                    ),
                                  ),
                                  Padding(
                                    padding: EdgeInsetsDirectional.fromSTEB(
                                        16, 8, 0, 0),
                                    child: Text(
                                      'Revenue :- ' + widget.revenue.toString(),
                                      style: TextStyle(
                                        fontSize: 16,
                                      ),
                                    ),
                                  ),
                                  Padding(
                                    padding: EdgeInsetsDirectional.fromSTEB(
                                        16, 8, 0, 0),
                                    child: Text(
                                      'Gross margin :- ' +
                                          widget.grossMargin.toString(),
                                      style: TextStyle(
                                        fontSize: 16,
                                      ),
                                    ),
                                  ),
                                  Padding(
                                    padding: EdgeInsetsDirectional.fromSTEB(
                                        16, 8, 0, 0),
                                    child: Text(
                                      'Equity :- ' + widget.equity.toString(),
                                      style: TextStyle(
                                        fontSize: 16,
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                          Padding(
                            padding:
                                EdgeInsetsDirectional.fromSTEB(16, 0, 16, 12),
                            child: ElevatedButton(
                              onPressed: () async {
                                showFundDialog();
                              },
                              style: ElevatedButton.styleFrom(
                                  primary: Colors.black,
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(10.0),
                                  ),
                                  minimumSize: Size(double.infinity, 60)),
                              child: Text(
                                'FUND',
                                style: GoogleFonts.carterOne(
                                  color: primaryBackground,
                                  fontSize: 20,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ),
                          ),
                        ],
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
