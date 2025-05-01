import 'package:car_rental/core/network/local/cache_helper.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    navigateto();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black54,
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Center(
              child: Image.asset('assets/splash.jpg'),
            ),
            Text("Book your dream car",style:TextStyle(color: Colors.white,fontSize: 27) ,),
          ],
        ),
      ),
    );
  }
  navigateto() async {
    await Future.delayed(Duration(milliseconds: 4000), (() {}));
    User? user = FirebaseAuth.instance.currentUser; // Check if the user is logged in
    if (user != null) {
      if (user.emailVerified) {
        // If user is verified, go to Home
        Navigator.pushReplacementNamed(context, "home");
      } else {
        // If user is not verified, show login page
        Navigator.pushReplacementNamed(context, "login");
      }
    } else {
      // If no user is logged in, show onboarding or login
      bool seenOnboarding = CacheHelper.getData(key: 'onboard') ?? false;
      Navigator.pushNamedAndRemoveUntil(
        context,
        seenOnboarding ? "login" : "onboard",
            (route) => false,
      );
    }
  }

  }

