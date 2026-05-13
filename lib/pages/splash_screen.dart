import 'package:ecommerce_app/core/constants/app_constants_assets.dart';
import 'package:ecommerce_app/core/theme/app_color.dart';
// import 'package:ecommerce_app/pages/home_screen.dart';
// import 'package:ecommerce_app/pages/login_screen.dart';
import 'package:ecommerce_app/core/utils/routes.dart';
// import 'package:ecommerce_app/pages/register.screen.dart';
import 'package:flutter/material.dart';
import 'package:ecommerce_app/widgets/custom_button.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();

    Future.delayed(const Duration(seconds: 3), () {
      if (!mounted) return;
      Navigator.pushNamed(context, Routes.main);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        width: double.infinity,
        height: double.infinity,

        // Gradient Background
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [AppColor.secondary, AppColor.primary],
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
          ),
        ),

        child: Stack(
          children: [
            //TEXT (TOP LEFT)
            Positioned(
              top: 100,
              left: 20,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "CYBER\nLINIO",
                    style: TextStyle(
                      color: AppColor.heading,
                      fontSize: 40,
                      fontWeight: FontWeight.bold,
                    ),
                  ),

                  const SizedBox(height: 10),

                  Text(
                    "40% DSCT\nin technology",
                    style: TextStyle(color: AppColor.white, fontSize: 16),
                  ),

                  const SizedBox(height: 10),

                  Container(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 12,
                      vertical: 6,
                    ),
                    decoration: BoxDecoration(
                      color: AppColor.white,
                      borderRadius: BorderRadius.circular(20),
                    ),
                    child: Text(
                      "FREE SHIPPING",
                      style: TextStyle(
                        color: AppColor.orange,
                        fontSize: 12,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ],
              ),
            ),

            Positioned(
              top: 100,
              right: 60,
              child: Image.asset(MyAppImage.gold, width: 210, height: 200),
            ),

            /// IMAGES ()
            Center(
              child: SizedBox(
                width: 350,
                height: 500,
                child: Stack(
                  alignment: Alignment.center,
                  children: [
                    Positioned(
                      top: 80,
                      right: 20,
                      child: Image.asset(MyAppImage.setphone, width: 140),
                    ),

                    //TV
                    Positioned(
                      top: 130,
                      left: 0,
                      child: Image.asset(MyAppImage.tvImage, width: 250),
                    ),

                    Positioned(
                      bottom: 80,
                      left: 90,
                      child: Image.asset(MyAppImage.switchImage, width: 190),
                    ),

                    Positioned(
                      bottom: 40,
                      right: 5,
                      child: Image.asset(MyAppImage.remoteImage, width: 150),
                    ),

                    Positioned(
                      bottom: 30,
                      left: 60,
                      child: Image.asset(MyAppImage.headphone, width: 110),
                    ),

                    Positioned(
                      top: 200,
                      left: 0,
                      child: Image.asset(MyAppImage.tyre, width: 180),
                    ),
                  ],
                ),
              ),
            ),
            CircularProgressIndicator(),
            Positioned(
              bottom: 150,
              left: 20,
              child: Text(
                "*Valid from 27/03 to 01/04 2022. Min stock: 1 unit",
                style: TextStyle(color: AppColor.white, fontSize: 12),
              ),
            ),
            //LOGIN BUTTON
            Positioned(
              bottom: 80,
              left: 20,
              right: 20,
              child: CustomButton(
                onPressed: () {
                  // Navigate to LoginScreen
                  Navigator.pushReplacementNamed(context, Routes.login);
                },
                text: "LOG IN",
                textColor: AppColor.orange,
                backgroundColor: AppColor.white,
              ),
            ),

            //SKIP
            Positioned(
              bottom: 30,
              left: 0,
              right: 0,
              child: Center(
                child: TextButton(
                  onPressed: () {
                    // Navigate to HomeScreen
                    Navigator.pushNamed(context, Routes.main);
                  },
                  child: Text(
                    "SKIP",
                    style: TextStyle(color: AppColor.white, fontSize: 14),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
