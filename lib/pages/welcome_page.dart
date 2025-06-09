import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:trackizer/common/App_Colors.dart';
import 'package:trackizer/pages/social_login_page.dart';
import 'package:trackizer/pages/social_signup_screen.dart';
import 'package:trackizer/widgets/custom_elevated_button.dart';

class WelcomePage extends StatefulWidget {
  const WelcomePage({super.key});

  @override
  State<WelcomePage> createState() => _WelcomePageState();
}

class _WelcomePageState extends State<WelcomePage> {
  @override
  void initState() {
    super.initState();
    SystemChrome.setEnabledSystemUIMode(SystemUiMode.leanBack);
  }

  @override
  Widget build(BuildContext context) {
    final media = MediaQuery.sizeOf(context);
    return Scaffold(
      body: Stack(
        alignment: Alignment.topCenter,
        children: [
          Image.asset(
            "assets/images/welcome_screen.png",
            width: media.width,
            height: media.height,
            fit: BoxFit.cover,
          ),
          SafeArea(
            child: Padding(
              padding: EdgeInsets.symmetric(vertical: 30, horizontal: 25),
              child: Column(
                children: [
                  Image.asset(
                    "assets/images/app_logo.png",
                    width: media.width * 0.5,
                    fit: BoxFit.contain,
                  ),
                  Spacer(),
                  Text(
                    "Track your expenses effortlessly and stay on top of your finances. Simple, smart, and efficient budgeting starts here.",
                    style: TextStyle(fontSize: 16, color: AppColors.white),
                    textAlign: TextAlign.center,
                  ),
                  SizedBox(height: 40),
                  CustomElevatedButton(
                    text: "Get Started",
                    onPressed:
                        () => Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => SocialSignupScreen(),
                          ),
                        ),
                    backgroundColor: AppColors.secondary,
                    isHasShadow: true,
                  ),
                  SizedBox(height: 16),
                  CustomElevatedButton(
                    text: "I have an account",
                    onPressed:
                        () => Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => SocialLoginPage(),
                          ),
                        ),
                    backgroundColor: AppColors.gray70,
                    isHasShadow: true,
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
