import 'package:hisab/models/student.dart';

class Transaction {
  Transaction(
      {required this.id,
      required this.amount,
      required this.dateModified,
      required this.isActive,
      required this.student});

  final String id;
  String amount;
  final String dateModified;
  final Student student;
  final String isActive;

  Map<String, dynamic> toGsheets() {
    return {
      'ID': id,
      'Amount': amount,
      'DateTime': dateModified,
      'Name': student.name,
      'Class': student.className,
      'Phone': student.phoneNumber,
      'School': student.school,
      'Email': student.email,
      'StudentId': student.getID(),
      'IsActive': isActive,
    };
  }

  bool isActiveTransaction() {
    return isActive.toLowerCase() == "true";
  }

  factory Transaction.fromGsheets(Map<String, dynamic> json) {
    return Transaction(
        id: json["ID"],
        amount: json["Amount"],
        dateModified: toDateTimeString(json["DateTime"]),
        isActive: json["IsActive"],
        student: Student(
            email: json["Email"] ?? '',
            name: json["Name"],
            school: json["School"],
            className: json["Class"],
            phoneNumber: json["Phone"]));
  }

  //Refer https://developers.google.com/sheets/api/guides/formats#about_date_time_values
  static toDateTimeString(String gSheetsDateTime) {
    try {
      final epoch = DateTime(1899, 12, 30);
      final gSheetsDateTimeSplit = gSheetsDateTime.split(".");
      final gsheetsDateSinceEpoch = gSheetsDateTimeSplit.elementAt(0);
      final gSheetsDate =
          epoch.add(Duration(days: int.parse(gsheetsDateSinceEpoch)));
      return gSheetsDate.toString().substring(0, 10);
    } catch (err) {
      rethrow;
    }
  }
}
