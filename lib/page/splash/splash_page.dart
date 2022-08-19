import 'dart:async';

import 'package:flutter/material.dart';

class SplashPage extends StatefulWidget {
  const SplashPage({super.key});

  @override
  State<SplashPage> createState() => _SplashPageState();
}

class _SplashPageState extends State<SplashPage> {
  @override
  void initState() {
    Timer(const Duration(seconds: 2), () {
      Navigator.pushNamed(context, '/home');
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
          child: TweenAnimationBuilder(
              tween: Tween(begin: 0.1, end: 2.0),
              duration: const Duration(seconds: 1),
              builder: (context, value, child) => Transform.scale(
                    scale: value,
                    child: const FlutterLogo(
                      size: 100,
                    ),
                  ))),
    );
  }
}
