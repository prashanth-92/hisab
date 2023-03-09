import 'package:hisab/models/student.dart';
import 'package:hisab/models/transaction.dart';

List<Transaction> getTransactions() {
  var transactions = <Transaction>[
    Transaction(id: "1", amount: "250", dateModified: "2023-03-09 05:10:00", student: const Student(email: "email", name: "name", school: "school")),
    Transaction(id: "2", amount: "500", dateModified: "2023-03-09 05:10:00", student: const Student(email: "email", name: "name", school: "school")),
  ];

  return transactions;
}
