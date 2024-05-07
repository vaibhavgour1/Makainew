import 'package:dots_indicator/dots_indicator.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:go_router/go_router.dart';
import 'package:makaihealth/utility/colors.dart';
import 'package:makaihealth/utility/dimension.dart';
import 'package:makaihealth/utility/logger.dart';
import 'package:makaihealth/utility/text_styles.dart';
import 'package:makaihealth/widget/app_button.dart';

class OnboardingScreen extends StatefulWidget {
  @override
  _OnboardingScreenState createState() => _OnboardingScreenState();
}

class _OnboardingScreenState extends State<OnboardingScreen> {
  final PageController _controller = PageController();
  int currentPage = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Stack(
          children: [
            PageView(
              controller: _controller,
              onPageChanged: (int page) {
                setState(() {
                  currentPage = page;
                });
              },
              children: const [
                OnboardingPage(
                  title: 'Experience personalized medicine like never before.',
                  image: 'assets/images/svgs/amico.svg',
                ),
                OnboardingPage(
                  title: 'Monitor your condition Anytime.Anywhere  ',
                  image: 'assets/images/svgs/rafiki.svg',
                ),
              ],
            ),
            Positioned(
              bottom: 90.0,
              left: 0,
              right: 0,
              child: DotsIndicator(
                dotsCount: 2,
                position: currentPage,
                decorator: DotsDecorator(
                  size: const Size.square(8.0),
                  activeSize: const Size(20.0, 8.0),
                  activeShape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(5.0),
                  ),
                ),
              ),
            ),
            Positioned(
                bottom: 16.0,
                left: 0,
                right: 0,
                child: AppButton(
                  "Next",
                  () {
                    currentPage.logD;
                    if (currentPage == 0) {
                      currentPage = 1;
                      _controller.nextPage(
                        duration: Duration(milliseconds: 300),
                        curve: Curves.easeInOut,
                      );
                    }
                    else{
                      context.go('/LoginSignupScreen');
                    }
                  },
                  isDisabled: false,
                )),
          ],
        ),
      ),
    );
  }
}

class OnboardingPage extends StatelessWidget {
  final String? title;

  final String? image;

  const OnboardingPage({
    super.key,
    this.title,
    this.image,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        SvgPicture.asset(
          image!,
          // height: 200.0,
          // width: 200.0,
          fit: BoxFit.contain,
        ),
        const SizedBox(height: 16.0),
        Text(
          title!,
          textAlign: TextAlign.center,
          style: textSemiBold.copyWith(
              fontSize: AppSize.sp26, color: AppColor.black),
        ),
        const SizedBox(height: 8.0),
      ],
    );
  }
}
