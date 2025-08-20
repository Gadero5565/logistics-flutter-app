import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../core/theme/app_colours.dart';
import '../../../on_boarding/presentation/pages/on_boarding_page.dart';

class SplashPage extends StatefulWidget {
  const SplashPage({Key? key}) : super(key: key);

  @override
  State<SplashPage> createState() => _SplashPageState();
}

class _SplashPageState extends State<SplashPage> {
  @override
  void initState() {
    super.initState();
    _checkFirstLaunch();
  }

  Future<void> _checkFirstLaunch() async {
    // In a real app, check if this is first launch
    bool isFirstLaunch = true; // Get from shared prefs

    Future.delayed(const Duration(seconds: 3), () {
      if (isFirstLaunch) {
        Navigator.of(context).pushReplacement(
          MaterialPageRoute(builder: (_) => const OnboardingPage()),
        );
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [
              AppColors.primary,
              AppColors.background,
              AppColors.primaryDark,

            ],
          ),
        ),
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              // Logo and app name
              Container(
                padding: EdgeInsets.all(8.w), // Responsive padding
                child: Image.asset(
                  'assets/logo.png',
                  width: 430.w, // Responsive width
                  height: 130.h, // Responsive height

                ),
              ),
              SizedBox(height: 8.h), // Responsive spacing
              Text(
                'GetMo Requests System',
                style: TextStyle(
                  fontSize: 32.sp, // Responsive font size
                  fontWeight: FontWeight.bold,
                  color: AppColors.primaryDark,
                ),
              ),
              SizedBox(height: 8.h), // Responsive spacing
              Text(
                'Streamline Your Online Requests',
                style: TextStyle(
                  fontSize: 24.sp, // Responsive font size
                  color: AppColors.primaryDark,
                ),
              ),
              SizedBox(height: 30.h), // Responsive spacing
              SpinKitThreeBounce(
                color: Colors.white,
                size: 30.0.w, // This can be kept as is or use .w/.h if needed
              ),
            ],
          ),
        ),
      ),
    );
  }
}