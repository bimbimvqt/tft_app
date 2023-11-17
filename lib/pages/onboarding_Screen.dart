import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

import '../language/language_constants.dart';
import '../resources/app_assets.dart';
import '../resources/text_style.dart';
import '../routes/routes_name.dart';
import '../widgets/slide.dart';
import 'login_screen.dart';

class OnboardingScreen extends StatefulWidget {
  const OnboardingScreen({super.key});
  static const String name = AppRoutes.onboarding;

  @override
  State<OnboardingScreen> createState() => _OnboardingScreenState();
}

class _OnboardingScreenState extends State<OnboardingScreen> {
  final _controller = PageController();

  bool onLastPage = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.background,
      body: Column(
        children: [
          // _buildHeaderImage(),
          _buildImageSlider(context),
          _buildIndicator(context),
        ],
      ),
    );
  }

  Widget _buildIndicator(BuildContext context) {
    return Expanded(
      flex: 2,
      child: Column(
        children: [
          SizedBox(
            height: 15.h,
          ),
          SmoothPageIndicator(
            controller: _controller,
            count: 3,
            effect: ExpandingDotsEffect(
              activeDotColor: Colors.grey.shade800,
            ),
          ),
          SizedBox(
            height: 25.h,
          ),
          onLastPage
              ? ElevatedButton(
                  style: ElevatedButton.styleFrom(
                      backgroundColor: Theme.of(context).colorScheme.secondary,
                      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8))),
                  onPressed: () {
                    Navigator.pushNamed(context, LoginScreen.name);
                  },
                  child: Padding(
                    padding: EdgeInsets.symmetric(vertical: 16.h, horizontal: 32.w),
                    child: Text(
                      translation(context).textHomeBalance,
                      style: AppTextStyles.header1Text(
                        fontWeight: FontWeight.w500,
                        color: Theme.of(context).colorScheme.primary,
                      ),
                    ),
                  ),
                )
              : Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    GestureDetector(
                      onTap: () {
                        _controller.jumpToPage(2);
                      },
                      child: Text(
                        translation(context).textHomeTokens,
                        style: AppTextStyles.header1Text(
                          color: Theme.of(context).colorScheme.secondary,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ),
                    SizedBox(
                      width: 25.w,
                    ),
                    ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Theme.of(context).colorScheme.secondary,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(8),
                        ),
                      ),
                      onPressed: (() {
                        _controller.nextPage(
                          duration: const Duration(
                            microseconds: 500,
                          ),
                          curve: Curves.easeIn,
                        );
                      }),
                      child: Padding(
                        padding: EdgeInsets.symmetric(vertical: 16.h, horizontal: 32.w),
                        child: Text(
                          translation(context).textHomeBalance,
                          style: AppTextStyles.header1Text(
                            color: Theme.of(context).colorScheme.primary,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      ),
                    )
                  ],
                )
        ],
      ),
    );
  }

  Widget _buildImageSlider(BuildContext context) {
    return Expanded(
      flex: 5,
      child: PageView(
        controller: _controller,
        onPageChanged: (index) {
          setState(() {
            onLastPage = (index == 2);
          });
        },
        children: [
          Slide(
            title: translation(context).textHomeBalance,
            des: "Lorem ipsum dolor sit amet la maryame dor sut colondeum.",
            image: AppAssets.BANNER1,
          ),
          Slide(
            title: translation(context).textHomeBalance,
            des: "Lorem ipsum dolor sit amet la maryame dor sut colondeum.",
            image: AppAssets.BANNER2,
          ),
          Slide(
            title: translation(context).textHomeBalance,
            des: "Lorem ipsum dolor sit amet la maryame dor sut colondeum.",
            image: AppAssets.BANNER3,
          ),
        ],
      ),
    );
  }
}
