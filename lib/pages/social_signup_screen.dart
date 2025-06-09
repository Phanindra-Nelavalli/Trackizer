import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:trackizer/common/App_Colors.dart';
import 'package:trackizer/pages/sign_up_screen.dart';
import 'package:trackizer/widgets/custom_elevated_button.dart';

class SocialSignupScreen extends StatefulWidget {
  const SocialSignupScreen({super.key});

  @override
  State<SocialSignupScreen> createState() => _SocialSignupScreenState();
}

class _SocialSignupScreenState extends State<SocialSignupScreen> {
  @override
  Widget build(BuildContext context) {
    final media = MediaQuery.sizeOf(context);
    return Scaffold(
      backgroundColor: AppColors.gray80,
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.symmetric(vertical: 30, horizontal: 25),
          child: Center(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Image.asset(
                  "assets/images/app_logo.png",
                  width: media.width * 0.5,
                  fit: BoxFit.contain,
                ),
                Spacer(),
                CustomElevatedButton(
                  text: "Sign Up with Apple",
                  onPressed: () {},
                  backgroundColor: Colors.black,
                  isHasShadow: true,
                  icon: FontAwesomeIcons.apple,
                ),
                SizedBox(height: 16),
                CustomElevatedButton(
                  text: "Sign Up with Google",
                  onPressed: () {},
                  backgroundColor: Colors.white,
                  isHasShadow: true,
                  icon: FontAwesomeIcons.google,
                  foregroundColor: AppColors.gray80,
                ),
                SizedBox(height: 16),
                CustomElevatedButton(
                  text: "Sign Up with Facebook",
                  onPressed: () {},
                  backgroundColor: Color(0xff1771E6),
                  isHasShadow: true,
                  icon: FontAwesomeIcons.facebook,
                ),
                SizedBox(height: 40),
                Text(
                  "or",
                  style: TextStyle(
                    fontSize: 21,
                    color: AppColors.white,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                SizedBox(height: 40),
                CustomElevatedButton(
                  text: "Sign Up with Email",
                  onPressed:
                      () => Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => SignUpScreen()),
                      ),
                  backgroundColor: AppColors.gray70,
                  isHasShadow: true,
                  icon: Icons.email,
                ),
                SizedBox(height: 24),
                Text(
                  "By registering, you agree to our Terms of Use. Learn how we collect, use and share your data.",
                  style: TextStyle(color: AppColors.gray50, fontSize: 14),
                  textAlign: TextAlign.center,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
