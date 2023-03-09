import 'package:hisab/models/student.dart';

class Transaction {
  Transaction({
    required this.id,
    required this.amount,
    required this.dateModified,
    required this.student
  });

  final String id;
  final String amount;
  final String dateModified;
  final Student student;
}
