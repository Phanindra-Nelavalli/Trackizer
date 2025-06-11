// ignore_for_file: deprecated_member_use

import 'package:flutter/material.dart';
import 'package:trackizer/common/App_Colors.dart';
import 'package:trackizer/pages/sign_in_screen.dart';
import 'package:trackizer/widgets/custom_elevated_button.dart';
import 'package:trackizer/widgets/custom_text_field.dart';

class SignUpScreen extends StatefulWidget {
  const SignUpScreen({super.key});

  @override
  State<SignUpScreen> createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  bool showPassword = false;
  String password = '';

  double _calculateStrength(String password) {
    if (password.isEmpty) return 0.0;
    if (password.length < 6) return 0.25;
    if (password.length < 8) return 0.5;
    if (!RegExp(r'[A-Z]').hasMatch(password)) return 0.5;
    if (!RegExp(r'[0-9]').hasMatch(password)) return 0.75;
    if (!RegExp(r'[!@#\$&*~]').hasMatch(password)) return 0.75;
    return 1.0;
  }

  String _getStrengthLabel(double strength) {
    if (strength <= 0.25) return "Weak";
    if (strength <= 0.5) return "Medium";
    if (strength <= 0.75) return "Strong";
    return "Very Strong";
  }

  Color _getStrengthColor(double strength) {
    if (strength <= 0.25) return Colors.red;
    if (strength <= 0.5) return Colors.orange;
    if (strength <= 0.75) return Colors.blue;
    return Colors.green;
  }

  @override
  Widget build(BuildContext context) {
    final media = MediaQuery.sizeOf(context);
    double strength = _calculateStrength(password);

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
                    "Sign Up",
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
                    obscureText: !showPassword,
                    color: AppColors.gray60,
                    onChanged: (val) {
                      setState(() {
                        password = val;
                      });
                    },
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
                    children: List.generate(4, (index) {
                      double threshold = (index + 1) / 4;
                      return Expanded(
                        child: Container(
                          margin: EdgeInsets.symmetric(horizontal: 2),
                          height: 6,
                          decoration: BoxDecoration(
                            color:
                                strength >= threshold
                                    ? _getStrengthColor(strength)
                                    : AppColors.gray70,
                            borderRadius: BorderRadius.circular(3),
                          ),
                        ),
                      );
                    }),
                  ),
                  const SizedBox(height: 4),
                  if (strength != 0)
                    Align(
                      alignment: Alignment.centerLeft,
                      child: Text(
                        "Password Strength: ${_getStrengthLabel(strength)}",
                        style: TextStyle(color: _getStrengthColor(strength)),
                      ),
                    ),
                  const SizedBox(height: 16),
                  Align(
                    alignment: Alignment.centerLeft,
                    child: Text(
                      "Use 8 or more characters with a mix of letters, numbers & symbols.",
                      style: TextStyle(color: AppColors.gray50, fontSize: 16),
                    ),
                  ),
                  SizedBox(height: 40),
                  CustomElevatedButton(
                    text: "Sign Up",
                    onPressed: () {},
                    backgroundColor: AppColors.secondary,
                    isHasShadow: true,
                  ),
                  SizedBox(height: media.height*0.15),
                  Text(
                    "Do you have already an account?",
                    style: TextStyle(fontSize: 18, color: AppColors.white.withOpacity(0.7)),
                  ),
                  SizedBox(height: 20),
                  CustomElevatedButton(
                    text: "Sign In",
                    onPressed:
                        () => Navigator.push(
                          context,
                          MaterialPageRoute(builder: (context) => SignInScreen()),
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
