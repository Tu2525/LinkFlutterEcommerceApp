import 'package:flutter/material.dart';
import 'package:link_flutter_ecommerce_app/widgets/gender_button.dart';

class UserInfo extends StatefulWidget {
  const UserInfo({super.key});

  @override
  State<UserInfo> createState() => _UserInfoState();
}

class _UserInfoState extends State<UserInfo> {
  String selectedGender = '';
  String? selectedAgeRange;
  final List<String> ageRanges = [
    '0 - 5',
    '6 - 12',
    '13 - 17',
    '18 - 24',
    '25 - 34',
    '35 - 44',
    '45+',
  ];

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: LayoutBuilder(
          builder: (context, constraints) {
            return SingleChildScrollView(
              child: ConstrainedBox(
                constraints: BoxConstraints(minHeight: constraints.maxHeight),
                child: Center(
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 24),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Text(
                          'Tell us About yourself',
                          style: TextStyle(
                            fontSize: 22,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        const SizedBox(height: 46),
                        const Text(
                          'Who do you shop for ?',
                          style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                        const SizedBox(height: 16),
                        Row(
                          children: [
                            Expanded(
                              child: GenderButton(
                                gender: 'Men',
                                isSelected: selectedGender == 'Men',
                                onTap:
                                    () =>
                                        setState(() => selectedGender = 'Men'),
                              ),
                            ),
                            const SizedBox(width: 16),
                            Expanded(
                              child: GenderButton(
                                gender: 'Women',
                                isSelected: selectedGender == 'Women',
                                onTap:
                                    () => setState(
                                      () => selectedGender = 'Women',
                                    ),
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(height: 46),
                        const Text(
                          'How Old are you?',
                          style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.w400,
                          ),
                        ),
                        const SizedBox(height: 16),
                        DropdownButtonFormField<String>(
                          value: selectedAgeRange,
                          decoration: InputDecoration(
                            focusColor:
                                Theme.of(context).brightness == Brightness.dark
                                    ? const Color(0xFF342F3F)
                                    : const Color(0xffF4F4F4),
                            fillColor:
                                Theme.of(context).brightness == Brightness.dark
                                    ? const Color(0xFF342F3F)
                                    : const Color(0xffF4F4F4),
                            filled: true,
                            contentPadding: const EdgeInsets.all(16),
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(24),
                              borderSide: BorderSide(
                                color:
                                    Theme.of(context).brightness ==
                                            Brightness.dark
                                        ? const Color(0xFF342F3F)
                                        : const Color(0xffF4F4F4),
                              ),
                            ),
                            enabledBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(24),
                              borderSide: BorderSide(
                                color:
                                    Theme.of(context).brightness ==
                                            Brightness.dark
                                        ? const Color(0xFF342F3F)
                                        : const Color(0xffF4F4F4),
                              ),
                            ),
                            focusedBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(24),
                              borderSide: BorderSide(
                                color:
                                    Theme.of(context).brightness ==
                                            Brightness.dark
                                        ? const Color(0xFF342F3F)
                                        : const Color(0xffF4F4F4),
                              ),
                            ),
                          ),
                          icon: const Icon(Icons.arrow_drop_down),
                          hint: const Text('Select Age Range'),
                          items:
                              ageRanges.map((String value) {
                                return DropdownMenuItem<String>(
                                  value: value,
                                  child: Text(value),
                                );
                              }).toList(),
                          onChanged: (value) {
                            setState(() {
                              selectedAgeRange = value;
                            });
                          },
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            );
          },
        ),
        bottomNavigationBar: Container(
          color:
              Theme.of(context).brightness == Brightness.dark
                  ? const Color(0xFF342F3F)
                  : const Color(0xffF4F4F4),
          padding: const EdgeInsets.only(
            bottom: 16,
            top: 16,
            left: 24,
            right: 24,
          ),
          child: ElevatedButton(
            onPressed: () {},
            style: ElevatedButton.styleFrom(
              backgroundColor: const Color(0xff8E6CEF),
              padding: const EdgeInsets.symmetric(vertical: 16),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(28),
              ),
            ),
            child: const Text(
              'Finish',
              style: TextStyle(
                fontWeight: FontWeight.w400,
                fontSize: 16,
                color: Colors.white,
              ),
            ),
          ),
        ),
      ),
    );
  }
}
