import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:tft_app/resources/text_style.dart';

class Slide extends StatefulWidget {
  const Slide({
    super.key,
    required this.title,
    required this.des,
    required this.image,
  });
  final String title;
  final String des;
  final String image;

  @override
  State<Slide> createState() => _SlideState();
}

class _SlideState extends State<Slide> {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Expanded(
          child: Image.asset(
            widget.image,
            fit: BoxFit.contain,
          ),
        ),
        Padding(
          padding: EdgeInsets.symmetric(vertical: 15.h),
          child: SizedBox(
            child: Column(
              children: [
                Text(
                  widget.title,
                  style: AppTextStyles.header1Text(
                    color: Theme.of(context).colorScheme.primary,
                  ),
                ),
                SizedBox(
                  height: 10.h,
                ),
                Text(
                  widget.des,
                  textAlign: TextAlign.center,
                  style: AppTextStyles.header1Text(
                    color: Theme.of(context).colorScheme.primary,
                    fontWeight: FontWeight.w400,
                  ),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}
