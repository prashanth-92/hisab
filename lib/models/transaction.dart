import 'package:hisab/models/student.dart';

class Transaction {
  Transaction({
    required this.id,
    required this.amount,
  });

  final String id;
  final String amount;
  late Student student;
}
