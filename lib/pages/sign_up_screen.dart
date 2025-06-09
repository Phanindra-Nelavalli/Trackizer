// ignore_for_file: deprecated_member_use

import 'package:flutter/material.dart';
import 'package:trackizer/common/App_Colors.dart';
import 'package:trackizer/widgets/custom_text_field.dart';

class SignUpScreen extends StatefulWidget {
  const SignUpScreen({super.key});

  @override
  State<SignUpScreen> createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  bool showPassword = false;
  @override
  Widget build(BuildContext context) {
    final media = MediaQuery.sizeOf(context);
    return Scaffold(
      backgroundColor: AppColors.gray80,
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.symmetric(vertical: 20, horizontal: 25),
          child: Center(
            child: Column(
              children: [
                Image.asset(
                  "assets/images/app_logo.png",
                  width: media.width * 0.5,
                  fit: BoxFit.contain,
                ),
                Spacer(),
                Text(
                  "Sign Up",
                  style: TextStyle(
                    fontSize: 32,
                    color: AppColors.secondary50,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                SizedBox(height: 40),
                CustomTextField(
                  label: "Email Address",
                  prefixIcon: Icons.email_outlined,
                  textInputType: TextInputType.emailAddress,
                ),
                SizedBox(height: 20),
                CustomTextField(
                  label: "Password",
                  prefixIcon: Icons.lock_outline,
                  textInputType: TextInputType.visiblePassword,
                  obscureText: !showPassword,
                  suffixIcon: IconButton(
                    splashRadius: 19,
                    onPressed: () {
                      setState(() {
                        showPassword = !showPassword;
                      });
                    },
                    style: IconButton.styleFrom(),
                    icon: Icon(
                      showPassword
                          ? Icons.visibility_off_outlined
                          : Icons.visibility_outlined,
                      color: AppColors.white.withOpacity(0.8),
                    ),
                  ),
                ),
                SizedBox(height: 16),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
