import 'package:flutter/material.dart';
import 'dart:ui';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';
import 'login_screen.dart';
import 'signup_screen.dart';
import 'main_screen.dart';

import 'searchBar.dart';

void main() {
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
      home: HomePage(),
      // home: const OnboardingScreen(),
      // initialRoute: '/',
      // routes: {
      //   '/login': (context) =>  LoginScreen(),
      //   '/signup': (context) =>  SignupScreen(),
      // },
    );
  }
}

class OnboardingScreen extends StatefulWidget
{
  const OnboardingScreen({super.key});

  @override
  _OnboardingScreenState createState() => _OnboardingScreenState();
}

class _OnboardingScreenState extends State<OnboardingScreen>
{
  final PageController _pageController = PageController();

  @override
  void dispose()
  {
    _pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context)
  {
    return Scaffold(
      body: Stack(
        children: [
          // Background image with blur effect
          Positioned.fill(
            child: Image.asset(
              'assets/images/hearthand.png',
              fit: BoxFit.cover,
            ),
          ),
          Positioned.fill(
            child: BackdropFilter(
              filter: ImageFilter.blur(sigmaX: 0.8, sigmaY: 0.8),
              child: Container(
                color: Colors.white.withOpacity(0.2),
              ),
            ),
          ),
          PageView(
            controller: _pageController,
            onPageChanged: (int page) {
              setState(() {

              });
            },
            scrollDirection: Axis.horizontal,
            children: [
              OnboardingPage(
                title: 'Welcome',
                description:
                'Thank you for joining our community of changemakers! Whether you’re here to donate, volunteer, or both, you’ve just taken a powerful step toward making a real difference.',
                pageController: _pageController,
              ),
              OnboardingPage(
                title: 'Heart To Heart',
                description:
                'The Heart to Heart Mobile Application is made for the Quebec Population from the government of Quebec. The purpose of the application is to improve social conditions, upgrade living conditions, and enforce solidarity among communities.',
                pageController: _pageController,
              ),
              OnboardingPage(
                title: 'Policies',
                description:
                'Every application user is required to have an account in order to use the application. \n Upon creating an account the user will have to present two identification documents such as passport, medical cart or drivers license. \n Any other documents will have to be reviewed in order to be accepted.As mentioned previously the people that are requesting charities, donations or discounts have to have a low income or lower financial status, but the people offering donations, charities or discounts can have any financial status. In order to participate in either role (Receiver and Donator) you have to have no criminal record for individuals above the age of 21. \n In order to offer services, the Donator individual must present legitimate proof of qualifiquations for the specific service. \n Any attempt at sabotage, gaslight, abuse, black mail, lying about services, donation or identity will resulted in legal consequences such as fines, court, jail time and obviously expulsion from the application.',
                pageController: _pageController,
              ),
            ],
          ),
          Positioned(
            bottom: 20,
            left: 0,
            right: 0,
            child: Center(
              child: SmoothPageIndicator(
                controller: _pageController, // PageController
                count: 3,
                effect: SlideEffect(),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class OnboardingPage extends StatelessWidget {
  final String title;
  final String description;
  final PageController pageController;

  const OnboardingPage({
    required this.title,
    required this.description,
    required this.pageController,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Container(
        width: 350,
        margin: const EdgeInsets.symmetric(horizontal: 16),
        padding: const EdgeInsets.all(24),
        decoration: BoxDecoration(
          color: Colors.white10.withOpacity(0.8),
          borderRadius: BorderRadius.circular(20),
          boxShadow: [
            BoxShadow(
              color: Colors.transparent,
              blurRadius: 8,
              offset: const Offset(0, 4),
            ),
          ],
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              title,
              style: const TextStyle(
                fontSize: 28,
                fontWeight: FontWeight.bold,
                color: Colors.black87,
              ),
            ),
            const SizedBox(height: 16),
            Text(
              description,
              textAlign: TextAlign.center,
              style: const TextStyle(
                fontSize: 16,
                color: Colors.black54,
              ),
            ),
            const SizedBox(height: 24),
            ElevatedButton(
              onPressed: () {
                Navigator.pushNamed(context, '/');
              },
              child: const Text('NEXT'),
            ),
          ],
        ),
      ),
    );
  }
}
