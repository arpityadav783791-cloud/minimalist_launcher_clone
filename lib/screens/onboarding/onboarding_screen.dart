import 'package:flutter/material.dart';
import 'package:minimalist_launcher_clone/screens/permissions/permissions_screen.dart';

class OnboardingScreen extends StatefulWidget {
  const OnboardingScreen({super.key});

  @override
  State<OnboardingScreen> createState() => _OnboardingScreenState();
}

class _OnboardingScreenState extends State<OnboardingScreen> {
  final PageController _controller = PageController();

  int currentPage = 0;

  final List<Map<String, dynamic>> pages = [
    {
      "title": "MINIMALIST",
      "subtitle": "Less distraction.\nMore focus.",
      "description":
          "A launcher designed to help you\nspend less time on your phone.",
      "button": "NEXT",
    },
    {
      "title": "TEXT ONLY",
      "subtitle": "No icons.\nNo colors.",
      "description":
          "Only what matters.\n\n• Text-only launcher\n• Instant search\n• Faster access",
      "button": "NEXT",
    },
    {
      "title": "STAY PRODUCTIVE",
      "subtitle": "Build better habits.",
      "description":
          "✓ Screen Time Dashboard\n\n"
          "✓ Mindful Delay\n\n"
          "✓ Usage Limits\n\n"
          "✓ Scheduled Blocking\n\n"
          "✓ Notification Filter",
      "button": "GET STARTED",
    },
  ];

  void nextPage() {
    if (currentPage < pages.length - 1) {
      _controller.nextPage(
        duration: const Duration(milliseconds: 300),
        curve: Curves.easeInOut,
      );
    } else {
      Navigator.pushReplacement(
        context, 
        MaterialPageRoute(
          builder: (_) => const PermissionsScreen(),
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: PageView.builder(
          controller: _controller,
          itemCount: pages.length,
          onPageChanged: (value) {
            setState(() {
              currentPage = value;
            });
          },
          itemBuilder: (context, index) {
            final page = pages[index];

            return Padding(
              padding: const EdgeInsets.symmetric(horizontal: 30),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Spacer(),

                  Text(
                    page["title"],
                    style: const TextStyle(
                      fontSize: 34,
                      fontWeight: FontWeight.w300,
                      letterSpacing: 5,
                    ),
                  ),

                  const SizedBox(height: 35),

                  Text(
                    page["subtitle"],
                    style: const TextStyle(
                      fontSize: 28,
                      fontWeight: FontWeight.w500,
                      height: 1.3,
                    ),
                  ),

                  const SizedBox(height: 25),

                  Text(
                    page["description"],
                    style: const TextStyle(
                      fontSize: 18,
                      color: Colors.black54,
                      height: 1.7,
                    ),
                  ),

                  const Spacer(),

                  Row(
                    children: List.generate(
                      pages.length,
                      (dot) => AnimatedContainer(
                        duration: const Duration(milliseconds: 250),
                        margin: const EdgeInsets.only(right: 8),
                        width: currentPage == dot ? 28 : 8,
                        height: 8,
                        decoration: BoxDecoration(
                          color: currentPage == dot
                              ? Colors.black
                              : Colors.black26,
                          borderRadius: BorderRadius.circular(20),
                        ),
                      ),
                    ),
                  ),

                  const SizedBox(height: 30),

                  SizedBox(
                    width: double.infinity,
                    height: 55,
                    child: ElevatedButton(
                      onPressed: nextPage,
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.black,
                        foregroundColor: Colors.white,
                        elevation: 0,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(14),
                        ),
                      ),
                      child: Text(
                        page["button"],
                        style: const TextStyle(
                          fontSize: 16,
                          letterSpacing: 1,
                        ),
                      ),
                    ),
                  ),

                  const SizedBox(height: 30),
                ],
              ),
            );
          },
        ),
      ),
    );
  }
}