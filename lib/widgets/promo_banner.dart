import 'package:ecommerce_app/core/constants/app_constants_assets.dart';
import 'package:flutter/material.dart';
import '../core/theme/app_color.dart';

class PromoBanner extends StatelessWidget {
  const PromoBanner({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      height: 170,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(20),
        gradient: LinearGradient(
          colors: [AppColor.primary, AppColor.secondary],
          begin: Alignment.centerRight,
          end: Alignment.centerLeft,
        ),
      ),
      child: Stack(
        children: [
          Positioned(
            top: 0,
            left: 20,
            child: Text(
              "CYBER\nLINIO",
              style: TextStyle(color: AppColor.heading, fontSize: 25, fontWeight: FontWeight.bold),
            ),
          ),
           Positioned(
            top: 85,
            left: 20,
            child: Text(
              "40% DSCT\n on echnology",
              style: TextStyle(color: AppColor.white, fontSize: 14,),
            ),
          ),
          Positioned(
            bottom: 5,
            left: 20,
            child:Container(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 10,
                      vertical: 4,
                    ),
                    decoration: BoxDecoration(
                      color: AppColor.white,
                      borderRadius: BorderRadius.circular(20),
                    ),
                    child: Text(
                      "FREE SHIPPING",
                      style: TextStyle(
                        color: AppColor.orange,
                        fontSize: 10,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),),
           Positioned(
            top: -20,
            right: 120,
            child: Image.asset(MyAppImage.rmHome, width: 120),
          ),
           Positioned(
            bottom: 60,
            right: 20,
            child: Image.asset(MyAppImage.switchImage, width: 120),
          ),
          Positioned(
            bottom: -10,
            right: 20,
            child: Image.asset(MyAppImage.headphone, width: 120),
          ),
        ],
      ),
    );
  }
}
