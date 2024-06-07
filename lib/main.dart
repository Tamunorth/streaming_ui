import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:streaming_ui/pages/base_page.dart';
import 'package:streaming_ui/pages/home_page.dart';

import 'pages/onboarding_page.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Gaming.ly',
      theme: ThemeData(
        textTheme: GoogleFonts.poppinsTextTheme().apply(
          bodyColor: Colors.white,
          displayColor: Colors.white,
        ),
        brightness: Brightness.light,
        scaffoldBackgroundColor: const Color(0xff181828),
        hintColor: const Color(0xff676699).withOpacity(0.9),
        iconTheme: const IconThemeData(
          color: Colors.white,
        ),
        colorScheme: ColorScheme.fromSeed(
          seedColor: const Color(0xfff11b43),
        ).copyWith(
          brightness: Brightness.light,
          primary: const Color(0xfff11b43),
          secondary: const Color(0xff181828),
        ),
        useMaterial3: true,
      ),
      home: const OnBoardingPage(),
    );
  }
}
