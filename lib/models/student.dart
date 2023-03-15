import 'package:flutter/material.dart';

@immutable
class Student {
  const Student({
    required this.email,
    required this.name,
    required this.school,
    required this.className,
    required this.phoneNumber,
  });

  final String email;
  final String name;
  final String school;
  final String className;
  final String phoneNumber;

  factory Student.fromGsheets(Map<String, dynamic> json) {
    return Student(
        email: json["Student's Gmail Address"] ?? '',
        name: json['Name of the Student with initials'],
        school: json['School'],
        className: json['Seeking Admission for Class...'],
        phoneNumber: json["Parent's Contact Number (WhatsApp)"] ?? '');
  }

  @override
  bool operator ==(Object other) {
    if (other.runtimeType != runtimeType) {
      return false;
    }
    return other is Student && other.email == email;
  }
  
  @override
  int get hashCode => email.hashCode;
}
