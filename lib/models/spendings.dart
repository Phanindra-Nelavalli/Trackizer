import 'package:flutter/material.dart';

class Spendings {
  final String title;
  final String imageUrl;
  final double budget;
  final double spent;
  final Color color;

  Spendings({
    required this.title,
    required this.imageUrl,
    required this.budget,
    required this.spent,
    required this.color,
  });
  static final List<Spendings> dummySpendings = [
    Spendings(
      title: "Auto & Transport",
      imageUrl: "assets/images/auto_&_transport.png",
      budget: 400,
      spent: 375,
      color: Color(0xffFFA699),
    ),
    Spendings(
      title: "Entertainment",
      imageUrl: "assets/images/entertainment.png",
      budget: 600,
      spent: 550,
      color: Color(0xffAD7BFF),
    ),
    Spendings(
      title: "Security",
      imageUrl: "assets/images/security.png",
      budget: 600,
      spent: 420,
      color: Color(0xff7DFFEE),
    ),
  ];
}
