import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final nameControllerProvider = Provider.autoDispose<TextEditingController>(
  (ref) => TextEditingController(),
);

final cardNumberControllerProvider =
    Provider.autoDispose<TextEditingController>(
      (ref) => TextEditingController(),
    );

final cvvControllerProvider = Provider.autoDispose<TextEditingController>(
  (ref) => TextEditingController(),
);

final expiryControllerProvider = Provider.autoDispose<TextEditingController>(
  (ref) => TextEditingController(),
);

final countryControllerProvider = Provider.autoDispose<TextEditingController>(
  (ref) => TextEditingController(),
);

final stateControllerProvider = Provider.autoDispose<TextEditingController>(
  (ref) => TextEditingController(),
);

final addressControllerProvider = Provider.autoDispose<TextEditingController>(
  (ref) => TextEditingController(),
);

final cityControllerProvider = Provider.autoDispose<TextEditingController>(
  (ref) => TextEditingController(),
);

final zipCodeControllerProvider = Provider.autoDispose<TextEditingController>(
  (ref) => TextEditingController(),
);
