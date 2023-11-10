import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:random_avatar/random_avatar.dart';
import 'package:tft_app/language/language_constants.dart';
import 'package:tft_app/resources/text_style.dart';
import 'package:tft_app/routes/routes_name.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});
  static const String name = AppRoutes.home;

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

bool isDarkMode = false;

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.background,
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(25),
          child: Column(
            children: [
              _buildHeader(context),
              SizedBox(
                height: 20.w,
              ),
              _buildBalance(context),
              SizedBox(
                height: 15.w,
              ),
              _buildPrice(context)
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildPrice(BuildContext context) {
    return Container(
      width: 160.w,
      decoration: BoxDecoration(
        color: Theme.of(context).colorScheme.primaryContainer,
        borderRadius: BorderRadius.circular(50),
      ),
      child: Padding(
        padding: EdgeInsets.symmetric(vertical: 4.h, horizontal: 10.w),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              'BTC: 0.00335',
              style: AppTextStyles.header2Text(
                color: Theme.of(context).colorScheme.primary,
              ),
            ),
            SizedBox(
              width: 15.w,
            ),
            Text(
              '+6.54%',
              style: AppTextStyles.header2Text(
                color: Theme.of(context).colorScheme.inversePrimary,
              ),
            )
          ],
        ),
      ),
    );
  }

  Widget _buildBalance(BuildContext context) {
    return Column(
      children: [
        Text(
          translation(context).textHomeBalance,
          style: AppTextStyles.header1Text(
            color: Theme.of(context).colorScheme.primary,
          ),
        ),
        SizedBox(
          height: 10.h,
        ),
        Text(
          '\$5,323.00',
          style: AppTextStyles.headerText(
            color: Theme.of(context).colorScheme.primary,
          ),
        )
      ],
    );
  }

  Widget _buildHeader(BuildContext context) {
    return Row(
      children: [
        Row(
          children: [
            Container(
              decoration: const BoxDecoration(
                shape: BoxShape.circle,
              ),
              child: CircleAvatar(
                radius: 30,
                child: RandomAvatar(
                  'saytoonz',
                  height: 50,
                  width: 50,
                ),
              ),
            ),
            SizedBox(
              width: 15.w,
            ),
            Text(
              'Tuan Vuong',
              style: TextStyle(
                  color: Theme.of(context).colorScheme.primary,
                  fontSize: 16.sp,
                  fontFamily: 'Urbanist',
                  fontWeight: FontWeight.w600),
            )
          ],
        ),
        const Spacer(),
        Icon(
          Icons.notifications,
          color: Theme.of(context).colorScheme.primary,
        ),
      ],
    );
  }
}
