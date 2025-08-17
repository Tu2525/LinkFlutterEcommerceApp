class UserModel {
  final String firstName;
  final String lastName;
  final String email;
  final String password;

  UserModel({
    required this.firstName,
    required this.lastName,
    required this.email,
    required this.password,
  });
  Map<String, dynamic> toJson() {
    return {
      'firstName': firstName,
      'lastName': lastName,
      'email': email,
      'password': password, 
    };
  }

  factory UserModel.fromJson(Map<String, dynamic> json) {
    String firstName = json['firstName'] ?? '';
    String lastName = json['lastName'] ?? '';

    if (firstName.isEmpty && json.containsKey('name')) {
      final parts = (json['name'] as String).split(' ');
      firstName = parts.isNotEmpty ? parts.first : '';
      lastName = parts.length > 1 ? parts.sublist(1).join(' ') : '';
    }

    return UserModel(
      firstName: firstName,
      lastName: lastName,
      email: json['email'] ?? 'No Email Provided',
      password: json['password'] ?? '',
    );
  }
  factory UserModel.fromFirestore(Map<String, dynamic> data) {
    return UserModel(
      email: data['email'] ?? 'No Email Provided',
      firstName: data['name'] ?? 'null',
      lastName: data['name'] ?? 'null',
      password: data['password'] ?? '',
    );
  }
}
