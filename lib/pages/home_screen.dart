import 'package:chart_sparkline/chart_sparkline.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:random_avatar/random_avatar.dart';

import '../data/dummy_data/dummy_data.dart';
import '../language/language_constants.dart';
import '../resources/app_assets.dart';
import '../resources/text_style.dart';
import '../routes/routes_name.dart';
import '../widgets/animation/show_widget.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});
  static const String name = AppRoutes.home;

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

bool isDarkMode = false;
TabController? controller;

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
              _buildPrice(context),
              SizedBox(
                height: 35.w,
              ),
              _buildButton(context),
              _buildTabBarButton(),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildTabBarButton() {
    return Expanded(
      child: DefaultTabController(
        length: 2,
        child: Padding(
          padding: EdgeInsets.symmetric(vertical: 15.w),
          child: Stack(children: [
            ShowWidget(
              delay: 400,
              child: Column(
                children: [
                  Container(
                    decoration: BoxDecoration(
                      color: Theme.of(context).colorScheme.onPrimary,
                      borderRadius: BorderRadius.circular(25),
                    ),
                    child: Padding(
                      padding: EdgeInsets.all(4.w),
                      child: TabBar(
                        indicator: BoxDecoration(
                          borderRadius: BorderRadius.circular(25),
                          color: Theme.of(context).colorScheme.onBackground,
                        ),
                        labelStyle: AppTextStyles.header1Text(
                          color: Theme.of(context).colorScheme.primary,
                        ),
                        labelColor: Theme.of(context).colorScheme.primary,
                        unselectedLabelColor: Theme.of(context).colorScheme.primary,
                        tabs: [
                          Tab(
                            text: translation(context).textHomeTokens,
                          ),
                          Tab(
                            text: translation(context).textHomeNFTs,
                          ),
                        ],
                      ),
                    ),
                  ),
                  SizedBox(height: 25.w),
                  Flexible(
                    child: TabBarView(
                      children: [
                        ListView.builder(
                          itemCount: cryptoCurrencies.length,
                          itemBuilder: (context, index) {
                            Map<String, dynamic> crypto = cryptoCurrencies[index];
                            return buildCryptocurrencyRow(
                              crypto['image'],
                              crypto['symbol'],
                              crypto['name'],
                              crypto['price'],
                              crypto['percent'],
                              context,
                            );
                          },
                        ),
                        ListView.builder(
                          itemCount: nftsCurrencies.length,
                          itemBuilder: (context, index) {
                            Map<String, dynamic> nftsCrypto = nftsCurrencies[index];
                            return buildNFTsCurrencyRow(
                              nftsCrypto['image'],
                              nftsCrypto['symbol'],
                              nftsCrypto['name'],
                              nftsCrypto['cost'],
                              nftsCrypto['price'],
                              context,
                            );
                          },
                        ),
                      ],
                    ),
                  )
                ],
              ),
            )
          ]),
        ),
      ),
    );
  }

  Widget _buildButton(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        Column(
          children: [
            Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(50),
                color: Theme.of(context).colorScheme.onPrimary,
              ),
              child: Padding(
                padding: const EdgeInsets.all(25.0),
                child: SvgPicture.asset(AppAssets.MONEY_SEND),
              ),
            ),
            SizedBox(
              height: 8.h,
            ),
            Text(
              translation(context).textHomeSend,
              style: AppTextStyles.header1Text(
                color: Theme.of(context).colorScheme.primary,
              ),
            )
          ],
        ),
        Column(
          children: [
            Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(50),
                gradient: const LinearGradient(
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                  colors: [
                    Color(0xFF0061FF),
                    Color(0xFF6100FF),
                  ],
                ),
              ),
              child: Padding(
                padding: const EdgeInsets.all(25.0),
                child: SvgPicture.asset(AppAssets.ADD),
              ),
            ),
            SizedBox(
              height: 8.h,
            ),
            Text(
              translation(context).textHomeBuy,
              style: AppTextStyles.header1Text(
                color: Theme.of(context).colorScheme.primary,
              ),
            )
          ],
        ),
        Column(
          children: [
            Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(50),
                color: Theme.of(context).colorScheme.onPrimary,
              ),
              child: Padding(
                padding: const EdgeInsets.all(25.0),
                child: SvgPicture.asset(AppAssets.MONEY_RECEIVE),
              ),
            ),
            SizedBox(
              height: 8.h,
            ),
            Text(
              translation(context).textHomeReceive,
              style: AppTextStyles.header1Text(
                color: Theme.of(context).colorScheme.primary,
              ),
            )
          ],
        ),
      ],
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

Widget buildCryptocurrencyRow(
    String imagePath, String symbol, String name, String price, double percent, BuildContext context) {
  var data = [0.0, 1.0, 1.5, 2.0, 0.0, 0.0, -0.5, -1.0, -0.5, 0.0, 0.0];
  var dataDown = [0.0, -1.0, -1.5, -2.0, 0.0, 0.0, 0.5, 1.0, 0.5, 0.0, 0.0];

  return Padding(
    padding: EdgeInsets.symmetric(vertical: 20.h),
    child: Row(
      crossAxisAlignment: CrossAxisAlignment.center,
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        SizedBox(
          width: 50.w,
          child: SvgPicture.asset(
            imagePath,
            height: 50.h,
          ),
        ),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              symbol,
              style: AppTextStyles.header1Text(
                color: Theme.of(context).colorScheme.primary,
              ),
            ),
            Text(
              name,
              style: AppTextStyles.header2Text(
                color: Theme.of(context).colorScheme.primary,
              ),
            ),
          ],
        ),
        SizedBox(
          width: 20.w,
        ),
        SizedBox(
          height: 50.h,
          width: 80.w,
          child: Sparkline(
            lineColor: percent > 0 ? Colors.lightBlue : Colors.redAccent,
            lineWidth: 4.0,
            data: percent > 0 ? data : dataDown,
            cubicSmoothingFactor: 0.2,
            useCubicSmoothing: true,
          ),
        ),
        SizedBox(
          width: 50.w,
        ),
        Column(
          children: [
            Text(
              price,
              style: AppTextStyles.header1Text(
                color:
                    percent >= 0 ? Theme.of(context).colorScheme.inversePrimary : Theme.of(context).colorScheme.error,
              ),
            ),
            Text(
              percent > 0 ? '+$percent%' : '$percent%',
              style: AppTextStyles.header1Text(
                color:
                    percent >= 0 ? Theme.of(context).colorScheme.inversePrimary : Theme.of(context).colorScheme.error,
              ),
            ),
          ],
        ),
      ],
    ),
  );
}

Widget buildNFTsCurrencyRow(
    String imagePath, String symbol, String name, String cost, double price, BuildContext context) {
  var data = [0.0, 1.0, 1.5, 2.0, 0.0, 0.0, -0.5, -1.0, -0.5, 0.0, 0.0];
  var dataDown = [0.0, -1.0, -1.5, -2.0, 0.0, 0.0, 0.5, 1.0, 0.5, 0.0, 0.0];

  return Padding(
    padding: EdgeInsets.symmetric(vertical: 20.h),
    child: Row(
      crossAxisAlignment: CrossAxisAlignment.center,
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        SizedBox(
          width: 50.w,
          child: Image.asset(
            imagePath,
            height: 50.h,
          ),
        ),
        SizedBox(
          width: 8.w,
        ),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              symbol,
              style: AppTextStyles.header1Text(
                color: Theme.of(context).colorScheme.primary,
              ),
            ),
            Text(
              name,
              style: AppTextStyles.header2Text(
                color: Theme.of(context).colorScheme.primary,
              ),
            ),
          ],
        ),
        SizedBox(
          width: 20.w,
        ),
        SizedBox(
          height: 50.h,
          width: 80.w,
          child: Sparkline(
            lineColor: price > 0 ? Colors.lightBlue : Colors.redAccent,
            lineWidth: 4.0,
            data: price > 0 ? data : dataDown,
            cubicSmoothingFactor: 0.2,
            useCubicSmoothing: true,
          ),
        ),
        SizedBox(
          width: 50.w,
        ),
        Column(
          children: [
            Text(
              cost,
              style: AppTextStyles.header1Text(
                color: price >= 0 ? Theme.of(context).colorScheme.inversePrimary : Theme.of(context).colorScheme.error,
              ),
            ),
            Text(
              price > 0 ? '+$price%' : '$price%',
              style: AppTextStyles.header1Text(
                color: price >= 0 ? Theme.of(context).colorScheme.inversePrimary : Theme.of(context).colorScheme.error,
              ),
            ),
          ],
        ),
      ],
    ),
  );
}
