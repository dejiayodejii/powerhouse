import 'dart:convert';

class UserModel {
  final String? id;
  final String firstName;
  final String lastName;
  final String email;
  final String? password;
  final DateTime? dateOfBirth;
  final String? phoneNumber;

  const UserModel({
    this.id,
    required this.firstName,
    required this.lastName,
    required this.email,
    this.password = "",
    this.dateOfBirth,
    this.phoneNumber,
  });

  UserModel copyWith({
    String? id,
    String? firstName,
    String? lastName,
    String? email,
    String? password,
    DateTime? dateOfBirth,
    String? phoneNumber,
  }) {
    return UserModel(
      id: id ?? this.id,
      firstName: firstName ?? this.firstName,
      lastName: lastName ?? this.lastName,
      email: email ?? this.email,
      password: password ?? this.password,
      dateOfBirth: dateOfBirth ?? this.dateOfBirth,
      phoneNumber: phoneNumber ?? this.phoneNumber,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'first_name': firstName,
      'last_name': lastName,
      'email': email,
      'date_of_birth': dateOfBirth?.toIso8601String(),
      'phone_number': phoneNumber,
    };
  }

  factory UserModel.fromMap(Map<String, dynamic> map) {
    return UserModel(
      id: map['id'],
      firstName: map['first_name'] ?? '',
      lastName: map['last_name'] ?? '',
      email: map['email'] ?? '',
      password: map['password'] ?? '',
      dateOfBirth: map['date_of_birth'] != null
          ? DateTime.parse(map['date_of_birth'])
          : null,
      phoneNumber: map['phone_number'] ?? '',
    );
  }

  String toJson() => json.encode(toMap());

  factory UserModel.fromJson(String source) =>
      UserModel.fromMap(json.decode(source));
}
