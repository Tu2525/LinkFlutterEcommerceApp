class ShippingAddress {
  final String address;
  final String city;
  final String state;
  final String country;
  final String zipCode;

  ShippingAddress({
    required this.address,
    required this.city,
    required this.state,
    required this.country,
    required this.zipCode,
  });

  Map<String, dynamic> toMap() {
    return {
      'address': address,
      'city': city,
      'state': state,
      'country': country,
      'zipCode': zipCode,
    };
  }

  factory ShippingAddress.fromMap(Map<String, dynamic> map) {
    return ShippingAddress(
      address: map['address'] ?? '',
      city: map['city'] ?? '',
      state: map['state'] ?? '',
      country: map['country'] ?? '',
      zipCode: map['zipCode'] ?? '',
    );
  }
}

class PaymentMethod {
  final String cardHolderName;
  final String cardNumber;
  final String cvv;
  final String expiry;

  PaymentMethod({
    required this.cardHolderName,
    required this.cardNumber,
    required this.cvv,
    required this.expiry,
  });

  Map<String, dynamic> toMap() {
    return {
      'cardHolderName': cardHolderName,
      'cardNumber': cardNumber,
      'cvv': cvv,
      'expiry': expiry,
    };
  }

  factory PaymentMethod.fromMap(Map<String, dynamic> map) {
    return PaymentMethod(
      cardHolderName: map['cardHolderName'] ?? '',
      cardNumber: map['cardNumber'] ?? '',
      cvv: map['cvv'] ?? '',
      expiry: map['expiry'] ?? '',
    );
  }
}

class CheckoutModel {
  final ShippingAddress? shippingAddress;
  final PaymentMethod? paymentMethod;

  CheckoutModel({this.shippingAddress, this.paymentMethod});

  Map<String, dynamic> toMap() {
    return {
      'shippingAddress': shippingAddress?.toMap(),
      'paymentMethod': paymentMethod?.toMap(),
    };
  }

  factory CheckoutModel.fromMap(Map<String, dynamic> map) {
    return CheckoutModel(
      shippingAddress:
          map['shippingAddress'] != null
              ? ShippingAddress.fromMap(
                Map<String, dynamic>.from(map['shippingAddress']),
              )
              : null,
      paymentMethod:
          map['paymentMethod'] != null
              ? PaymentMethod.fromMap(
                Map<String, dynamic>.from(map['paymentMethod']),
              )
              : null,
    );
  }
}
