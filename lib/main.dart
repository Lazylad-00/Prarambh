import 'package:flutter/material.dart';
import 'package:prarambh_demo_1/authentication/auth_method.dart';

import 'package:prarambh_demo_1/models/user.dart';
import 'package:prarambh_demo_1/others/chart.dart';
import 'package:prarambh_demo_1/others/welcome.dart';

import 'package:prarambh_demo_1/others/wrapper.dart';

import 'package:firebase_core/firebase_core.dart';

import 'package:provider/provider.dart';

import 'others/connectivity.dart';
import 'others/loading.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of our application.
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (context) => ConnectivityProvider(),
          child: const Loading(),
        )
      ],
      child: StreamProvider<CurrentUser?>.value(
        initialData: null,
        value: AuthService().user,
        child: MaterialApp(
            theme: ThemeData(fontFamily: "GoogleFonts"),
            debugShowCheckedModeBanner: false,
            home: const Wrapper()),
      ),
    );
  }
}
