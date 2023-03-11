import 'package:hisab/models/student.dart';

class Transaction {
  Transaction(
      {required this.id,
      required this.amount,
      required this.dateModified,
      required this.student});

  final String id;
  final String amount;
  final String dateModified;
  final Student student;

  Map<String, dynamic> toGsheets() {
    return {
      'ID': id,
      'Amount': amount,
      'DateTime': dateModified,
      'Name': student.name,
      'Class': student.className,
      'Phone': student.phoneNumber,
      'School': student.school,
    };
  }

  factory Transaction.fromGsheets(Map<String, dynamic> json) {
    return Transaction(
        id: json["ID"],
        amount: json["Amount"],
        dateModified: json["DateTime"],
        student: Student(
            email: '',
            name: json["Name"],
            school: json["School"],
            className: json["Class"],
            phoneNumber: json["Phone"])
        );
  }
}
