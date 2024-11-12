import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import '../screens/homepage_screen.dart';
import '../screens/login_screen.dart';
import '../screens/onboarding_screen.dart';

class AuthWrapper extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return StreamBuilder<User?>(
      stream: FirebaseAuth.instance.authStateChanges(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Center(child: CircularProgressIndicator());
        } else if (snapshot.hasData) {
          // User is logged in, go to HomePageScreen
          return HomePageScreen();
        } else {
          // User is not logged in, show onboarding
          return OnboardingScreen();
        }
      },
    );
  }
}
