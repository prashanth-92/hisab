import 'package:gsheets/gsheets.dart';
import 'package:hisab/models/transaction.dart';

import 'credentials.dart';

const _spreadsheetId = "1R2Bee34p64PAHeo41uZgc5InBfu1TRJNq1kF-kkjqlo"; // Transactions

class TransactionService {
  static Future<List<Transaction>> getTransactions() async {
    try {
      final gsheets = GSheets(Credentials);
      final ss = await gsheets.spreadsheet(_spreadsheetId);
      final sheet = ss.worksheetByTitle('Transactions');
      final transactionsFromGSheet =
          await sheet!.values.map.allRows(fromRow: 2);
      final transactions = transactionsFromGSheet!
          .map((transaction) => Transaction.fromGsheets(transaction))
          .toList();
      return transactions;
    } catch (err) {
      throw Exception("Failed to fetch transactions");
    }
  }

  static save(Transaction transaction) async {
    final gsheets = GSheets(Credentials);
    final ss = await gsheets.spreadsheet(_spreadsheetId);
    final sheet = ss.worksheetByTitle('Transactions');
    final row = transaction.toGsheets();
    sheet!.values.map.insertRowByKey(transaction.id, row, appendMissing: true);
  }
}
