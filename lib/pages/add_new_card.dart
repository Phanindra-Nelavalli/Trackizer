import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:trackizer/common/App_Colors.dart';
import 'package:trackizer/widgets/custom_input_formatters.dart';

class AddNewCard extends StatefulWidget {
  const AddNewCard({super.key});

  @override
  State<AddNewCard> createState() => _AddNewCardState();
}

class _AddNewCardState extends State<AddNewCard> {
  final _formKey = GlobalKey<FormState>();
  final _cardNameController = TextEditingController();
  final _bankNameController = TextEditingController();
  final _userNameController = TextEditingController();
  final _cardNumberController = TextEditingController();
  final _expiryDateController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: AppColors.gray80,
        shadowColor: null,
        elevation: 0,
        title: Text("Add New Card"),
        centerTitle: true,
        titleTextStyle: TextStyle(fontWeight: FontWeight.w700, fontSize: 21),
      ),
      backgroundColor: AppColors.gray80,
      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: 24, vertical: 32),
            child: Center(
              child: Form(
                key: _formKey,
                child: Column(
                  children: [
                    Icon(
                      Icons.wallet_rounded,
                      size: 82,
                      color: AppColors.white.withOpacity(0.7),
                    ),
                    SizedBox(height: 30),
                    _buildField(
                      "Card Name",
                      _cardNameController,
                      validateText: "Please enter a valid card name",
                    ),
                    _buildField(
                      "Bank Name",
                      _bankNameController,
                      validateText: "Please enter the bank name",
                    ),
                    _buildField(
                      "User Name",
                      _userNameController,
                      validateText: "Please enter the name on the card",
                    ),
                    _buildField(
                      "Card Number",
                      _cardNumberController,
                      validateText: "Please enter a 16-digit card number",
                      inputType: TextInputType.number,
                      inputFormatters: [
                        CardNumberFormatter(),
                        LengthLimitingTextInputFormatter(19),
                      ],
                    ),
                    _buildField(
                      "Expiry Date",
                      _expiryDateController,
                      validateText: "Please enter expiry date in MM/YY format",
                      inputType: TextInputType.number,
                      inputFormatters: [
                        ExpiryDateFormatter(),
                        LengthLimitingTextInputFormatter(5),
                      ],
                    ),

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
                          "Add Card",
                          style: TextStyle(
                            color: AppColors.white,
                            fontSize: 18,
                            fontWeight: FontWeight.w700,
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
      ),
    );
  }

  Widget _buildField(
    String label,
    TextEditingController controller, {
    TextInputType inputType = TextInputType.text,
    String validateText = "Required",
    List<TextInputFormatter>? inputFormatters,
  }) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 20),
      child: TextFormField(
        controller: controller,
        keyboardType: inputType,
        cursorColor: AppColors.white,
        inputFormatters: inputFormatters,
        style: TextStyle(color: AppColors.white),
        decoration: InputDecoration(
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
        ),
        validator:
            (value) => value == null || value.isEmpty ? validateText : null,
      ),
    );
  }
}
