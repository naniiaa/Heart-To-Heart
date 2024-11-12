import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'screens/login_screen.dart';
import 'screens/signup_screen.dart';
import 'screens/homepage_screen.dart';
import 'screens/onboarding_screen.dart';
import 'screens/forgotpassword_screen.dart';
import 'util/auth_wrapper.dart';
import 'screens/splash_screen.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: FirebaseOptions(
        apiKey: "AIzaSyBWc2YkYEWI0R7LmzprHpNBZHKdJkJE9RA",
        appId: "698250547272",
        messagingSenderId: "1:698250547272:android:b41d1386682624fc3b487d",
        projectId: "heart-to-heart-1")
  );
  runApp(const HeartToHeart());
}

class HeartToHeart extends StatelessWidget
{
  const HeartToHeart({super.key});

  @override
  Widget build(BuildContext context)
  {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData.light().copyWith(
        scaffoldBackgroundColor: Colors.transparent,
      ),
      home: SplashScreen(),
      routes: {
        '/onboarding' : (context) => OnboardingScreen(),
        '/login': (context) =>  LogInScreen(),
        '/signup': (context) =>  SignUpScreen(),
        '/forgotpassword' : (context) => ForgotPasswordScreen(),
        '/home' : (context) => HomePageScreen(),
      },
    );
  }
}
