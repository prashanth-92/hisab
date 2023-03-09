import 'package:flutter/material.dart';

@immutable
class Student {
  const Student({
    required this.email,
    required this.name,
    required this.school,
  });

  final String email;
  final String name;
  final String school;

  @override
  String toString() {
    return '$name, $email';
  }

  @override
  bool operator ==(Object other) {
    if (other.runtimeType != runtimeType) {
      return false;
    }
    return other is Student && other.name == name && other.email == email;
  }

  @override
  int get hashCode => Object.hash(email, name);

  factory Student.fromGsheets(Map<String, dynamic> json) {
    return Student(
        email: json["Student's Gmail Address"] ?? '',
        name: json['Name of the Student with initials'],
        school: json['School']);
  }
}
