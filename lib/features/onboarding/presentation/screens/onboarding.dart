import 'package:car_rental/core/network/local/cache_helper.dart';
import 'package:flutter/material.dart';

class OnboardingScreen extends StatelessWidget {
  const OnboardingScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          // الخلفية (صورة السيارة)
          Positioned.fill(
            child: Image.asset(
              'assets/onboard.jpg',
              fit: BoxFit.cover,
            ),
          ),

          // المحتوى الأمامي
          Positioned.fill(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 24.0, vertical: 48),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  // اللوجو
                  Align(
                    alignment: Alignment.topCenter,
                    child: Text(
                      "TIIRA",
                      style: TextStyle(
                        fontSize: 32,
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                        letterSpacing: 4,
                      ),
                    ),
                  ),

                  // النص التسويقي
                  Column(
                    children: [
                      Container(
                        width: 40,
                        height: 4,
                        color: Colors.blueGrey[100],
                        margin: const EdgeInsets.only(bottom: 12),
                      ),
                      Text(
                        "Rent your dream car from the\nBest Company",
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          fontSize: 38,
                          color: Colors.white,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ],
                  ),

                  // زر البدء
                  ElevatedButton(
                    onPressed: () {
                      // Navigate to home or next page
                      CacheHelper.setData(key: "onboard", value: true);
                      Navigator.pushReplacementNamed(context, "login");

                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Color(0xffC64949),
                      padding: const EdgeInsets.symmetric(horizontal: 32, vertical: 14),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(30),
                      ),
                    ),
                    child: Text(
                      "Get Started >",
                      style: TextStyle(fontSize: 16),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
