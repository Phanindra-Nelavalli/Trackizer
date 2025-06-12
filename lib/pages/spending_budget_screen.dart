import 'package:dotted_border/dotted_border.dart';
import 'package:flutter/material.dart';
import 'package:trackizer/common/App_Colors.dart';
import 'package:trackizer/models/spendings.dart';
import 'package:trackizer/widgets/custom_arc_180_painter.dart';

class SpendingBudgetScreen extends StatefulWidget {
  const SpendingBudgetScreen({super.key});

  @override
  State<SpendingBudgetScreen> createState() => _SpendingBudgetScreenState();
}

class _SpendingBudgetScreenState extends State<SpendingBudgetScreen> {
  final spendings = Spendings.dummySpendings;
  @override
  Widget build(BuildContext context) {
    final media = MediaQuery.sizeOf(context);
    return Scaffold(
      backgroundColor: AppColors.gray80,
      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: EdgeInsets.symmetric(vertical: 24, horizontal: 32),
            child: Center(
              child: Column(
                children: [
                  SizedBox(
                    height: 40,
                    child: Stack(
                      alignment: Alignment.center,
                      children: [
                        Center(
                          child: Text(
                            "Spending & Budgets",
                            style: TextStyle(
                              color: AppColors.gray30,
                              fontSize: 16,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ),
                        Positioned(
                          right: -15,
                          child: IconButton(
                            onPressed: () {},
                            splashColor: AppColors.white.withOpacity(0.2),
                            splashRadius: 24,
                            icon: Icon(
                              Icons.settings_outlined,
                              color: AppColors.gray30,
                              size: 24,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  SizedBox(height: 10),
                  Stack(
                    alignment: Alignment.bottomCenter,
                    children: [
                      SizedBox(
                        width: media.width * 0.5,
                        height: media.width * 0.35,
                        child: CustomPaint(
                          painter: CustomArc180Painter(
                            start: 0,
                            end: 50,
                            bgWidth: 9,
                            drwArcs: [
                              ArcValueModel(
                                color: AppColors.secondaryG,
                                value: 20,
                              ),
                              ArcValueModel(
                                color: AppColors.secondary,
                                value: 45,
                              ),
                              ArcValueModel(
                                color: AppColors.primary10,
                                value: 70,
                              ),
                            ],
                          ),
                        ),
                      ),
                      Column(
                        children: [
                          Text(
                            "\$8290",
                            style: TextStyle(
                              color: AppColors.white,
                              fontWeight: FontWeight.bold,
                              fontSize: 27,
                            ),
                          ),
                          SizedBox(height: 4),
                          Text(
                            "of \$2,000 budget",
                            style: TextStyle(
                              fontSize: 14,
                              color: AppColors.gray30,
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                  SizedBox(height: 40),
                  Container(
                    width: double.infinity,
                    height: 70,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(16),
                      color: AppColors.gray70.withOpacity(0.25),
                      border: Border.all(
                        color: AppColors.gray60.withOpacity(0.4),
                        width: 2,
                      ),
                    ),
                    child: Center(
                      child: Text(
                        "Your budget are on track 👍",
                        style: TextStyle(
                          color: AppColors.white,
                          fontSize: 18,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ),
                  ),
                  SizedBox(height: 16),
                  ListView.separated(
                    itemBuilder: (context, index) {
                      final category = spendings[index];
                      final remaining = category.budget - category.spent;
                      final progress = category.spent / category.budget;
                      return Container(
                        padding: EdgeInsets.all(2),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(16),
                          color: AppColors.gray70.withOpacity(0.7),
                          border: Border.all(
                            color: AppColors.gray60.withOpacity(0.4),
                            width: 2,
                          ),
                        ),
                        child: Column(
                          children: [
                            ListTile(
                              leading: Image.asset(
                                category.imageUrl,
                                width: 40,
                                height: 40,
                              ),
                              title: Text(
                                category.title,
                                style: TextStyle(
                                  color: AppColors.white,
                                  fontSize: 16,
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                              subtitle: Text(
                                "\$${category.spent} left to spend",
                                style: TextStyle(
                                  color: AppColors.gray30,
                                  fontWeight: FontWeight.w500,
                                ),
                              ),
                              trailing: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Text(
                                    "\$${remaining.toStringAsFixed(2)}",
                                    style: TextStyle(
                                      color: AppColors.white,
                                      fontSize: 18,
                                      fontWeight: FontWeight.w700,
                                    ),
                                  ),
                                  SizedBox(height: 2),
                                  Text(
                                    "of \$${category.budget}",
                                    style: TextStyle(
                                      color: AppColors.gray30,
                                      fontWeight: FontWeight.w500,
                                      fontSize: 14,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            Padding(
                              padding: EdgeInsets.only(
                                right: 16,
                                left: 16,
                                bottom: 12,
                              ),
                              child: ClipRRect(
                                borderRadius: BorderRadius.circular(6),
                                child: LinearProgressIndicator(
                                  backgroundColor: AppColors.gray60,
                                  value: progress,
                                  valueColor: AlwaysStoppedAnimation<Color>(
                                    category.color,
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                      );
                    },
                    separatorBuilder: (context, index) => SizedBox(height: 8),
                    itemCount: spendings.length,
                    shrinkWrap: true,
                    physics: NeverScrollableScrollPhysics(),
                  ),
                  SizedBox(height: 8),
                  DottedBorder(
                    options: RoundedRectDottedBorderOptions(
                      dashPattern: [5, 4],
                      strokeWidth: 2,
                      radius: Radius.circular(12),
                      color: AppColors.gray60.withOpacity(0.7),
                    ),
                    child: Container(
                      width: double.infinity,
                      height: 60,

                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(16),
                        color: AppColors.gray70.withOpacity(0.25),
                      ),
                      child: Center(
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              "Add new category",
                              style: TextStyle(
                                color: AppColors.gray30,
                                fontSize: 16,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                            SizedBox(width: 8),
                            Icon(
                              Icons.add_circle_outline,
                              color: AppColors.gray30,
                              size: 18,
                            ),
                          ],
                        ),
                      ),
                    ),
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
