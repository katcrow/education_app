import 'package:education_app/core/common/widgets/gradient_background.dart';
import 'package:education_app/core/res/media_res.dart';
import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';

class PageUnderConstruction extends StatelessWidget {
  const PageUnderConstruction({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: GradientBackground(
        image: MediaRes.onBoardingBackGround,
        child: Center(
          child: Column(
            children: [
              Lottie.asset(MediaRes.pageUnderConstruction),
              Text('Page : PageUnderConstruction'),
            ],
          ),
        ),
      ),
    );
  }
}
