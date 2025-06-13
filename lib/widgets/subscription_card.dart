// ignore_for_file: deprecated_member_use

import 'package:flutter/material.dart';
import 'package:trackizer/common/App_Colors.dart';
import 'package:trackizer/models/subscriptions.dart';

class SubscriptionCard extends StatelessWidget {
  final Subscriptions subscription;
  const SubscriptionCard({super.key, required this.subscription});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {},
      child: Container(
        width: double.infinity,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(12),
          color: AppColors.gray70.withOpacity(0.8),
        ),
        padding: EdgeInsets.symmetric(horizontal: 20, vertical: 16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Image.asset(subscription.imageUrl, width: 50, height: 50),
            SizedBox(height: 40),
            Text(
              subscription.title,
              style: TextStyle(
                color: AppColors.white,
                fontSize: 17,
                fontWeight: FontWeight.w800,
              ),
            ),
            SizedBox(height: 8),
            Text(
              "\$${subscription.price}",
              style: TextStyle(
                color: AppColors.white,
                fontSize: 18,
                fontWeight: FontWeight.w600,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
