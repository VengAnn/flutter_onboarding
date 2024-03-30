import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:onboarding_screen/view/screens/home_screen.dart';
import 'package:percent_indicator/percent_indicator.dart';

class OnboardingScreen extends StatefulWidget {
  const OnboardingScreen({super.key});

  @override
  State<OnboardingScreen> createState() => _OnboardingScreenState();
}

class _OnboardingScreenState extends State<OnboardingScreen> {
  final List<String> listAssets = [
    'assets/images/welcome.png',
    'assets/images/usher.png'
  ];

  //
  late PageController _pageController;
  int _currentPage = 0;
  @override
  void initState() {
    super.initState();
    //initalize
    _pageController =
        PageController(initialPage: _currentPage, viewportFraction: 1.0);
  }

  @override
  void dispose() {
    super.dispose();
    //close
    _pageController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Column(
          children: [
            //pagae view
            Expanded(
              child: PageView.builder(
                controller: _pageController,
                onPageChanged: (value) {
                  setState(() {
                    _currentPage = value;
                  });
                },
                itemCount: listAssets.length,
                itemBuilder: (context, index) {
                  return Column(
                    children: [
                      const SizedBox(height: 100),
                      Image(
                        width: 200,
                        fit: BoxFit.cover,
                        image: AssetImage(listAssets[index]),
                      ),
                    ],
                  );
                },
              ),
            ),
            //show dot indicator
            Wrap(
              children: List.generate(
                listAssets.length,
                (index) => Container(
                  margin: const EdgeInsets.only(right: 5.0, bottom: 10.0),
                  width: 20,
                  height: 3.9,
                  color: index == _currentPage ? Colors.amber : Colors.grey,
                ),
              ),
            ),
            //
            const SizedBox(height: 10),
            //show CircularPercentIndicator
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                const Text(""),
                CircularPercentIndicator(
                  progressColor: Colors.blue,
                  radius: 30,
                  animation: true,
                  animationDuration: 300,
                  lineWidth: 5.0,
                  percent: _currentPage == listAssets.length - 1 ? 1 : 0.5,
                  center: CircleAvatar(
                    radius: 20,
                    backgroundColor: Colors.blueAccent,
                    child: IconButton(
                      onPressed: _currentPage < listAssets.length - 1
                          ? () {
                              _pageController.animateToPage(
                                _currentPage + 1,
                                duration: const Duration(milliseconds: 500),
                                curve: Curves.linear,
                              );
                            }
                          : null, //// Disable the button when on the last page
                      icon: _currentPage == 1
                          ? GestureDetector(
                              onTap: () {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (_) => const HomeScreen(),
                                  ),
                                );
                              },
                              child: const Icon(Icons.check),
                            )
                          : const Icon(Icons.arrow_forward_ios),
                    ),
                  ),
                ),
                //text Skip if last index of pageview doesn't show skip more

                _currentPage == listAssets.length - 1
                    ? const Text("")
                    : GestureDetector(
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (_) => const HomeScreen(),
                            ),
                          );
                        },
                        child: const Text(
                          'Skip',
                          style: TextStyle(
                            color: Colors.blue,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
              ],
            ),
            const SizedBox(height: 20),
          ],
        ),
      ),
    );
  }
}
