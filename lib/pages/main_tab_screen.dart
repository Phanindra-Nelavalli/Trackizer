import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:trackizer/common/App_Colors.dart';
import 'package:trackizer/pages/calender_screen.dart';
import 'package:trackizer/pages/home_screen.dart';
import 'package:trackizer/pages/payment_cards_screen.dart';
import 'package:trackizer/pages/spending_budget_screen.dart';

class MainTabScreen extends StatefulWidget {
  const MainTabScreen({super.key});

  @override
  State<MainTabScreen> createState() => _MainTabScreenState();
}

class _MainTabScreenState extends State<MainTabScreen> {
  int _currentIndex = 0;
  List<Widget> screens = [
    HomeScreen(),
    SpendingBudgetScreen(),
    Scaffold(),
    CalenderScreen(),
    PaymentCardsScreen(),
  ];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          setState(() {
            _currentIndex = 2;
          });
        },
        shape: CircleBorder(),
        backgroundColor: AppColors.secondary,
        child: Icon(Icons.add, size: 30),
      ),
      backgroundColor: AppColors.gray80,
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      bottomNavigationBar: BottomAppBar(
        shape: const CircularNotchedRectangle(),
        notchMargin: 10,
        height: 70,
        color: AppColors.gray70,
        elevation: 1,
        clipBehavior: Clip.antiAliasWithSaveLayer,
        padding: EdgeInsets.symmetric(horizontal: 10),
        child: Align(
          alignment: Alignment.center,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            mainAxisSize: MainAxisSize.max,
            children: [
              IconButton(
                onPressed: () {
                  setState(() {
                    _currentIndex = 0;
                  });
                },
                icon: Icon(
                  CupertinoIcons.home,
                  size: 25,
                  color:
                      _currentIndex == 0
                          ? AppColors.white
                          : Colors.grey.shade400,
                ),
              ),
              IconButton(
                onPressed: () {
                  setState(() {
                    _currentIndex = 1;
                  });
                },
                icon: Icon(
                  CupertinoIcons.square_grid_2x2,
                  size: 25,
                  color:
                      _currentIndex == 1
                          ? AppColors.white
                          : Colors.grey.shade400,
                ),
              ),
              const SizedBox(width: 15),
              IconButton(
                onPressed: () {
                  setState(() {
                    _currentIndex = 3;
                  });
                },
                icon: Icon(
                  CupertinoIcons.calendar,
                  size: 25,
                  color:
                      _currentIndex == 3
                          ? AppColors.white
                          : Colors.grey.shade400,
                ),
              ),
              IconButton(
                onPressed: () {
                  setState(() {
                    _currentIndex = 4;
                  });
                },
                icon: Icon(
                  Icons.wallet_rounded,
                  size: 25,
                  color:
                      _currentIndex == 4
                          ? AppColors.white
                          : Colors.grey.shade400,
                ),
              ),
            ],
          ),
        ),
      ),
      body: screens[_currentIndex],
    );
  }
}
