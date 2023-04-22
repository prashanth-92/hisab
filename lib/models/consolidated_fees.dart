import 'package:flutter/material.dart';
import 'package:hisab/models/transaction.dart';

@immutable
class ConsolidatedFees {
  final String id;
  final String email;
  final String phone;
  final String studentName;
  final String className;
  final String totalFeesPaid;

  const ConsolidatedFees({
    required this.id,
    required this.email,
    required this.phone,
    required this.studentName,
    required this.className,
    required this.totalFeesPaid,
  });

  factory ConsolidatedFees.fromGsheets(Map<String, dynamic> json) {
    return ConsolidatedFees(
        id: json["ID"],
        email: json["Email"],
        phone: json["Phone"],
        studentName: json["StudentName"],
        className: json["Class"],
        totalFeesPaid: json["TotalFeesPaid"]);
  }

  Map<String, dynamic> toGsheets() {
    return {
      'ID': id,
      'Email': email,
      'Phone': phone,
      'StudentName': studentName,
      'Class': className,
      'TotalFeesPaid': totalFeesPaid
    };
  }

  factory ConsolidatedFees.fromTransaction(
      Transaction transaction, String totalFeesPaid) {
    return ConsolidatedFees(
        id: transaction.student.getID(),
        email: transaction.student.email,
        phone: transaction.student.phoneNumber,
        studentName: transaction.student.name,
        className: transaction.student.className,
        totalFeesPaid: totalFeesPaid);
  }
}

enum Action { update, delete }
