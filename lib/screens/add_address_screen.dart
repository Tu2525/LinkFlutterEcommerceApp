import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:iconsax_plus/iconsax_plus.dart';
import 'package:link_flutter_ecommerce_app/constants/app_colors.dart';
import 'package:link_flutter_ecommerce_app/providers/theme_provider.dart';
import 'package:link_flutter_ecommerce_app/providers/address_provider.dart';
import 'package:link_flutter_ecommerce_app/models/address_model.dart';
import 'package:link_flutter_ecommerce_app/l10n/app_localizations.dart';

class AddAddressScreen extends ConsumerStatefulWidget {
  final bool isEditing;
  final AddressModel? existingAddress;

  const AddAddressScreen({
    super.key,
    this.isEditing = false,
    this.existingAddress,
  });

  @override
  ConsumerState<AddAddressScreen> createState() => _AddAddressScreenState();
}

class _AddAddressScreenState extends ConsumerState<AddAddressScreen> {
  final _formKey = GlobalKey<FormState>();
  late TextEditingController streetController;
  late TextEditingController cityController;
  late TextEditingController stateController;
  late TextEditingController zipCodeController;

  @override
  void initState() {
    super.initState();
    streetController = TextEditingController(
      text: widget.isEditing ? widget.existingAddress?.streetAddress ?? '' : '',
    );
    cityController = TextEditingController(
      text: widget.isEditing ? widget.existingAddress?.city ?? '' : '',
    );
    stateController = TextEditingController(
      text: widget.isEditing ? widget.existingAddress?.state ?? '' : '',
    );
    zipCodeController = TextEditingController(
      text: widget.isEditing ? widget.existingAddress?.zipCode ?? '' : '',
    );
  }

  @override
  void dispose() {
    streetController.dispose();
    cityController.dispose();
    stateController.dispose();
    zipCodeController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final isDarkMode = ref.watch(isDarkModeProvider);
    final addressOperations = ref.read(addressOperationsProvider);
    final isLoading = ref.watch(addressLoadingProvider);

    // Listen to success state
    ref.listen<bool>(addressSuccessProvider, (previous, next) {
      if (next) {
        ref.read(addressOperationsProvider).clearMessages();
        Navigator.pop(context);
      }
    });

    // Listen to error state
    ref.listen<String>(addressErrorProvider, (previous, next) {
      if (next.isNotEmpty) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text(next), backgroundColor: Colors.red),
        );
      }
    });

    return Scaffold(
      backgroundColor: AppColors.backgroundColor(isDarkMode),
      appBar: AppBar(
        backgroundColor: AppColors.backgroundColor(isDarkMode),
        elevation: 0,
        leading: GestureDetector(
          onTap: () => Navigator.pop(context),
          child: Container(
            margin: const EdgeInsets.all(8),
            decoration: BoxDecoration(
              color: AppColors.cardBackgroundColor(isDarkMode),
              borderRadius: BorderRadius.circular(8),
            ),
            child: Icon(
              IconsaxPlusBroken.arrow_left_2,
              color: AppColors.textPrimaryColor(isDarkMode),
            ),
          ),
        ),
        title: Text(
          AppLocalizations.of(context)!.addAddress,
          style: TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.w600,
            color: AppColors.textPrimaryColor(isDarkMode),
            fontFamily: 'Circular',
          ),
        ),
        centerTitle: true,
      ),
      body: Column(
        children: [
          Expanded(
            child: SingleChildScrollView(
              padding: const EdgeInsets.all(24.0),
              child: Form(
                key: _formKey,
                child: Column(
                  children: [
                    const SizedBox(height: 16),

                    // Street Address Field
                    _buildTextField(
                      controller: streetController,
                      hintText: AppLocalizations.of(context)!.streetAddress,
                      isDarkMode: isDarkMode,
                    ),

                    const SizedBox(height: 20),

                    // City Field
                    _buildTextField(
                      controller: cityController,
                      hintText: AppLocalizations.of(context)!.city,
                      isDarkMode: isDarkMode,
                    ),

                    const SizedBox(height: 20),

                    // State and Zip Code Row
                    Row(
                      children: [
                        Expanded(
                          child: _buildTextField(
                            controller: stateController,
                            hintText: AppLocalizations.of(context)!.state,
                            isDarkMode: isDarkMode,
                          ),
                        ),
                        const SizedBox(width: 16),
                        Expanded(
                          child: _buildTextField(
                            controller: zipCodeController,
                            hintText: AppLocalizations.of(context)!.zipCode,
                            isDarkMode: isDarkMode,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ),

          // Save Button
          Container(
            padding: const EdgeInsets.all(24.0),
            child: SizedBox(
              width: double.infinity,
              height: 56,
              child: ElevatedButton(
                onPressed:
                    isLoading
                        ? null
                        : () async {
                          if (_formKey.currentState?.validate() ?? false) {
                            if (widget.isEditing &&
                                widget.existingAddress != null) {
                              // Update existing address
                              await addressOperations.updateAddress(
                                addressId: widget.existingAddress!.id,
                                streetAddress: streetController.text.trim(),
                                city: cityController.text.trim(),
                                state: stateController.text.trim(),
                                zipCode: zipCodeController.text.trim(),
                              );
                            } else {
                              // Add new address
                              await addressOperations.addAddress(
                                streetAddress: streetController.text.trim(),
                                city: cityController.text.trim(),
                                state: stateController.text.trim(),
                                zipCode: zipCodeController.text.trim(),
                              );
                            }
                          }
                        },
                style: ElevatedButton.styleFrom(
                  backgroundColor: Color(0xFF8E6CEF),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(100),
                  ),
                  elevation: 0,
                ),
                child:
                    isLoading
                        ? SizedBox(
                          width: 20,
                          height: 20,
                          child: CircularProgressIndicator(
                            color: Colors.white,
                            strokeWidth: 2,
                          ),
                        )
                        : Text(
                          AppLocalizations.of(context)!.saveAddress,
                          style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.w500,
                            color: Colors.white,
                            fontFamily: 'Circular',
                          ),
                        ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildTextField({
    required TextEditingController controller,
    required String hintText,
    required bool isDarkMode,
    TextInputType? keyboardType,
  }) {
    return Container(
      decoration: BoxDecoration(
        color: AppColors.cardBackgroundColor(isDarkMode),
        borderRadius: BorderRadius.circular(12),
      ),
      child: TextFormField(
        controller: controller,
        keyboardType: keyboardType,
        style: TextStyle(
          color: AppColors.textPrimaryColor(isDarkMode),
          fontFamily: 'Circular',
          fontSize: 16,
        ),
        decoration: InputDecoration(
          hintText: hintText,
          hintStyle: TextStyle(
            color: AppColors.textSecondaryColor(isDarkMode),
            fontFamily: 'Circular',
            fontSize: 16,
          ),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(12),
            borderSide: BorderSide.none,
          ),
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(12),
            borderSide: BorderSide.none,
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(12),
            borderSide: BorderSide(color: Color(0xFF8E6CEF), width: 2),
          ),
          filled: true,
          fillColor: AppColors.cardBackgroundColor(isDarkMode),
          contentPadding: const EdgeInsets.symmetric(
            horizontal: 16,
            vertical: 16,
          ),
        ),
        validator: (value) {
          if (value == null || value.isEmpty) {
            return '$hintText is required';
          }
          return null;
        },
      ),
    );
  }
}
