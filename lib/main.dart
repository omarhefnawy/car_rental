import 'package:car_rental/core/network/local/cache_helper.dart';
import 'package:car_rental/features/auth/data/auth_repo_impl/auth_repo_impl.dart';
import 'package:car_rental/features/auth/presentation/auth_bloc/auth_cubit.dart';
import 'package:car_rental/features/auth/presentation/auth_bloc/auth_states.dart';
import 'package:car_rental/features/auth/presentation/screens/login.dart';
import 'package:car_rental/features/onboarding/presentation/screens/onboarding.dart';
import 'package:car_rental/core/splash.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:nested/nested.dart';
import 'core/service_locators/service_locator.dart';
import 'features/auth/domain/authrepo/auth_repo.dart';
import 'features/auth/presentation/screens/regester.dart';
import 'features/home/presentation/screens/home.dart';
import 'firebase_options.dart';

void main()async {
  WidgetsFlutterBinding.ensureInitialized();
  // for firebase
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  //service locator
  initServiceLocator();
  // instance of Cache helper
  await CacheHelper.init();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: <SingleChildWidget>[
       BlocProvider(create: (context) => AuthCubit(sl<AuthRepo>()),),
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        initialRoute: ("/"),
        routes: {
          "/": (context) => SplashScreen(),
          "login": (context) => SignInPage(),
          "signUp": (context) => RegisterPage(),
          "onboard": (context) => OnboardingScreen(),
          "home": (context) => HomeScreen(),
        },
      ),
    );
  }
}

