import 'package:app/auth/login.dart';
import 'package:app/home.dart';
import 'package:app/pages/chackToFinal.dart';
import 'package:app/pages/final.dart';
import 'package:app/pages/questions.dart';
import 'package:app/pages/ru5sa.dart';
import 'package:app/pages/rules.dart';
import 'package:app/pillars/Cautious.dart';
import 'package:app/pillars/Guidance.dart';
import 'package:app/pillars/Role.dart';
import 'package:app/pillars/ban.dart';
import 'package:app/pillars/mandatory.dart';
import 'package:app/pillars/pillars.dart';
import 'package:app/profile.dart';
import 'package:flutter/material.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'auth/notAuth.dart';
import 'auth/register.dart';
import 'package:firebase_core/firebase_core.dart';

import 'auth/resetPassword.dart';

var islogen;

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  MobileAds.instance.initialize();
  await Firebase.initializeApp();
  final prefs = await SharedPreferences.getInstance();
  if (prefs.getString('sign') == 'true'){
    islogen = true;
  }else {
    islogen = false;
  }
  runApp(
    MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Named Routes Demo',
      routes: {
        '/Cautious': (context) => Cautious(),
        '/Rusa': (context) => Rusa(),
        '/login': (context) => Login(),
        '/Rules': (context) => Rules(),
        '/Not': (context) => Not(),
        '/Pillars': (context) => Pillars(),
        '/Chack': (context) => Chack(),
        '/rest': (context) => ResetPassword(),
        '/Mandatory': (context) => Mandatory(),
        '/Guidance': (context) => Guidance(),
        '/home': (context) => Main(),
        '/auth': (context) => RegisterScreen(),
        '/quastion': (context) => Questions1(),
        '/Ban': (context) => const Ban(),
        '/Profile': (context) => Profile(),
        '/Final': (context) => Final(),
        '/Role': (context) => Role(),
      },
      home: islogen == false ? Not() : Main(),
    ),
  );
}
