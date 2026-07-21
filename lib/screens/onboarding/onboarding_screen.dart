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

  final List<Map<String, String>> pages = [
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
          "Mindful Delay\nFocus Mode\nUsage Limits\nHide Apps\nScreen Time Dashboard",
      "button": "Continue",
    },
    {
      "title": "almost ready",
      "headline": "Let's set\nthings up.",
      "description":
          "We'll ask for a few permissions so Minimalist can become your default launcher.",
      "button": "Get Started",
    },
  ];

  void nextPage() {
    if (currentPage < pages.length - 1) {
      _controller.nextPage(
        duration: const Duration(milliseconds: 300),
        curve: Curves.easeOut,
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
    final theme = Theme.of(context);
    final colors = theme.colorScheme;

    return Scaffold(
      backgroundColor: theme.scaffoldBackgroundColor,
      body: SafeArea(
        child: PageView.builder(
          controller: _controller,
          itemCount: pages.length,
          onPageChanged: (index) {
            setState(() {
              currentPage = index;
            });
          },
          itemBuilder: (context, index) {
            final page = pages[index];

            return Padding(
              padding: const EdgeInsets.symmetric(
                horizontal: 32,
                vertical: 24,
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Spacer(),

                  Text(
                    page["title"]!,
                    style: theme.textTheme.titleMedium?.copyWith(
                      letterSpacing: 3,
                      fontWeight: FontWeight.w400,
                      color: colors.primary,
                    ),
                  ),

                  const SizedBox(height: 28),

                  Text(
                    page["headline"]!,
                    style: theme.textTheme.displaySmall?.copyWith(
                      fontWeight: FontWeight.w300,
                      height: 1.15,
                      color: colors.onSurface,
                    ),
                  ),

                  const SizedBox(height: 28),

                  Text(
                    page["description"]!,
                    style: theme.textTheme.bodyLarge?.copyWith(
                      color: colors.onSurface.withValues(alpha: 0.70),
                      height: 1.8,
                    ),
                  ),

                  const Spacer(),

                  Row(
                    children: List.generate(
                      pages.length,
                      (dot) => AnimatedContainer(
                        duration: const Duration(milliseconds: 250),
                        margin: const EdgeInsets.only(right: 8),
                        width: currentPage == dot ? 22 : 8,
                        height: 8,
                        decoration: BoxDecoration(
                          color: currentPage == dot
                              ? colors.primary
                              : colors.onSurface.withValues(alpha: 0.20),
                          borderRadius: BorderRadius.circular(20),
                        ),
                      ),
                    ),
                  ),

                  const SizedBox(height: 32),

                  SizedBox(
                    width: double.infinity,
                    height: 56,
                    child: FilledButton(
                      onPressed: nextPage,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            page["button"]!,
                            style: const TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                          const SizedBox(width: 8),
                          const Icon(Icons.arrow_forward_rounded),
                        ],
                      ),
                    ),
                  ),

                  const SizedBox(height: 24),
                ],
              ),
            );
          },
        ),
      ),
    );
  }
}