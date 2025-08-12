import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:iconsax_plus/iconsax_plus.dart';
import 'package:link_flutter_ecommerce_app/constants/app_colors.dart';
import 'package:link_flutter_ecommerce_app/screens/add_address_screen.dart';
import 'package:link_flutter_ecommerce_app/providers/theme_provider.dart';
import 'package:link_flutter_ecommerce_app/providers/address_provider.dart';
import 'package:link_flutter_ecommerce_app/models/address_model.dart';
import 'package:link_flutter_ecommerce_app/l10n/app_localizations.dart';

class AddressScreen extends ConsumerStatefulWidget {
  const AddressScreen({super.key});

  @override
  ConsumerState<AddressScreen> createState() => _AddressScreenState();
}

class _AddressScreenState extends ConsumerState<AddressScreen> {
  AddressModel? selectedAddress;

  @override
  Widget build(BuildContext context) {
    final isDarkMode = ref.watch(isDarkModeProvider);
    final addressesAsync = ref.watch(userAddressesProvider);
    final addressOperations = ref.read(addressOperationsProvider);

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
              borderRadius: BorderRadius.circular(80.r),
            ),
            child: Icon(
              IconsaxPlusBroken.arrow_left_2,
              color: AppColors.textPrimaryColor(isDarkMode),
            ),
          ),
        ),
        title: Text(
          AppLocalizations.of(context)!.address,
          style: TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.w600,
            color: AppColors.textPrimaryColor(isDarkMode),
            fontFamily: 'Circular',
          ),
        ),
        centerTitle: true,
      ),
      body: addressesAsync.when(
        data: (addresses) {
          return Column(
            children: [
              Expanded(
                child:
                    addresses.isEmpty
                        ? Center(
                          child: Text(
                            AppLocalizations.of(context)!.noAddressesFound,
                            textAlign: TextAlign.center,
                            style: TextStyle(
                              fontSize: 16,
                              color: AppColors.textSecondaryColor(isDarkMode),
                              fontFamily: 'Circular',
                            ),
                          ),
                        )
                        : ListView.builder(
                          padding: const EdgeInsets.all(24.0),
                          itemCount: addresses.length,
                          itemBuilder: (context, index) {
                            final address = addresses[index];
                            final isSelected =
                                selectedAddress?.id == address.id;

                            return Container(
                              margin: const EdgeInsets.only(bottom: 16),
                              padding: const EdgeInsets.all(20),
                              decoration: BoxDecoration(
                                color: AppColors.cardBackgroundColor(
                                  isDarkMode,
                                ),
                                borderRadius: BorderRadius.circular(16),
                                border:
                                    isSelected
                                        ? Border.all(
                                          color: Color(0xFF8E6CEF),
                                          width: 2,
                                        )
                                        : null,
                              ),
                              child: Row(
                                children: [
                                  // Radio button
                                  GestureDetector(
                                    onTap: () {
                                      setState(() {
                                        selectedAddress = address;
                                      });
                                      addressOperations.selectAddress(address);
                                      // Return selected address to previous screen
                                      Navigator.pop(context, address);
                                    },
                                    child: Container(
                                      width: 20,
                                      height: 20,
                                      decoration: BoxDecoration(
                                        shape: BoxShape.circle,
                                        border: Border.all(
                                          color:
                                              isSelected
                                                  ? Color(0xFF8E6CEF)
                                                  : AppColors.textSecondaryColor(
                                                    isDarkMode,
                                                  ),
                                          width: 2,
                                        ),
                                        color:
                                            isSelected
                                                ? Color(0xFF8E6CEF)
                                                : Colors.transparent,
                                      ),
                                      child:
                                          isSelected
                                              ? Icon(
                                                IconsaxPlusBroken.tick_circle,
                                                size: 12,
                                                color: Colors.white,
                                              )
                                              : null,
                                    ),
                                  ),

                                  const SizedBox(width: 16),

                                  // Address content
                                  Expanded(
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                          address.formattedAddress,
                                          style: TextStyle(
                                            fontSize: 16,
                                            fontWeight: FontWeight.w500,
                                            color: AppColors.textPrimaryColor(
                                              isDarkMode,
                                            ),
                                            fontFamily: 'Circular',
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),

                                  // Edit button
                                  GestureDetector(
                                    onTap: () {
                                      Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                          builder:
                                              (context) => AddAddressScreen(
                                                isEditing: true,
                                                existingAddress: address,
                                              ),
                                        ),
                                      );
                                    },
                                    child: Text(
                                      'Edit',
                                      style: TextStyle(
                                        fontSize: 14,
                                        color: Color(0xFF8E6CEF),
                                        fontFamily: 'Circular',
                                        fontWeight: FontWeight.w500,
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            );
                          },
                        ),
              ),

              // Add New Address Button
              Container(
                padding: const EdgeInsets.all(24.0),
                child: SizedBox(
                  width: double.infinity,
                  height: 56,
                  child: ElevatedButton(
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => const AddAddressScreen(),
                        ),
                      );
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Color(0xFF8E6CEF),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(100),
                      ),
                      elevation: 0,
                    ),
                    child: Text(
                      AppLocalizations.of(context)!.addNewAddress,
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
          );
        },
        loading:
            () => Center(
              child: CircularProgressIndicator(color: Color(0xFF8E6CEF)),
            ),
        error:
            (error, stack) => Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    AppLocalizations.of(context)!.errorLoadingAddresses,
                    style: TextStyle(
                      fontSize: 16,
                      color: AppColors.textSecondaryColor(isDarkMode),
                      fontFamily: 'Circular',
                    ),
                  ),
                  const SizedBox(height: 16),
                  ElevatedButton(
                    onPressed: () {
                      ref.invalidate(userAddressesProvider);
                    },
                    child: Text(AppLocalizations.of(context)!.retry),
                  ),
                ],
              ),
            ),
      ),
    );
  }
}
