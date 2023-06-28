import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:prarambh_demo_1/others/constants.dart';
import 'package:prarambh_demo_1/pages/no_internet.dart';
import 'package:provider/provider.dart';
import 'package:youtube_player_flutter/youtube_player_flutter.dart';

import '../others/connectivity.dart';

class EducationalPlatform extends StatefulWidget {
  const EducationalPlatform({Key? key}) : super(key: key);

  @override
  State<EducationalPlatform> createState() => _EducationalPlatformState();
}

class _EducationalPlatformState extends State<EducationalPlatform> {
  @override
  Widget build(BuildContext context) {
    return Consumer<ConnectivityProvider>(builder: (context, model, child) {
      if (model.isOnline != null) {
        return model.isOnline!
            ? Scaffold(
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
                    'Info Center',
                    style: GoogleFonts.carterOne(
                      color: primaryBackground,
                    ),
                  ),
                  centerTitle: true,
                  elevation: 0,
                ),
                body: ListView.builder(
                  itemCount: Videos.length,
                  itemBuilder: (context, index) {
                    return YoutubePlayerBuilder(
                        player: YoutubePlayer(
                          controller: YoutubePlayerController(
                            initialVideoId:
                                YoutubePlayer.convertUrlToId(Videos[index])!,
                            flags: const YoutubePlayerFlags(
                              autoPlay: false,
                            ),
                          ),
                          progressIndicatorColor: Colors.red,
                          progressColors: const ProgressBarColors(
                            backgroundColor: Colors.white,
                            playedColor: Colors.red,
                            handleColor: Colors.red,
                          ),
                        ),
                        builder: (context, player) {
                          return Column(
                            mainAxisSize: MainAxisSize.max,
                            children: [
                              Padding(
                                padding: EdgeInsetsDirectional.fromSTEB(
                                    16, 0, 16, 8),
                                child: Container(
                                  width: double.infinity,
                                  decoration: BoxDecoration(
                                    color: secondaryBackground,
                                    boxShadow: [
                                      BoxShadow(
                                        blurRadius: 3,
                                        color: Color(0x411D2429),
                                        offset: Offset(0, 1),
                                      )
                                    ],
                                    borderRadius: BorderRadius.circular(8),
                                  ),
                                  child: Padding(
                                    padding: EdgeInsetsDirectional.fromSTEB(
                                        4, 4, 4, 4),
                                    child: Column(
                                      mainAxisSize: MainAxisSize.max,
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Padding(
                                          padding:
                                              EdgeInsetsDirectional.fromSTEB(
                                                  0, 1, 1, 1),
                                          child: ClipRRect(
                                            borderRadius:
                                                BorderRadius.circular(6),
                                            child: player,
                                          ),
                                        ),
                                        Padding(
                                          padding:
                                              EdgeInsetsDirectional.fromSTEB(
                                                  16, 8, 0, 0),
                                          child: Text(Names[index],
                                              style: GoogleFonts.carterOne(
                                                fontSize: 15.0,
                                              )),
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                              ),
                              Padding(
                                padding: EdgeInsetsDirectional.fromSTEB(
                                    16, 0, 16, 8),
                                child: Container(
                                  width: double.infinity,
                                  decoration: BoxDecoration(
                                    color: secondaryBackground,
                                    boxShadow: [
                                      BoxShadow(
                                        blurRadius: 3,
                                        color: Color(0x411D2429),
                                        offset: Offset(0, 1),
                                      )
                                    ],
                                    borderRadius: BorderRadius.circular(8),
                                  ),
                                ),
                              ),
                            ],
                          );
                        });
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
