// ignore_for_file: unnecessary_new

import 'package:flutter/material.dart';
import 'package:flutter_application_1/presentation/page/enter_phone_screen.dart';
import 'package:flutter_application_1/presentation/page/home_screen.dart';
import 'package:lottie/lottie.dart';

import 'activate_membership.dart';

class SplshScreen extends StatefulWidget {
  const SplshScreen({super.key});

  @override
  State<SplshScreen> createState() => _SplshScreenState();
}

class _SplshScreenState extends State<SplshScreen> {
  @override
  void initState() {
    super.initState();

    Future.delayed(
      const Duration(milliseconds: 2500),
      () {
        Navigator.pop(context);
        Navigator.push(
          context,
          // MaterialPageRoute(

          //   builder: (context) => const PhoneScreen(),
          //   // builder: (context) => const ActivateMembership(),
          //   // builder: (context) => const HomeScreen(),
          //   // builder: (context) => const RegisterUser(phoneNumber: '',),
          // ),
          PageRouteBuilder(
            pageBuilder: (_, __, ___) => const PhoneScreen(),
            transitionDuration: const Duration(milliseconds:1500 ),
            // transitionsBuilder: (BuildContext context,
            //     Animation<double> animation,
            //     Animation<double> secondaryAnimation,
            //     Widget child) {
            //   return SlideTransition(
            //     position: Tween<Offset>(
            //       begin: const Offset(1.0, 0.0),
            //       end: Offset.zero,
            //     ).animate(animation),
            //     child: child,
            //   );
            // },
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
        child: Lottie.asset('assets/lotties/Splash1.json',
            width: double.infinity, fit: BoxFit.cover),
      ),
    );
  }
}
