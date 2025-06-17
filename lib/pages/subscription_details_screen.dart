import 'package:flutter/material.dart';
import 'package:trackizer/common/App_Colors.dart';
import 'package:trackizer/models/subscriptions.dart';

class SubscriptionDetailsScreen extends StatefulWidget {
  const SubscriptionDetailsScreen({super.key});

  @override
  State<SubscriptionDetailsScreen> createState() =>
      _SubscriptionDetailsScreenState();
}

class _SubscriptionDetailsScreenState extends State<SubscriptionDetailsScreen> {
  final _formKey = GlobalKey<FormState>();
  final _firstPaymentController = TextEditingController();
  final _customEndDateController = TextEditingController();

  SubscriptionPeriod? _selectedPeriod;
  SubscriptionType? _selectedType;

  DateTime? _startDate;
  // ignore: unused_field
  DateTime? _endDate;

  InputDecoration getInputDecoration(String label) {
    return InputDecoration(
      labelText: label,
      labelStyle: TextStyle(color: AppColors.gray30),
      filled: true,
      fillColor: AppColors.gray70.withOpacity(0.6),
      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(10),
        borderSide: BorderSide(color: AppColors.gray60),
      ),
      enabledBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(10),
        borderSide: BorderSide(color: AppColors.gray60),
      ),
      focusedBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(10),
        borderSide: BorderSide(color: AppColors.secondary.withOpacity(0.7)),
      ),
    );
  }

  String formatDate(DateTime date) {
    return "${date.day.toString().padLeft(2, '0')}/${date.month.toString().padLeft(2, '0')}/${date.year}";
  }

  void _showDatePicker(
    TextEditingController controller, {
    required bool isStart,
  }) async {
    FocusScope.of(context).unfocus();
    if (!isStart && _startDate == null) {
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(SnackBar(content: Text("Please select Start Date first")));
      return;
    }

    final picked = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(2020),
      lastDate: DateTime(2100),
      builder: (context, child) {
        return Theme(
          data: Theme.of(context).copyWith(
            colorScheme: ColorScheme.light(
              primary: AppColors.secondary,
              onPrimary: Colors.white,
              onSurface: Colors.black,
            ),
            dialogBackgroundColor: AppColors.gray80,
            textTheme: const TextTheme(
              titleLarge: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
              bodyLarge: TextStyle(fontSize: 20),
              bodyMedium: TextStyle(fontSize: 18),
            ),
          ),
          child: child!,
        );
      },
    );

    if (picked != null) {
      controller.text = formatDate(picked);
      setState(() {
        if (isStart) {
          _startDate = picked;
          if (_selectedPeriod != SubscriptionPeriod.Custom) {
            _updateEndDate();
          }
        } else {
          _endDate = picked;
        }
      });
    }
  }

  void _updateEndDate() {
    if (_startDate == null || _selectedPeriod == null) return;

    try {
      DateTime endDate = Subscriptions.calculateEndDate(
        _startDate!,
        _selectedPeriod!,
        null,
      );

      _endDate = endDate;
      _customEndDateController.text = formatDate(endDate);
    } catch (e) {
      print("Error calculating end date: $e");
      _customEndDateController.clear();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Dialog(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      backgroundColor: AppColors.gray80,
      child: SingleChildScrollView(
        padding: const EdgeInsets.all(24),
        child: Form(
          child: Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    "Subscription Details",
                    style: TextStyle(
                      color: AppColors.white,
                      fontSize: 24,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                  IconButton(
                    onPressed: () => Navigator.pop(context),
                    splashRadius: 16,
                    icon: Icon(Icons.close, color: AppColors.white, size: 24),
                  ),
                ],
              ),
              SizedBox(height: 20),
              _buildField(
                "Start Date",
                _firstPaymentController,
                readOnly: true,
                onTap:
                    () =>
                        _showDatePicker(_firstPaymentController, isStart: true),
              ),
              DropdownButtonFormField<SubscriptionPeriod>(
                value: _selectedPeriod,
                onChanged: (value) {
                  setState(() {
                    _selectedPeriod = value;
                    if (value != SubscriptionPeriod.Custom) {
                      _customEndDateController.clear();
                      _updateEndDate();
                    }
                  });
                },
                dropdownColor: AppColors.gray70,
                decoration: getInputDecoration("Subscription Period"),
                style: TextStyle(color: AppColors.white),
                items:
                    SubscriptionPeriod.values.map((period) {
                      return DropdownMenuItem(
                        value: period,
                        child: Text(
                          period.name,
                          style: TextStyle(color: AppColors.white),
                        ),
                      );
                    }).toList(),
              ),
              const SizedBox(height: 20),
              if (_selectedPeriod == SubscriptionPeriod.Custom)
                _buildField(
                  "End Date",
                  _customEndDateController,
                  readOnly: true,
                  onTap:
                      () => _showDatePicker(
                        _customEndDateController,
                        isStart: false,
                      ),
                ),
              if (_selectedPeriod != null &&
                  _selectedPeriod != SubscriptionPeriod.Custom)
                _buildField(
                  "End Date",
                  _customEndDateController,
                  readOnly: true,
                ),
              DropdownButtonFormField<SubscriptionType>(
                value: _selectedType,
                onChanged: (value) {
                  setState(() {
                    _selectedType = value;
                  });
                },
                dropdownColor: AppColors.gray70,
                decoration: getInputDecoration("Subscription Type"),
                style: TextStyle(color: AppColors.white),
                items:
                    SubscriptionType.values.map((period) {
                      return DropdownMenuItem(
                        value: period,
                        child: Text(
                          period.name,
                          style: TextStyle(color: AppColors.white),
                        ),
                      );
                    }).toList(),
              ),
              SizedBox(height: 20),
              SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  onPressed: () {
                    _formKey.currentState!.validate();
                  },
                  style: ElevatedButton.styleFrom(
                    padding: EdgeInsets.symmetric(vertical: 16),
                    backgroundColor: AppColors.secondary,
                    shadowColor: AppColors.secondary,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                  ),
                  child: Text(
                    "Add Subscription",
                    style: TextStyle(
                      color: AppColors.white,
                      fontSize: 18,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildField(
    String label,
    TextEditingController controller, {
    TextInputType inputType = TextInputType.text,
    String validateText = "Required",
    bool readOnly = false,
    VoidCallback? onTap,
  }) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 20),
      child: TextFormField(
        controller: controller,
        readOnly: readOnly,
        onTap: onTap,
        keyboardType: inputType,
        cursorColor: AppColors.white,
        style: TextStyle(color: AppColors.white),
        decoration: getInputDecoration(label),
        validator:
            (value) => value == null || value.isEmpty ? validateText : null,
      ),
    );
  }
}
