class AddressModel {
  final String id;
  final String streetAddress;
  final String city;
  final String state;
  final String zipCode;
  final DateTime createdAt;
  final DateTime updatedAt;

  AddressModel({
    required this.id,
    required this.streetAddress,
    required this.city,
    required this.state,
    required this.zipCode,
    required this.createdAt,
    required this.updatedAt,
  });

  // Convert address to map for Firestore
  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'streetAddress': streetAddress,
      'city': city,
      'state': state,
      'zipCode': zipCode,
      'createdAt': createdAt.millisecondsSinceEpoch,
      'updatedAt': updatedAt.millisecondsSinceEpoch,
    };
  }

  // Create address from Firestore map
  factory AddressModel.fromMap(Map<String, dynamic> map) {
    return AddressModel(
      id: map['id'] ?? '',
      streetAddress: map['streetAddress'] ?? '',
      city: map['city'] ?? '',
      state: map['state'] ?? '',
      zipCode: map['zipCode'] ?? '',
      createdAt: DateTime.fromMillisecondsSinceEpoch(map['createdAt'] ?? 0),
      updatedAt: DateTime.fromMillisecondsSinceEpoch(map['updatedAt'] ?? 0),
    );
  }

  // Get formatted address string
  String get formattedAddress {
    return '$streetAddress, $city, $state $zipCode';
  }

  // Create a copy with updated fields
  AddressModel copyWith({
    String? id,
    String? streetAddress,
    String? city,
    String? state,
    String? zipCode,
    DateTime? createdAt,
    DateTime? updatedAt,
  }) {
    return AddressModel(
      id: id ?? this.id,
      streetAddress: streetAddress ?? this.streetAddress,
      city: city ?? this.city,
      state: state ?? this.state,
      zipCode: zipCode ?? this.zipCode,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
    );
  }

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is AddressModel &&
          runtimeType == other.runtimeType &&
          id == other.id;

  @override
  int get hashCode => id.hashCode;

  @override
  String toString() {
    return 'AddressModel{id: $id, streetAddress: $streetAddress, city: $city, state: $state, zipCode: $zipCode}';
  }
}
