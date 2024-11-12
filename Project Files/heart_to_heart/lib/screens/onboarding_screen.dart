import 'package:flutter/material.dart';
import 'dart:ui';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

class OnboardingScreen extends StatefulWidget {

  const OnboardingScreen({super.key});

  @override
  _OnboardingScreenState createState() => _OnboardingScreenState();
}

class _OnboardingScreenState extends State<OnboardingScreen> {
  final PageController _pageController = PageController();

  Future<void> completeOnboarding() async {
    Navigator.pushReplacementNamed(context, '/login');
  }

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          Positioned.fill(
            child: Image.asset(
              'assets/images/hearthand1.png',
              fit: BoxFit.cover,
            ),
          ),
          Positioned.fill(
            child: BackdropFilter(
              filter: ImageFilter.blur(sigmaX: 0.2, sigmaY: 0.2),
              child: Container(
                color: Colors.white.withOpacity(0.2),
              ),
            ),
          ),
          PageView(
            controller: _pageController,
            onPageChanged: (int page) {
              setState(() {});
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
                'The Heart to Heart Mobile Application is made for the Quebec Population from the government of Quebec. \n \n'
                    'The purpose of the application is to improve social conditions, upgrade living conditions, and enforce solidarity among communities.',
                pageController: _pageController,
              ),
              OnboardingPage(
                title: 'Policies',
                description:
                'Every application user is required to have an account in order to use the application. \n \n'
                    'Upon creating an account the user will have to present two identification documents such as passport, medical cart or drivers license. \n \n'
                    'Any other documents will have to be reviewed in order to be accepted.As mentioned previously the people that are requesting charities, donations or discounts have to have a low income or lower financial status, but the people offering donations, charities or discounts can have any financial status. \n \n'
                    'In order to participate in either role (Receiver and Donator) you have to have no criminal record for individuals above the age of 21. \n \n'
                    'In order to offer services, the Donator individual must present legitimate proof of qualifiquations for the specific service. \n \n'
                    'Any attempt at sabotage, gaslight, abuse, black mail, lying about services, donation or identity will resulted in legal consequences such as fines, court, jail time and obviously expulsion from the application.',
                pageController: _pageController,
                isLastPage: true,
                onLastPageComplete: completeOnboarding,
              ),
            ],
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
  final bool isLastPage;
  final VoidCallback? onLastPageComplete;

  const OnboardingPage({
    required this.title,
    required this.description,
    required this.pageController,
    this.isLastPage = false,
    this.onLastPageComplete,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.end,
      children: [
        Container(
          width: double.infinity,
          margin: const EdgeInsets.symmetric(horizontal: 16),
          padding: const EdgeInsets.all(24),
          decoration: BoxDecoration(
            color: Colors.white.withOpacity(0.8),
            borderRadius: BorderRadius.circular(18),
            boxShadow: [
              BoxShadow(
                color: Color(0xFFF5FBF6),
                blurRadius: 8,
                offset: const Offset(0, 4),
              ),
            ],
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              SmoothPageIndicator(
                controller: pageController, // PageController
                count: 3,
                effect: ScrollingDotsEffect(
                  activeDotColor: Color(0xFF2FD1CD),
                ),
              ),
              const SizedBox(height: 16),
              Text(
                title,
                style: const TextStyle(
                  fontSize: 28,
                  fontWeight: FontWeight.bold,
                  color: Colors.black87,
                ),
              ),
              const SizedBox(height: 16),
              Container(
                height: 180,
                child: SingleChildScrollView(
                  child: Text(
                    description,
                    textAlign: TextAlign.center,
                    style: const TextStyle(
                      fontSize: 20,
                      color: Colors.black54,
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 16),
              if (isLastPage)
                ElevatedButton(
                  onPressed: onLastPageComplete,
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Color(0xFF2FD1CD),
                  ),
                  child: const Text('I AGREE', style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                    wordSpacing: 2,
                    color: Colors.white70
                    ),
                  ),
                ),
            ],
          ),
        ),
        const SizedBox(height: 20),
      ],
    );
  }
}
