import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:prarambh_demo_1/database/startupConnect.dart';

import '../models/startupModel.dart';
import '../pages/startupdetails_page.dart';

class HorizontalList extends StatefulWidget {
  const HorizontalList({Key? key}) : super(key: key);

  @override
  State<HorizontalList> createState() => _HorizontalListState();
}

class _HorizontalListState extends State<HorizontalList> {
  Startup startup = Startup();
  @override
  Widget build(BuildContext context) {
    return StreamBuilder<QuerySnapshot<StartupModel>>(
      stream: startup.topStartups.snapshots(),
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

        return ListView.builder(
          scrollDirection: Axis.horizontal,
          shrinkWrap: true,
          itemCount: 5,
          itemBuilder: (context, index) {
            return Padding(
              padding: EdgeInsetsDirectional.fromSTEB(16, 8, 0, 8),
              child: Container(
                width: 270,
                height: 100,
                decoration: BoxDecoration(
                  color: Colors.white,
                  boxShadow: [
                    BoxShadow(
                      blurRadius: 8,
                      color: Color(0x230F1113),
                      offset: Offset(0, 4),
                    )
                  ],
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Column(
                  mainAxisSize: MainAxisSize.max,
                  children: [
                    Expanded(
                      child: Container(
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(20.0),
                        ),
                        child: Image.network(
                          data.docs[index].data().logoLink.toString(),
                          width: double.infinity,
                          fit: BoxFit.scaleDown,
                        ),
                      ),
                    ),
                    Padding(
                      padding:
                          const EdgeInsetsDirectional.fromSTEB(16, 12, 16, 12),
                      child: Row(
                        mainAxisSize: MainAxisSize.max,
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Column(
                            mainAxisSize: MainAxisSize.max,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                data.docs[index].data().companyName.toString(),
                                style: GoogleFonts.carterOne(
                                  color: const Color(0xFF1D2429),
                                  fontSize: 16,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              Padding(
                                padding: const EdgeInsetsDirectional.fromSTEB(
                                    0, 4, 0, 0),
                                child: Row(
                                  mainAxisSize: MainAxisSize.max,
                                  children: [
                                    RatingBarIndicator(
                                      itemBuilder: (context, index) =>
                                          const Icon(
                                        Icons.radio_button_checked_rounded,
                                        color: Color(0xFF1D2429),
                                      ),
                                      direction: Axis.horizontal,
                                      rating: 4,
                                      unratedColor: Color(0xFF57636C),
                                      itemCount: 5,
                                      itemSize: 14,
                                    ),
                                    Padding(
                                      padding:
                                          const EdgeInsetsDirectional.fromSTEB(
                                              8, 0, 0, 0),
                                      child: Text(
                                        '4.7',
                                        style: GoogleFonts.carterOne(
                                          color: Color(0xFF57636C),
                                          fontSize: 12,
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
                            onTap: () {
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: ((context) =>
                                          StarupViewPageWidget(
                                            uid: data.docs[index].data().uid,
                                            logo: data.docs[index]
                                                    .data()
                                                    .logoLink ??
                                                'https://cdn4.iconfinder.com/data/icons/logos-3/189/drupal-1024.png',
                                            desc: data.docs[index]
                                                    .data()
                                                    .description ??
                                                "No Description",
                                            companyName: data.docs[index]
                                                    .data()
                                                    .companyName ??
                                                "Company Name",
                                            founders: data.docs[index]
                                                    .data()
                                                    .founder ??
                                                "No Founders added",
                                            registration: data.docs[index]
                                                    .data()
                                                    .registrationNo ??
                                                "Invalid registration Number",
                                            equity: data.docs[index]
                                                    .data()
                                                    .equity ??
                                                0,
                                            revenue: data.docs[index]
                                                    .data()
                                                    .revenue ??
                                                0,
                                            //images: data.docs[index].data().images,
                                            dataId: data.docs[index].id,
                                            grossMargin: data.docs[index]
                                                    .data()
                                                    .grossMargin ??
                                                0,
                                            video: data.docs[index]
                                                    .data()
                                                    .videoLink ??
                                                "https://www.youtube.com/watch?v=_NGBIQLNr7s",
                                            email:
                                                data.docs[index].data().email ??
                                                    "No mailid found.",
                                          ))));
                            },
                            child: Container(
                              height: 32,
                              decoration: BoxDecoration(
                                color: Color(0xFF1D2429),
                                borderRadius: BorderRadius.circular(12),
                              ),
                              alignment: AlignmentDirectional(0, 0),
                              child: Padding(
                                padding:
                                    EdgeInsetsDirectional.fromSTEB(8, 0, 8, 0),
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
        );
      },
    );
  }
}
