// ignore_for_file: deprecated_member_use

import 'package:flutter/material.dart';
import 'package:trackizer/common/App_Colors.dart';
import 'package:trackizer/pages/sign_up_screen.dart';
import 'package:trackizer/widgets/custom_elevated_button.dart';
import 'package:trackizer/widgets/custom_text_field.dart';

class SignInScreen extends StatefulWidget {
  const SignInScreen({super.key});

  @override
  State<SignInScreen> createState() => _SignInScreenState();
}

class _SignInScreenState extends State<SignInScreen> {
  bool showPassword = false;
  bool rememberMe = false;

  @override
  Widget build(BuildContext context) {
    final media = MediaQuery.sizeOf(context);

    return Scaffold(
      backgroundColor: AppColors.gray80,
      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.symmetric(vertical: 30, horizontal: 25),
            child: Center(
              child: Column(
                children: [
                  Image.asset(
                    "assets/images/app_logo.png",
                    width: media.width * 0.5,
                    fit: BoxFit.contain,
                  ),
                  SizedBox(height: media.height*0.15),
                  Text(
                    "Sign In",
                    style: TextStyle(
                      fontSize: 32,
                      color: AppColors.secondary50,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 40),
                  CustomTextField(
                    label: "Email Address",
                    prefixIcon: Icons.email_outlined,
                    textInputType: TextInputType.emailAddress,
                    color: AppColors.gray60,
                  ),
                  const SizedBox(height: 20),
                  CustomTextField(
                    label: "Password",
                    prefixIcon: Icons.lock_outline,
                    textInputType: TextInputType.visiblePassword,
                    color: AppColors.gray60,
                    obscureText: !showPassword,
                    suffixIcon: IconButton(
                      splashRadius: 19,
                      onPressed: () {
                        setState(() {
                          showPassword = !showPassword;
                        });
                      },
                      icon: Icon(
                        showPassword
                            ? Icons.visibility_off_outlined
                            : Icons.visibility_outlined,
                        color: AppColors.gray60,
                      ),
                    ),
                  ),
                  const SizedBox(height: 16),
                  Row(
                    children: [
                      Checkbox(
                        side: BorderSide(color: AppColors.gray60),
                        value: rememberMe,
                        onChanged: (value) {
                          setState(() {
                            rememberMe = value ?? false;
                          });
                        },
                      ),
                      Text(
                        "Remember Me",
                        style: TextStyle(color: AppColors.gray50, fontSize: 15),
                      ),
                      Spacer(),
                      TextButton(
                        onPressed: () {},
                        style: TextButton.styleFrom(
                          overlayColor: AppColors.white.withOpacity(0.2),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(50),
                          ),
                        ),
                        child: Text(
                          "Forgot Password?",
                          style: TextStyle(color: AppColors.gray50, fontSize: 14),
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: 40),
                  CustomElevatedButton(
                    text: "Sign In",
                    onPressed: () {},
                    backgroundColor: AppColors.secondary,
                    isHasShadow: true,
                  ),
                  SizedBox(height: media.height*0.15),
                  Text(
                    "If you don't have an account yet?",
                    style: TextStyle(fontSize: 18, color: AppColors.white.withOpacity(0.7)),
                  ),
                  SizedBox(height: 20),
                  CustomElevatedButton(
                    text: "Sign Up",
                    onPressed:
                        () => Navigator.push(
                          context,
                          MaterialPageRoute(builder: (context) => SignUpScreen()),
                        ),
                    backgroundColor: AppColors.gray70,
                    isHasShadow: true,
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
