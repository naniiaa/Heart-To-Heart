import 'package:flutter/material.dart';
import '../util/auth_wrapper.dart';
import 'dart:async';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    Timer(const Duration(seconds: 2), ()
    {
      Navigator.of(context).pushReplacement(MaterialPageRoute(builder: (_) => AuthWrapper()));
    });
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Color(0xFFF5FBF6),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Container(
                child: Image.asset('assets/images/hearthand.png', fit: BoxFit.contain),
                        alignment: Alignment.bottomCenter,
            ),
            const SizedBox(height: 20),
             CircularProgressIndicator(),
          ],
        ),
      ),
    );
  }
}
