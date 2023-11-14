import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:tft_app/modules/firebase/bloc.dart';
import 'package:tft_app/modules/firebase/event.dart';
import 'package:tft_app/modules/firebase/state.dart';
import 'package:tft_app/pages/main_screen.dart';
import 'package:tft_app/pages/onboarding_Screen.dart';
import 'package:tft_app/resources/app_assets.dart';
import 'package:tft_app/resources/text_style.dart';
import 'package:tft_app/routes/routes_name.dart';
import 'package:tft_app/widgets/animation/show_widget.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({Key? key}) : super(key: key);

  static const String name = AppRoutes.splash;

  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> with TickerProviderStateMixin {
  final FirebaseBloc firebaseBloc = FirebaseBloc();
  @override
  void initState() {
    super.initState();

    if (FirebaseAuth.instance.currentUser != null) {
      firebaseBloc.add(GetHomeEvent());
    } else {
      _checkFirstTime().then((bool isFirstTime) {
        Future.delayed(
          const Duration(seconds: 2),
          () {
            if (isFirstTime) {
              Navigator.pushNamedAndRemoveUntil(context, OnboardingScreen.name, (route) => false);
            } else {
              Navigator.pushNamedAndRemoveUntil(context, MainScreen.name, (route) => false);
            }
          },
        );
      });
    }
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  Future<bool> _checkFirstTime() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    bool isFirstTime = prefs.getBool('isFirstTime') ?? true;

    if (isFirstTime) {
      // Set isFirstTime to false for future app openings
      await prefs.setBool('isFirstTime', false);
    }

    return isFirstTime;
  }

  late final AnimationController _controller = AnimationController(
    duration: const Duration(seconds: 2),
    vsync: this,
  )..repeat(reverse: true);
  late final Animation<double> _animation = CurvedAnimation(
    parent: _controller,
    curve: Curves.elasticOut,
  );

  @override
  Widget build(BuildContext context) {
    return BlocListener(
      bloc: firebaseBloc,
      listener: (context, state) {
        if (state is HomeState) {
          Navigator.pushNamedAndRemoveUntil(context, MainScreen.name, (route) => false);
        }
      },
      child: Scaffold(
        body: SafeArea(
          child: Center(
            child: Column(
              children: [
                Expanded(
                  flex: 3,
                  child: RotationTransition(
                      turns: _animation,
                      child: SvgPicture.asset(
                        AppAssets.LOGO,
                        width: 150.w,
                      )),
                ),
                Expanded(
                  child: ShowWidget(
                    delay: 300,
                    animationCurve: Curves.bounceIn,
                    child: Text(
                      'TFT version 0.1',
                      style: AppTextStyles.header1Text(
                        color: Theme.of(context).colorScheme.primaryContainer,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
