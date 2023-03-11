import 'package:gsheets/gsheets.dart';
import 'package:hisab/models/student.dart';
import 'package:hisab/models/transaction.dart';

import 'credentials.dart';

const _spreadsheetId = "1R2Bee34p64PAHeo41uZgc5InBfu1TRJNq1kF-kkjqlo";
List<Transaction> getTransactions() {
  var transactions = <Transaction>[
    Transaction(
        id: "1",
        amount: "250",
        dateModified: "2023-03-09 05:10:00",
        student: const Student(
            email: "email",
            name: "name",
            school: "school",
            className: "IX",
            phoneNumber: "")),
    Transaction(
        id: "2",
        amount: "500",
        dateModified: "2023-03-09 05:10:00",
        student: const Student(
            email: "email",
            name: "name",
            school: "school",
            className: "X",
            phoneNumber: "")),
  ];

  return transactions;
}

class TransactionService {
  final List<Transaction> transactions;
  static TransactionService? instance;

  TransactionService._(this.transactions);

  static Future<TransactionService> init() async {
    final gsheets = GSheets(Credentials);
    final ss = await gsheets.spreadsheet(_spreadsheetId);
    final sheet = ss.worksheetByTitle('Transactions');
    final transactionsFromGSheet = await sheet!.values.map.allRows(fromRow: 2);
    final transactions = transactionsFromGSheet!
        .map((transaction) => Transaction.fromGsheets(transaction))
        .toList();
    //final transactions = getTransactions();
    // ignore: prefer_conditional_assignment
    if (instance == null) {
      instance = TransactionService._(transactions);
    }
    return instance!;
  }

  static save(Transaction transaction) async {
    final gsheets = GSheets(Credentials);
    final ss = await gsheets.spreadsheet(_spreadsheetId);
    final sheet = ss.worksheetByTitle('Transactions');
    final row = transaction.toGsheets();
    sheet!.values.map.insertRowByKey(transaction.id, row, appendMissing: true);
  }
}
