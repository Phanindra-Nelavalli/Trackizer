import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:trackizer/common/App_Colors.dart';
import 'package:trackizer/pages/subscription_details_screen.dart';
import 'package:trackizer/widgets/custom_elevated_button.dart';
import 'package:trackizer/widgets/custom_text_field.dart';

class AddNewSubscription extends StatefulWidget {
  const AddNewSubscription({super.key});

  @override
  State<AddNewSubscription> createState() => _AddNewSubscriptionState();
}

class _AddNewSubscriptionState extends State<AddNewSubscription> {
  List subArr = [
    {"name": "HBO GO", "icon": "assets/images/hbo_logo.png"},
    {"name": "Spotify", "icon": "assets/images/spotify_logo.png"},
    {"name": "YouTube\nPremium", "icon": "assets/images/youtube_logo.png"},
    {"name": "Microsoft\nOneDrive", "icon": "assets/images/onedrive_logo.png"},
    {"name": "NetFlix", "icon": "assets/images/netflix_logo.png"},
  ];

  double amountVal = 0.09;
  final TextEditingController _amountController = TextEditingController();
  final TextEditingController _descriptionController = TextEditingController();

  @override
  void initState() {
    super.initState();
    _amountController.text = amountVal.toStringAsFixed(2);
  }

  void _amountInc() {
    setState(() {
      amountVal += 0.1;
      _amountController.text = amountVal.toStringAsFixed(2);
    });
  }

  void _amountDec() {
    setState(() {
      amountVal = (amountVal - 0.1).clamp(0.0, double.infinity);
      _amountController.text = amountVal.toStringAsFixed(2);
    });
  }

  @override
  Widget build(BuildContext context) {
    final media = MediaQuery.sizeOf(context);
    return Scaffold(
      appBar: AppBar(
        backgroundColor: AppColors.gray70.withOpacity(0.8),
        elevation: 0,
        title: const Text("Subscription"),
        centerTitle: true,
        titleTextStyle: const TextStyle(fontSize: 16),
      ),
      backgroundColor: AppColors.gray80,
      body: SingleChildScrollView(
        child: SafeArea(
          child: Column(
            children: [
              Container(
                padding: const EdgeInsets.symmetric(vertical: 24),
                decoration: BoxDecoration(
                  borderRadius: const BorderRadius.vertical(
                    bottom: Radius.circular(24),
                  ),
                  color: AppColors.gray70.withOpacity(0.8),
                ),
                child: Center(
                  child: Column(
                    children: [
                      Text(
                        "Add new\nsubscription",
                        style: TextStyle(
                          color: AppColors.white,
                          fontWeight: FontWeight.bold,
                          fontSize: 42,
                        ),
                        textAlign: TextAlign.center,
                      ),
                      const SizedBox(height: 40),
                      SizedBox(
                        width: double.infinity,
                        height: media.width * 0.6,
                        child: CarouselSlider.builder(
                          itemCount: subArr.length,
                          itemBuilder: (context, itemIndex, pageViewIndex) {
                            final sObj = subArr[itemIndex] as Map? ?? {};
                            return Container(
                              margin: const EdgeInsets.all(10),
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Image.asset(
                                    sObj["icon"],
                                    height: media.width * 0.35,
                                    width: media.width * 0.35,
                                    fit: BoxFit.fitHeight,
                                  ),
                                  const SizedBox(height: 14),
                                  Text(
                                    sObj["name"],
                                    style: TextStyle(
                                      color: AppColors.white,
                                      fontSize: 18,
                                      fontWeight: FontWeight.w600,
                                    ),
                                  ),
                                ],
                              ),
                            );
                          },
                          options: CarouselOptions(
                            autoPlay: false,
                            enlargeCenterPage: true,
                            aspectRatio: 1,
                            enableInfiniteScroll: true,
                            viewportFraction: 0.61,
                            enlargeFactor: 0.4,
                            enlargeStrategy: CenterPageEnlargeStrategy.zoom,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(
                  vertical: 24,
                  horizontal: 20,
                ),
                child: Center(
                  child: Column(
                    children: [
                      Text(
                        "Description",
                        style: TextStyle(
                          color: AppColors.gray10.withOpacity(0.5),
                          fontSize: 16,
                        ),
                      ),
                      const SizedBox(height: 8),
                      CustomTextField(
                        label: "",
                        controller: _descriptionController,
                        color: AppColors.gray10.withOpacity(0.5),
                      ),
                      const SizedBox(height: 25),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          GestureDetector(
                            onTap: _amountDec,
                            child: Container(
                              height: 56,
                              width: 56,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(16),
                                color: AppColors.gray10.withOpacity(0.1),
                                boxShadow: [
                                  BoxShadow(
                                    color: Colors.white.withOpacity(0.03),
                                    blurRadius: 12,
                                    offset: const Offset(0, 2),
                                  ),
                                ],
                              ),
                              child: Icon(
                                Icons.remove,
                                size: 32,
                                color: AppColors.white,
                              ),
                            ),
                          ),
                          Column(
                            children: [
                              Text(
                                "Monthly Price",
                                style: TextStyle(
                                  color: AppColors.gray10.withOpacity(0.5),
                                  fontSize: 14,
                                ),
                              ),
                              const SizedBox(height: 8),
                              IntrinsicWidth(
                                child: Row(
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: [
                                    Text(
                                      "\$",
                                      style: TextStyle(
                                        color: AppColors.white,
                                        fontSize: 27,
                                        fontWeight: FontWeight.w800,
                                      ),
                                    ),
                                    SizedBox(width: 4),
                                    Expanded(
                                      child: TextField(
                                        controller: _amountController,

                                        keyboardType:
                                            const TextInputType.numberWithOptions(
                                              decimal: true,
                                            ),
                                        textAlign: TextAlign.center,
                                        style: TextStyle(
                                          color: AppColors.white,
                                          fontSize: 32,
                                          fontWeight: FontWeight.w700,
                                        ),
                                        decoration: const InputDecoration(
                                          border: InputBorder.none,
                                          contentPadding: EdgeInsets.zero,
                                        ),
                                        onChanged: (value) {
                                          setState(() {
                                            amountVal =
                                                double.tryParse(value) ?? 0.0;
                                          });
                                        },
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              const SizedBox(height: 8),
                              Container(
                                width: 150,
                                height: 1,
                                color: AppColors.gray10.withOpacity(0.3),
                              ),
                            ],
                          ),
                          GestureDetector(
                            onTap: _amountInc,
                            child: Container(
                              height: 56,
                              width: 56,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(16),
                                color: AppColors.gray10.withOpacity(0.1),
                                boxShadow: [
                                  BoxShadow(
                                    color: Colors.white.withOpacity(0.02),
                                    blurRadius: 4,
                                    offset: const Offset(0, 2),
                                  ),
                                ],
                              ),
                              child: Icon(
                                Icons.add,
                                size: 32,
                                color: AppColors.white,
                              ),
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 45),
                      CustomElevatedButton(
                        text: "Add this platform",
                        onPressed:
                            () => showDialog(
                              context: context,
                              builder:
                                  (context) =>
                                       SubscriptionDetailsScreen(),
                            ),
                        backgroundColor: AppColors.secondary,
                        isHasShadow: true,
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
