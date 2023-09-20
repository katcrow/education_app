import 'package:education_app/core/common/views/loading_view.dart';
import 'package:education_app/core/common/widgets/gradient_background.dart';
import 'package:education_app/core/res/app_colors.dart';
import 'package:education_app/core/res/media_res.dart';
import 'package:education_app/src/on_boarding/domain/entities/page_content_ent.dart';
import 'package:education_app/src/on_boarding/domain/usecases/cache_first_timer_uc.dart';
import 'package:education_app/src/on_boarding/presentation/cubit/on_boarding_cubit.dart';
import 'package:education_app/src/on_boarding/presentation/widgets/on_boarding_body.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

class OnBoardingScreen extends StatefulWidget {
  const OnBoardingScreen({super.key});

  static const routeName = '/';

  @override
  State<OnBoardingScreen> createState() => _OnBoardingScreenState();
}

class _OnBoardingScreenState extends State<OnBoardingScreen> {
  final pageController = PageController();

  @override
  void initState() {
    super.initState();
    context.read<OnBoardingCubit>().checkIfUserFirstTimer();
  }

  @override
  Widget build(BuildContext context) {
    // binding 되어진 큐빗을 감시
    return Scaffold(
      backgroundColor: Colors.white,
      body: GradientBackground(
        image: MediaRes.onBoardingBackGround,
        child: BlocConsumer<OnBoardingCubit, OnBoardingState>(
          listener: (context, state) {
            if (state is OnBoardingStatus && state.isFirstTimer) {
              Navigator.pushReplacementNamed(context, '/home');
            } else if (state is UserCached) {
              // todo(User-cached-handler): push to appropriate screen
            }
          },
          builder: (context, state) {
            if (state is CheckingIfUserIsFirstTimer ||
                state is CacheFirstTimerUc) {
              return const LoadingView();
            }

            return Stack(
              children: [
                PageView(
                  controller: pageController,
                  children: const [
                    OnBoardingBody(
                      pageContentEnt: PageContentEnt.first(),
                    ),
                    OnBoardingBody(
                      pageContentEnt: PageContentEnt.second(),
                    ),
                    OnBoardingBody(
                      pageContentEnt: PageContentEnt.third(),
                    ),
                  ],
                ),
                Align(
                  alignment: const Alignment(0, 0.04),
                  child: SmoothPageIndicator(
                    controller: pageController,
                    count: 3,
                    onDotClicked: (index) {
                      pageController.animateToPage(
                        index,
                        duration: const Duration(milliseconds: 500),
                        curve: Curves.easeInOut,
                      );
                    },
                    effect: const WormEffect(
                      dotHeight: 10,
                      dotWidth: 10,
                      spacing: 40,
                      activeDotColor: AppColors.primaryColor,
                      dotColor: Colors.white,
                    ),
                  ),
                ),
              ],
            );
          },
        ),
      ),
    );
  }
}
