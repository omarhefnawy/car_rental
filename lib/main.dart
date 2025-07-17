import 'package:car_rental/core/network/local/cache_helper.dart';
import 'package:car_rental/features/auth/presentation/auth_bloc/auth_cubit.dart';
import 'package:car_rental/features/auth/presentation/screens/login.dart';
import 'package:car_rental/features/cars/domain/carRepo/carRepo.dart';
import 'package:car_rental/features/cars/presetation/carBloc/carBloc.dart';
import 'package:car_rental/features/onboarding/presentation/screens/onboarding.dart';
import 'package:car_rental/core/splash.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:nested/nested.dart';
import 'package:device_frame/device_frame.dart'; // هنا الإضافة الجديدة
import 'core/service_locators/service_locator.dart';
import 'features/auth/domain/authrepo/auth_repo.dart';
import 'features/auth/presentation/screens/regester.dart';
import 'features/cars/presetation/screens/addCar.dart';
import 'features/home/presentation/screens/home.dart';
import 'firebase_options.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  initServiceLocator();
  await CacheHelper.init();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: <SingleChildWidget>[
        BlocProvider(create: (context) => AuthCubit(sl<AuthRepo>())),
        BlocProvider(create: (context) => CarCubit(sl<CarRepo>())),
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        initialRoute: "/",
        routes: {
          "/": (context) => wrapInDevice(const SplashScreen()),
          "login": (context) => wrapInDevice(SignInPage()),
          "signUp": (context) => wrapInDevice(RegisterPage()),
          "onboard": (context) => wrapInDevice(const OnboardingScreen()),
          "home": (context) => wrapInDevice(const HomeScreen()),
          "addCar": (context) => wrapInDevice(AddCar()),
        },
      ),
    );
  }

  /// دالة بتغلف أي شاشة داخل إطار موبايل
  Widget wrapInDevice(Widget screen) {
    return Center(
      child: DeviceFrame(
        device: Devices.android.bigPhone, // تقدر تغيّر نوع الجهاز هنا
        isFrameVisible: true,
        screen: screen,
      ),
    );
  }
}
