import 'package:car_rental/features/auth/presentation/auth_bloc/auth_cubit.dart';
import 'package:car_rental/features/auth/presentation/auth_bloc/auth_states.dart';
import 'package:car_rental/features/auth/presentation/widgets/customTextButton.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../widgets/customFormField.dart';

class SignInPage extends StatefulWidget {
  SignInPage({super.key});

  @override
  State<SignInPage> createState() => _SignInPageState();
}

class _SignInPageState extends State<SignInPage> {
  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    _passwordController.dispose();
    _emailController.dispose();
  }
  final TextEditingController _emailController = TextEditingController();

  final TextEditingController _passwordController = TextEditingController();

  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
 // مفتاح للـ Form
  @override
  Widget build(BuildContext context) {
    return BlocListener<AuthCubit,AuthStates>(
      listener: (context, state) {
        if(state is AuthSuccess)
        {
          ScaffoldMessenger.of(context).showSnackBar(SnackBar(content:Text("Welcome home"),backgroundColor: Colors.green, ));
          Navigator.pushNamed(context, "home");
        }
        if(state is AuthFail)
        {
          ScaffoldMessenger.of(context).showSnackBar(SnackBar(content:Text("Error While trying to Login ${state.message}"),backgroundColor: Colors.red, ));
        }
      },
      child: Scaffold(
        backgroundColor: Colors.white,
        body: SafeArea(
          child: Center(
            child: SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 24.0, vertical: 16.0),
                child: Form(
                  key: _formKey, // ربط الـ Form بالمفتاح
                  child: Column(
                    // crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      // عنوان "Sign In"
                      const Text(
                        "Sign In",
                        style: TextStyle(
                          fontSize: 32,
                          fontWeight: FontWeight.bold,
                          color: Colors.black,
                        ),
                      ),
                      const SizedBox(height: 8),
                      Container(
                        width: 50,
                        height: 2,
                        color: Colors.blue,
                      ),
                      const SizedBox(height: 40),
                      const Text(
                        "EMAIL ",
                        style: TextStyle(
                          fontSize: 14,
                          color: Colors.black54,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                      const SizedBox(height: 8),
                      CustomTextField(
                        controller: _emailController,
                        hint: "someone@gmail.com",
                      ),
                      const SizedBox(height: 20),
                      // حقل كلمة المرور
                      const Text(
                        "PASSWORD",
                        style: TextStyle(
                          fontSize: 14,
                          color: Colors.black54,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                      const SizedBox(height: 8),
                      CustomTextField(
                        controller: _passwordController,
                        hint: "Password",
                      ),
                      const SizedBox(height: 10),
                      // رابط "Forget password?"
                      Align(
                        alignment: Alignment.centerRight,
                        child: GestureDetector(
                          onTap: () {
                            // إضافة إجراء لما يضغط على "Forget password?"
                          },
                          child: const Text(
                            "Forget password?",
                            style: TextStyle(
                              fontSize: 14,
                              color: Colors.black54,
                            ),
                          ),
                        ),
                      ),
                      const SizedBox(height: 30),
                      // زرار "Log In"
                      SizedBox(
                        width: double.infinity,
                        child: CustomButton(
                          text: "Login",
                          onPressed: () {
                            // التحقق من الإدخال باستخدام الـ Form
                            if (_formKey.currentState!.validate()) {
                              context.read<AuthCubit>().login(email: _emailController.text.trim(), password: _passwordController.text.trim());
                            }
                          },
                        ),
                      ),
                      const SizedBox(height: 20),
                      // نص "Don't Have an account yet? SIGN UP"
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          const Text(
                            "Don't Have an account yet? ",
                            style: TextStyle(
                              fontSize: 14,
                              color: Colors.black54,
                            ),
                          ),
                          GestureDetector(
                            onTap: () {
                              // إضافة إجراء لما يضغط على "SIGN UP"
                              Navigator.pushNamed(context, "signUp");
                            },
                            child: const Text(
                              "SIGN UP",
                              style: TextStyle(
                                fontSize: 14,
                                color: Colors.yellow,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}