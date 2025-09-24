import 'dart:async';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:netxlif/shared_widgets/primary_button.dart';

import '../../../home/presentations/screens/home_screen.dart';

class OnBoardingScreen extends StatefulWidget {
  const OnBoardingScreen({super.key});

  @override
  State<OnBoardingScreen> createState() => _OnBoardingScreenState();
}

class _OnBoardingScreenState extends State<OnBoardingScreen> {
  bool isFirstImage = true;
  late Timer timer;
  @override
  void initState() {
    super.initState();
    timer = Timer.periodic(const Duration(seconds: 3), (timer) {
      setState(() {
        isFirstImage = !isFirstImage;
      });
    });
  }

  @override
  void dispose() {
    timer.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: SafeArea(
        child: CustomScrollView(
          slivers: [
            SliverToBoxAdapter(
              child: Column(
                children: [
                  AnimatedCrossFade(
                    firstChild: CachedNetworkImage(
                      imageUrl:
                          'https://tugumalang.id/wp-content/uploads/2025/05/8cf6d779-d390-4f37-bb0d-b4041e0f570e.jpg',
                      fit: BoxFit.cover,
                      width: double.infinity,
                      height: MediaQuery.of(context).size.height * 0.55,
                      errorWidget: (context, error, stackTrace) {
                        return Icon(
                          Icons.broken_image_outlined,
                          size: 300,
                          color: Colors.grey,
                        );
                      },
                    ),
                    secondChild: CachedNetworkImage(
                      imageUrl:
                          'https://images.unsplash.com/photo-1635805737707-575885ab0820?q=80&w=987&auto=format&fit=crop&ixlib=rb-4.1.0&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D',
                      fit: BoxFit.cover,
                      width: double.infinity,
                      height: MediaQuery.of(context).size.height * 0.55,
                      errorWidget: (context, error, stackTrace) {
                        return Icon(
                          Icons.broken_image_outlined,
                          size: 300,
                          color: Colors.grey,
                        );
                      },
                    ),
                    crossFadeState: isFirstImage
                        ? CrossFadeState.showFirst
                        : CrossFadeState.showSecond,
                    duration: const Duration(seconds: 1),
                  ),
                  Gap(10),
                  Center(
                    child: Text(
                      'Welcome to Cineverse',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 32,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                  Gap(20),
                  Text(
                    'Discover a variety of exciting films at Cineverse. Enjoy an unparalleled movie discovery experience with our extensive content collection.',
                    // english: 'Discover a wide range of exciting movies on Cineverse. Enjoy an unparalleled viewing experience with our extensive content collection.',
                    textAlign: TextAlign.center,
                    style: TextStyle(color: Colors.grey, fontSize: 14),
                  ),
                  Gap(30),
                  PrimaryButton(
                    text: 'Get Started',
                    onPressed: () {
                      Navigator.of(context).pushReplacement(
                        MaterialPageRoute(
                          builder: (context) => const HomeScreen(),
                        ),
                      );
                    },
                  ),
                ],
              ),
            ),
            SliverFillRemaining(
              child: Align(
                alignment: Alignment.bottomCenter,
                child: Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Text(
                    '© 2025 TheMovie. All rights reserved.',
                    style: TextStyle(color: Colors.grey, fontSize: 12),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
