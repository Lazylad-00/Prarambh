import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:expandable/expandable.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:prarambh_demo_1/authentication/auth_method.dart';
import 'package:prarambh_demo_1/database/startupConnect.dart';
import 'package:prarambh_demo_1/models/investorModel.dart';
import 'package:prarambh_demo_1/models/startupModel.dart';
import 'package:prarambh_demo_1/others/horizontalList.dart';
import 'package:prarambh_demo_1/pages/no_internet.dart';
import 'package:prarambh_demo_1/pages/startupdetails_page.dart';
import 'package:provider/provider.dart';

import '../others/connectivity.dart';

class HomepageInvestorWidget extends StatefulWidget {
  const HomepageInvestorWidget({Key? key}) : super(key: key);

  @override
  _HomepageInvestorWidgetState createState() => _HomepageInvestorWidgetState();
}

class _HomepageInvestorWidgetState extends State<HomepageInvestorWidget> {
  Startup startupData = Startup();
  AuthService auth = AuthService();

  // @override
  // void initState() {

  //   super.initState();
  // }

  @override
  Widget build(BuildContext context) {
    return Consumer<ConnectivityProvider>(builder: (context, model, child) {
      if (model.isOnline != null) {
        return model.isOnline!
            ? Scaffold(
                backgroundColor: Color(0xFFF1F4F8),
                body: StreamBuilder<QuerySnapshot<StartupModel>>(
                  stream: startupData.startupInstance.snapshots(),
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

                    return Column(
                      mainAxisSize: MainAxisSize.max,
                      children: [
                        Expanded(
                          child: Container(
                            height: 500,
                            child: Stack(
                              alignment: AlignmentDirectional(0, -1),
                              children: [
                                Align(
                                  alignment: AlignmentDirectional(0.05, -1),
                                  child: Image.asset(
                                    'assets/investorbg.jpg',
                                    width: double.infinity,
                                    height: 500,
                                    fit: BoxFit.fitWidth,
                                  ),
                                ),
                                Container(
                                  width: double.infinity,
                                  height: 500,
                                  decoration: BoxDecoration(
                                    color: Color(0x8D090F13),
                                  ),
                                ),
                                Align(
                                  alignment: AlignmentDirectional(0, 0),
                                  child: SingleChildScrollView(
                                    child: Column(
                                      mainAxisSize: MainAxisSize.max,
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Padding(
                                          padding:
                                              EdgeInsetsDirectional.fromSTEB(
                                                  16, 60, 16, 0),
                                          child: Row(
                                            mainAxisSize: MainAxisSize.max,
                                            children: [
                                              Expanded(
                                                child: TextFormField(
                                                  obscureText: false,
                                                  decoration: InputDecoration(
                                                    labelText: 'Find Startups',
                                                    labelStyle: const TextStyle(
                                                      color: Color(0xFF57636C),
                                                      fontSize: 14,
                                                      fontWeight:
                                                          FontWeight.normal,
                                                    ),
                                                    hintText:
                                                        "Tech,Business....",
                                                    enabledBorder:
                                                        OutlineInputBorder(
                                                      borderSide: BorderSide(
                                                        color:
                                                            Color(0x00000000),
                                                        width: 1,
                                                      ),
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              16),
                                                    ),
                                                    focusedErrorBorder:
                                                        OutlineInputBorder(
                                                      borderSide: BorderSide(
                                                        color:
                                                            Color(0x00000000),
                                                        width: 1,
                                                      ),
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              16),
                                                    ),
                                                    filled: true,
                                                    fillColor: Colors.white,
                                                    prefixIcon: Icon(
                                                      Icons.search,
                                                      color: Color(0xFF1D2429),
                                                      size: 16,
                                                    ),
                                                  ),
                                                  style: TextStyle(
                                                    color: Color(0xFF1D2429),
                                                    fontSize: 14,
                                                    fontWeight:
                                                        FontWeight.normal,
                                                  ),
                                                  maxLines: null,
                                                ),
                                              ),
                                              IconButton(
                                                  onPressed: () {
                                                    auth.signOut();
                                                  },
                                                  icon: const Icon(
                                                    Icons.logout_outlined,
                                                    size: 30.0,
                                                    color: Colors.white,
                                                  ))
                                            ],
                                          ),
                                        ),
                                        Padding(
                                          padding: const EdgeInsetsDirectional
                                              .fromSTEB(16, 24, 16, 44),
                                          child: Text(
                                            'Explore different and inspiring startups.',
                                            style: GoogleFonts.carterOne(
                                              color: Colors.white,
                                              fontSize: 32,
                                              fontWeight: FontWeight.normal,
                                            ),
                                          ),
                                        ),
                                        Padding(
                                          padding:
                                              EdgeInsetsDirectional.fromSTEB(
                                                  0, 32, 0, 0),
                                          child: Container(
                                            width: double.infinity,
                                            height: 700,
                                            decoration: BoxDecoration(
                                              color: Colors.white,
                                              borderRadius: BorderRadius.only(
                                                bottomLeft: Radius.circular(0),
                                                bottomRight: Radius.circular(0),
                                                topLeft: Radius.circular(16),
                                                topRight: Radius.circular(16),
                                              ),
                                            ),
                                            child: Padding(
                                              padding: EdgeInsetsDirectional
                                                  .fromSTEB(0, 8, 0, 16),
                                              child: SingleChildScrollView(
                                                child: Column(
                                                  mainAxisSize:
                                                      MainAxisSize.max,
                                                  crossAxisAlignment:
                                                      CrossAxisAlignment.start,
                                                  children: [
                                                    const Divider(
                                                      height: 8,
                                                      thickness: 4,
                                                      indent: 140,
                                                      endIndent: 140,
                                                      color: Color(0xFFE0E3E7),
                                                    ),
                                                    Padding(
                                                      padding:
                                                          EdgeInsetsDirectional
                                                              .fromSTEB(16, 16,
                                                                  16, 0),
                                                      child: Text(
                                                        'Top Startups on Prarambh',
                                                        style: GoogleFonts
                                                            .carterOne(
                                                          color:
                                                              Color(0xFF1D2429),
                                                          fontSize: 22,
                                                          fontWeight:
                                                              FontWeight.bold,
                                                        ),
                                                      ),
                                                    ),
                                                    Padding(
                                                      padding:
                                                          EdgeInsetsDirectional
                                                              .fromSTEB(
                                                                  16, 4, 16, 0),
                                                      child: Text(
                                                        'Top 05 startups having high funding on prarambh',
                                                        style: GoogleFonts
                                                            .carterOne(
                                                          color:
                                                              Color(0xFF57636C),
                                                          fontSize: 14,
                                                          fontWeight:
                                                              FontWeight.normal,
                                                        ),
                                                      ),
                                                    ),
                                                    Padding(
                                                      padding:
                                                          EdgeInsetsDirectional
                                                              .fromSTEB(
                                                                  0, 12, 0, 0),
                                                      child: Container(
                                                        width: double.infinity,
                                                        height: 200,
                                                        decoration:
                                                            BoxDecoration(
                                                          color: Colors.white,
                                                        ),
                                                        child:
                                                            const HorizontalList(),
                                                      ),
                                                    ),
                                                    Padding(
                                                      padding:
                                                          EdgeInsetsDirectional
                                                              .fromSTEB(16, 16,
                                                                  16, 0),
                                                      child: Text(
                                                        'Other Startups',
                                                        style: GoogleFonts
                                                            .carterOne(
                                                          color:
                                                              Color(0xFF1D2429),
                                                          fontSize: 22,
                                                          fontWeight:
                                                              FontWeight.bold,
                                                        ),
                                                      ),
                                                    ),
                                                    Padding(
                                                      padding:
                                                          EdgeInsetsDirectional
                                                              .fromSTEB(
                                                                  16, 4, 16, 0),
                                                      child: Text(
                                                        'Funded through Prarambh',
                                                        style: GoogleFonts
                                                            .carterOne(
                                                          color:
                                                              Color(0xFF57636C),
                                                          fontSize: 14,
                                                          fontWeight:
                                                              FontWeight.normal,
                                                        ),
                                                      ),
                                                    ),
                                                    Padding(
                                                      padding:
                                                          EdgeInsetsDirectional
                                                              .fromSTEB(
                                                                  0, 0, 0, 2),
                                                      child: ListView.builder(
                                                        itemCount: data.size,
                                                        itemBuilder:
                                                            (context, index) {
                                                          return Padding(
                                                            padding:
                                                                EdgeInsetsDirectional
                                                                    .fromSTEB(
                                                                        16,
                                                                        8,
                                                                        16,
                                                                        8),
                                                            child: Container(
                                                              width: 270,
                                                              decoration:
                                                                  BoxDecoration(
                                                                color: Colors
                                                                    .white,
                                                                boxShadow: [
                                                                  BoxShadow(
                                                                    blurRadius:
                                                                        8,
                                                                    color: Color(
                                                                        0x230F1113),
                                                                    offset:
                                                                        Offset(
                                                                            0,
                                                                            4),
                                                                  )
                                                                ],
                                                                borderRadius:
                                                                    BorderRadius
                                                                        .circular(
                                                                            12),
                                                              ),
                                                              child: Column(
                                                                mainAxisSize:
                                                                    MainAxisSize
                                                                        .min,
                                                                children: [
                                                                  Flexible(
                                                                    fit: FlexFit
                                                                        .loose,
                                                                    child:
                                                                        Container(
                                                                      decoration:
                                                                          BoxDecoration(
                                                                        borderRadius:
                                                                            BorderRadius.circular(12),
                                                                      ),
                                                                      child: Image
                                                                          .network(
                                                                        data.docs[index].data().logoLink ??
                                                                            'https://cdn4.iconfinder.com/data/icons/logos-3/189/drupal-1024.png',
                                                                        // width: double
                                                                        //     .infinity,
                                                                        fit: BoxFit
                                                                            .scaleDown,
                                                                      ),
                                                                    ),
                                                                  ),
                                                                  Padding(
                                                                    padding: EdgeInsetsDirectional
                                                                        .fromSTEB(
                                                                            16,
                                                                            12,
                                                                            16,
                                                                            12),
                                                                    child: Row(
                                                                      mainAxisSize:
                                                                          MainAxisSize
                                                                              .max,
                                                                      mainAxisAlignment:
                                                                          MainAxisAlignment
                                                                              .spaceBetween,
                                                                      children: [
                                                                        Column(
                                                                          mainAxisSize:
                                                                              MainAxisSize.max,
                                                                          crossAxisAlignment:
                                                                              CrossAxisAlignment.start,
                                                                          children: [
                                                                            Text(
                                                                              data.docs[index].data().companyName ?? "Company Name",
                                                                              style: GoogleFonts.carterOne(
                                                                                color: Color(0xFF1D2429),
                                                                                fontSize: 18,
                                                                                fontWeight: FontWeight.bold,
                                                                              ),
                                                                            ),
                                                                            Padding(
                                                                              padding: EdgeInsetsDirectional.fromSTEB(0, 8, 0, 0),
                                                                              child: Row(
                                                                                mainAxisSize: MainAxisSize.max,
                                                                                children: [
                                                                                  RatingBarIndicator(
                                                                                    itemBuilder: (context, index) => Icon(
                                                                                      Icons.radio_button_checked_rounded,
                                                                                      color: Color(0xFF1D2429),
                                                                                    ),
                                                                                    direction: Axis.horizontal,
                                                                                    rating: 4,
                                                                                    unratedColor: Color(0xFF57636C),
                                                                                    itemCount: 5,
                                                                                    itemSize: 16,
                                                                                  ),
                                                                                  Padding(
                                                                                    padding: EdgeInsetsDirectional.fromSTEB(8, 0, 0, 0),
                                                                                    child: Text(
                                                                                      '4.7',
                                                                                      style: GoogleFonts.carterOne(
                                                                                        color: Color(0xFF57636C),
                                                                                        fontSize: 14,
                                                                                        fontWeight: FontWeight.normal,
                                                                                      ),
                                                                                    ),
                                                                                  ),
                                                                                ],
                                                                              ),
                                                                            ),
                                                                          ],
                                                                        ),
                                                                        InkWell(
                                                                          onTap:
                                                                              () {
                                                                            Navigator.push(
                                                                                context,
                                                                                MaterialPageRoute(
                                                                                    builder: ((context) => StarupViewPageWidget(
                                                                                          uid: data.docs[index].data().uid,
                                                                                          logo: data.docs[index].data().logoLink ?? 'https://cdn4.iconfinder.com/data/icons/logos-3/189/drupal-1024.png',
                                                                                          desc: data.docs[index].data().description ?? "No Description",
                                                                                          companyName: data.docs[index].data().companyName ?? "Company Name",
                                                                                          founders: data.docs[index].data().founder ?? "No Founders added",
                                                                                          registration: data.docs[index].data().registrationNo ?? "Invalid registration Number",
                                                                                          equity: data.docs[index].data().equity ?? 0,
                                                                                          revenue: data.docs[index].data().revenue ?? 0,
                                                                                          //images: data.docs[index].data().images,
                                                                                          dataId: data.docs[index].id,
                                                                                          grossMargin: data.docs[index].data().grossMargin ?? 0,
                                                                                          video: data.docs[index].data().videoLink ?? "https://www.youtube.com/watch?v=7Mc3i8uUnFM",
                                                                                          email: data.docs[index].data().email ?? "No mailid found.",
                                                                                        ))));
                                                                          },
                                                                          child:
                                                                              Container(
                                                                            height:
                                                                                32,
                                                                            decoration:
                                                                                BoxDecoration(
                                                                              color: Color(0xFF1D2429),
                                                                              borderRadius: BorderRadius.circular(12),
                                                                            ),
                                                                            alignment:
                                                                                AlignmentDirectional(0, 0),
                                                                            child:
                                                                                Padding(
                                                                              padding: EdgeInsetsDirectional.fromSTEB(8, 0, 8, 0),
                                                                              child: Text(
                                                                                'View',
                                                                                style: GoogleFonts.carterOne(
                                                                                  color: Colors.white,
                                                                                  fontSize: 14,
                                                                                  fontWeight: FontWeight.normal,
                                                                                ),
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
                                                          );
                                                        },
                                                        padding:
                                                            EdgeInsets.zero,
                                                        primary: false,
                                                        shrinkWrap: true,
                                                        scrollDirection:
                                                            Axis.vertical,
                                                      ),
                                                    ),
                                                  ],
                                                ),
                                              ),
                                            ),
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
                      ],
                    );
                  },
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

// Search feature code //
// Widget search = StreamBuilder<QuerySnapshot<StartupModel>>(builder:);
// class Search extends SearchDelegate {


//   @override
//   List<Widget>? buildActions(BuildContext context) {
//     return <Widget>[
//       IconButton(
//           onPressed: () {
//             query = "";
//           },
//           icon: const Icon(Icons.clear))
//     ];
//   }

//   @override
//   Widget? buildLeading(BuildContext context) {
//     return IconButton(
//         onPressed: () {
//           close(context, null);
//         },
//         icon: const Icon(Icons.arrow_back));
//   }

//   @override
//   Widget buildResults(BuildContext context) {
//     // ignore: null_check_always_fails
//     return null!;
//   }

//   @override
//   Widget buildSuggestions(BuildContext context) {
//     final suggesionlist = query.isEmpty
//         ? locations
//         : locations
//             .where((element) => element.location.startsWith(query))
//             .toList();
//     return ListView.builder(
//       itemBuilder: (context, index) {
//         return Padding(
//           padding: const EdgeInsets.symmetric(vertical: 1.0, horizontal: 4.0),
//           child: Card(
//             child: ListTile(
//               onTap: () async {
//                 WorldTime instance = suggesionlist[index];
//                 await instance.getTime();

//                 Navigator.pushReplacementNamed(context, '/home', arguments: {
//                   "location": instance.location,
//                   "flag": instance.flag,
//                   "time": instance.time,
//                   "timephase": instance.timephase
//                 });
//               },
//               title: Text(suggesionlist[index].location),
//               leading: CircleAvatar(
//                 backgroundImage: NetworkImage(suggesionlist[index].flag),
//               ),
//             ),
//           ),
//         );
//       },
//       itemCount: suggesionlist.length,
//     );
//   }
// }
