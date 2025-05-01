import 'package:car_rental/features/auth/presentation/auth_bloc/auth_cubit.dart';
import 'package:car_rental/features/auth/presentation/auth_bloc/auth_states.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../widgets/customFormField.dart';
import '../widgets/customTextButton.dart';
class RegisterPage extends StatefulWidget {
  RegisterPage({super.key});

  @override
  State<RegisterPage> createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    _emailController.dispose();
    _passwordController.dispose();
    _nameController.dispose();
  }
  final TextEditingController _nameController = TextEditingController();

  final TextEditingController _emailController = TextEditingController();

  final TextEditingController _passwordController = TextEditingController();

  final _form= GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return BlocListener<AuthCubit,AuthStates>(
      listener: (context, state) {
        if(state is SignUpSuccess)
          {
            ScaffoldMessenger.of(context).showSnackBar(SnackBar(content:Text("Check you Inbox and verify your Email0"),backgroundColor: Colors.green, ));
            Navigator.pushNamed(context, "login");
          }
        if(state is AuthFail)
        {
          ScaffoldMessenger.of(context).showSnackBar(SnackBar(content:Text("Error While trying to sign up ${state.message}"),backgroundColor: Colors.red, ));
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
                  key: _form,
                  child: Column(
                    // crossAxisAlignment: CrossAxisAlignment.start,
                    // mainAxisAlignment: MainAxisAlignment.center,
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      // عنوان "Register"
                      const Text(
                        "Register",
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
                      // حقل الاسم
                      const Text(
                        "FULL NAME",
                        style: TextStyle(
                          fontSize: 14,
                          color: Colors.black54,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                      const SizedBox(height: 8),
                      CustomTextField(
                        controller: _nameController,
                        hint: "Enter your full name",
                      ),
                      const SizedBox(height: 20),
                      // حقل الإيميل
                      const Text(
                        "EMAIL",
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
                      const SizedBox(height: 30),
                      // زرار "Register"
                      SizedBox(
                        width: double.infinity,
                        child: CustomButton(
                          text: "Register",
                          onPressed: () {
                            if(_form.currentState!.validate())
                              {
                                context.read<AuthCubit>().signUp(email: _emailController.text.trim(), password: _passwordController.text.trim());
                              }

                          },
                        ),
                      ),

                      // نص "Already have an account? Sign In"
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          const Text(
                            "Already have an account? ",
                            style: TextStyle(
                              fontSize: 14,
                              color: Colors.black54,
                            ),
                          ),
                          GestureDetector(
                            onTap: () {
                              Navigator.pushNamed(context, "login");
                              // إضافة إجراء للانتقال لصفحة تسجيل الدخول
                            },
                            child: const Text(
                              "Sign In",
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