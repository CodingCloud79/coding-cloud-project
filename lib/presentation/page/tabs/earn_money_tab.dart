import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';

class EarnMoney extends StatefulWidget {
  const EarnMoney({super.key});

  @override
  State<EarnMoney> createState() => _EarnMoneyState();
}

class _EarnMoneyState extends State<EarnMoney> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Animate(
        effects: [FadeEffect(), ScaleEffect()],
        child: Container(
          decoration: BoxDecoration(color: Colors.grey),
            child: Center(
          child: Text("Earn Tab "),
        )),
      ),
    );
  }
}
