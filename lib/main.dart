import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:ip/presentation/screens/splash/splash_screen.dart';

import 'business_logic/services/m3u_a_json.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  SystemChrome.setSystemUIOverlayStyle(
      SystemUiOverlayStyle(statusBarColor: Color(0xff1a1726)));

  runApp(ProviderScope(
    child: MaterialApp(
      themeMode: ThemeMode.system,
      title: "ip",
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        textTheme: GoogleFonts.soraTextTheme(),
        scaffoldBackgroundColor: Color(0xff1a1726),
      ),
      home: MyApp(),
    ),
  ));
}

class MyApp extends StatelessWidget {
  MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const SplashScreen();
  }
}
