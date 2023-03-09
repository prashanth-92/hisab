import 'package:hisab/models/transaction.dart';

List<Transaction> getTransactions() {
  return <Transaction>[
    Transaction(id: "1", amount: "250"),
    Transaction(id: "2", amount: "500"),
  ];
}
