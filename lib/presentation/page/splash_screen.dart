// ignore_for_file: unnecessary_new

import 'package:flutter/material.dart';
import 'package:flutter_application_1/presentation/page/enter_phone_screen.dart';
import 'package:flutter_application_1/presentation/page/tabs/home_screen_tab.dart';
import 'package:lottie/lottie.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SplshScreen extends StatefulWidget {
  const SplshScreen({super.key});

  @override
  State<SplshScreen> createState() => _SplshScreenState();
}

class _SplshScreenState extends State<SplshScreen> {
  bool loggedIn = false;
  @override
  void initState() {
    getData();
    super.initState();
    Future.delayed(
      const Duration(milliseconds: 2500),
      () {
        Navigator.pop(context);
        Navigator.push(
          context,
          PageRouteBuilder(
            pageBuilder: (_, __, ___) =>
                loggedIn ? const HomeScreen() : const PhoneScreen(),
            transitionDuration: const Duration(milliseconds: 1500),
            transitionsBuilder: (_, a, __, c) =>
                FadeTransition(opacity: a, child: c),
          ),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Center(
        child: Lottie.asset(
          'assets/lotties/Splash1.json',
          width: double.infinity,
          fit: BoxFit.cover,
        ),
      ),
    );
  }

  Future<void> getData() async {
    SharedPreferences _prefs = await SharedPreferences.getInstance();
    setState(() {
      loggedIn = _prefs.getBool('loggedIn') ?? false;
    });
  }
}
