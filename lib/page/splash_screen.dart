import 'package:coba/variables/ui_material.dart';
import 'package:flutter/material.dart';
import 'dart:async';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  SplashScreenState createState() => SplashScreenState();
}

class SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    Timer(const Duration(seconds: 3), () {
      Navigator.of(context).pushReplacementNamed('/');
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        // crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            height: MediaQuery.of(context).size.height * 0.8,
            decoration: const BoxDecoration(color: blue),
          ),
          Positioned(
              top: MediaQuery.of(context).size.height * 0.3,
              left: -MediaQuery.of(context).size.width * 0.2,
              child: Transform.rotate(
                angle:
                    -90 * 3.141592653589793 / 180, // Rotasi 90 derajat ke kiri
                child: const Text(
                  "ForYou.",
                  style: TextStyle(color: Colors.white, fontSize: 180),
                ),
              ))
        ],
      ),
    );
  }
}
