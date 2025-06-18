import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:trackizer/common/App_Colors.dart';
import 'package:trackizer/models/subscriptions.dart';
import 'package:trackizer/widgets/custom_elevated_button.dart';
import 'package:trackizer/widgets/item_row.dart';

class SubscriptionInfo extends StatefulWidget {
  final Subscriptions subscriptions;
  const SubscriptionInfo({super.key, required this.subscriptions});

  @override
  State<SubscriptionInfo> createState() => _SubscriptionInfoState();
}

class _SubscriptionInfoState extends State<SubscriptionInfo> {
  late String title;
  late String? description;
  late SubscriptionCategory category;
  late SubscriptionPeriod period;
  late String price;
  late DateTime startDate;

  late DateTime endDate;
  DateTime? customDate;

  @override
  void initState() {
    super.initState();
    title = widget.subscriptions.title;
    description = widget.subscriptions.description;
    category = widget.subscriptions.category;
    period = widget.subscriptions.period;
    startDate = widget.subscriptions.startDate;
    endDate = widget.subscriptions.endDate;
    price = widget.subscriptions.price.toStringAsFixed(2);
  }

  Future<void> _editText(
    String label,
    String initialValue,
    Function(String) onConfirm,
  ) async {
    final controller = TextEditingController(text: initialValue);
    await showDialog(
      context: context,
      builder:
          (context) => AlertDialog(
            backgroundColor: AppColors.gray70,
            title: Text("Edit $label", style: TextStyle(color: Colors.white)),
            content: TextField(
              controller: controller,
              style: TextStyle(color: Colors.white),
              decoration: InputDecoration(
                hintText: "Enter $label",
                hintStyle: TextStyle(color: AppColors.gray30),
                focusColor: AppColors.secondary,
                enabledBorder: UnderlineInputBorder(
                  borderSide: BorderSide(
                    color: AppColors.white.withOpacity(0.8),
                  ),
                ),
                focusedBorder: UnderlineInputBorder(
                  borderSide: BorderSide(color: AppColors.secondary),
                ),
              ),
            ),
            actions: [
              TextButton(
                onPressed: () => Navigator.pop(context),
                child: Text("Cancel", style: TextStyle(color: Colors.white)),
              ),
              TextButton(
                onPressed: () {
                  onConfirm(controller.text.trim());
                  Navigator.pop(context);
                },
                style: TextButton.styleFrom(
                  padding: EdgeInsets.symmetric(horizontal: 6, vertical: 4),
                  backgroundColor: AppColors.secondary,
                ),
                child: Text(
                  "Save",
                  style: TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
            ],
          ),
    );
  }

  Future<void> _selectDate() async {
    final picked = await showDatePicker(
      context: context,
      initialDate: startDate,
      firstDate: DateTime(2000),
      lastDate: DateTime(2100),
    );
    if (picked != null) {
      setState(() {
        startDate = picked;
        endDate = Subscriptions.calculateEndDate(startDate, period, customDate);
      });
    }
  }

  Future<void> _selectCategory() async {
    final selected = await showModalBottomSheet<SubscriptionCategory>(
      context: context,
      backgroundColor: AppColors.gray70,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(24)),
      ),
      builder:
          (_) => SingleChildScrollView(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children:
                  SubscriptionCategory.values.map((cat) {
                    return ListTile(
                      title: Text(
                        cat.name,
                        style: TextStyle(color: Colors.white),
                      ),
                      onTap: () => Navigator.pop(context, cat),
                    );
                  }).toList(),
            ),
          ),
    );
    if (selected != null) {
      setState(() => category = selected);
    }
  }

  Future<void> _selectPeriod() async {
    final selected = await showModalBottomSheet<SubscriptionPeriod>(
      context: context,
      backgroundColor: AppColors.gray70,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(24)),
      ),
      builder:
          (_) => SingleChildScrollView(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children:
                  SubscriptionPeriod.values.map((periodOption) {
                    return ListTile(
                      title: Text(
                        periodOption.name,
                        style: TextStyle(color: Colors.white),
                      ),
                      onTap: () => Navigator.pop(context, periodOption),
                    );
                  }).toList(),
            ),
          ),
    );
    if (selected != null) {
      setState(() {
        period = selected;

        if (period == SubscriptionPeriod.Custom) {
          _pickCustomDate();
        } else {
          customDate = null;
          endDate = Subscriptions.calculateEndDate(
            startDate,
            period,
            customDate,
          );
        }
      });
    }
  }

  Future<void> _pickCustomDate() async {
    final picked = await showDatePicker(
      context: context,
      initialDate: startDate,
      firstDate: startDate,
      lastDate: DateTime(2100),
    );

    if (picked != null) {
      setState(() {
        customDate = picked;
        endDate = Subscriptions.calculateEndDate(startDate, period, customDate);
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    final media = MediaQuery.sizeOf(context);
    return Scaffold(
      backgroundColor: AppColors.gray,
      body: SingleChildScrollView(
        child: SafeArea(
          child: Container(
            margin: EdgeInsets.all(20),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(24),
              color: Color(0xff282833),
            ),
            child: Stack(
              children: [
                Column(
                  children: [
                    ClipRRect(
                      borderRadius: BorderRadius.vertical(
                        top: Radius.circular(24),
                      ),
                      child: Material(
                        color: AppColors.gray70,
                        child: Container(
                          height: media.width,
                          padding: EdgeInsets.symmetric(
                            horizontal: 8,
                            vertical: 8,
                          ),
                          child: Column(
                            children: [
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  IconButton(
                                    onPressed: () => Navigator.pop(context),
                                    splashRadius: 26,
                                    icon: Icon(
                                      Icons.arrow_back_ios_new_rounded,
                                      size: 24,
                                      color: AppColors.gray30,
                                    ),
                                  ),
                                  Text(
                                    "Subscriptions Info",
                                    style: TextStyle(
                                      color: AppColors.gray30,
                                      fontSize: 18,
                                      fontWeight: FontWeight.w500,
                                    ),
                                  ),
                                  IconButton(
                                    onPressed: () {},
                                    splashRadius: 26,
                                    icon: Icon(
                                      CupertinoIcons.delete,
                                      size: 24,
                                      color: AppColors.gray30,
                                    ),
                                  ),
                                ],
                              ),
                              Spacer(),
                              Image.asset(
                                widget.subscriptions.imageUrl,
                                height: 120,
                                width: 120,
                              ),
                              const SizedBox(height: 20),
                              Text(
                                title,
                                style: TextStyle(
                                  color: AppColors.white,
                                  fontSize: 32,
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                              const SizedBox(height: 8),
                              Text(
                                "\$$price",
                                style: TextStyle(
                                  color: AppColors.gray30,
                                  fontSize: 24,
                                  fontWeight: FontWeight.w700,
                                ),
                              ),
                              Spacer(),
                            ],
                          ),
                        ),
                      ),
                    ),
                    Container(
                      padding: EdgeInsets.symmetric(
                        vertical: 20,
                        horizontal: 20,
                      ),
                      child: Column(
                        children: [
                          Container(
                            width: double.infinity,
                            padding: const EdgeInsets.symmetric(vertical: 10),
                            decoration: BoxDecoration(
                              border: Border.all(
                                color: AppColors.border.withOpacity(0.1),
                              ),
                              color: AppColors.gray60.withOpacity(0.2),
                              borderRadius: BorderRadius.circular(16),
                            ),
                            child: Column(
                              children: [
                                ItemRow(title: "Name", value: title),
                                GestureDetector(
                                  onTap:
                                      () => _editText(
                                        "Description",
                                        description ?? "",
                                        (val) =>
                                            setState(() => description = val),
                                      ),
                                  child: ItemRow(
                                    title: "Description",
                                    value: description ?? "None",
                                  ),
                                ),
                                GestureDetector(
                                  onTap: _selectCategory,
                                  child: ItemRow(
                                    title: "Category",
                                    value: category.name,
                                  ),
                                ),
                                GestureDetector(
                                  onTap: _selectDate,
                                  child: ItemRow(
                                    title: "First Payment",
                                    value: DateFormat(
                                      'dd.MM.yyyy',
                                    ).format(startDate),
                                  ),
                                ),
                                GestureDetector(
                                  onTap: _selectPeriod,
                                  child: ItemRow(
                                    title: "Subscription Period",
                                    value: period.name,
                                  ),
                                ),
                                ItemRow(
                                  title: "End Date",
                                  value: DateFormat(
                                    'dd.MM.yyyy',
                                  ).format(endDate),
                                ),
                                GestureDetector(
                                  onTap:
                                      () => _editText(
                                        "Price",
                                        price,
                                        (val) =>
                                            setState(() => price = val),
                                      ),
                                  child: ItemRow(
                                    title: "Price",
                                    value: "\$$price",
                                  ),
                                ),
                              ],
                            ),
                          ),
                          const SizedBox(height: 25),
                          CustomElevatedButton(
                            text: "Save",
                            onPressed: () {
                              ScaffoldMessenger.of(context).showSnackBar(
                                SnackBar(
                                  content: Text("Subscription updated!"),
                                  duration: Duration(microseconds: 100),
                                ),
                              );
                            },
                            backgroundColor: AppColors.gray70,
                            isHasShadow: false,
                            elevation: 0,
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
