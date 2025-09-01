import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get_it/get_it.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../../../core/theme/app_colours.dart';
import '../../../auth/login/presentation/pages/login_page.dart';
import '../../../on_boarding/presentation/pages/on_boarding_page.dart';

class SplashPage extends StatefulWidget {
  const SplashPage({Key? key}) : super(key: key);

  @override
  State<SplashPage> createState() => _SplashPageState();
}

class _SplashPageState extends State<SplashPage> {

  final SharedPreferences prefs = GetIt.instance<SharedPreferences>();


  @override
  void initState() {
    super.initState();
    _checkFirstLaunch();
  }

  Future<void> _checkFirstLaunch() async {
    // Check if it's first launch
    final bool isFirstLaunch = prefs.getBool('isFirstLaunch') ?? true;

    Future.delayed(const Duration(seconds: 3), () {
      if (isFirstLaunch) {
        // Set flag to false and navigate to onboarding
        prefs.setBool('isFirstLaunch', false);
        Navigator.of(context).pushReplacement(
          MaterialPageRoute(builder: (_) => const OnboardingPage()),
        );
      } else {
        // Navigate directly to login if not first launch
        Navigator.of(context).pushReplacement(
          MaterialPageRoute(builder: (_) => const LoginScreen()),
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