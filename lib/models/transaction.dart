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
        dateModified: toDateTimeString(json["DateTime"]),
        student: Student(
            email: '',
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
