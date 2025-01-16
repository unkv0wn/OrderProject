import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:orderview/src/view/home/home_screen.dart';


  final GlobalKey<NavigatorState> kGlobalKeyNavigator =
    GlobalKey<NavigatorState>();

class MyApp extends StatelessWidget {
  const MyApp({super.key});



  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: "OrderWeb",
      debugShowCheckedModeBanner: false,
      debugShowMaterialGrid: false,
      theme: ThemeData.dark().copyWith(
        textTheme: GoogleFonts.poppinsTextTheme(),
      ),
      navigatorKey: kGlobalKeyNavigator,
      home: HomeScreen(),
    );
  }
}
