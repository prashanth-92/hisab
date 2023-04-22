import 'package:gsheets/gsheets.dart';
import 'package:hisab/models/consolidated_fees.dart';
import 'package:hisab/models/transaction.dart';
import 'package:hisab/service/consolidated_fees_service.dart';
import 'credentials.dart';

const _spreadsheetId =
    "1R2Bee34p64PAHeo41uZgc5InBfu1TRJNq1kF-kkjqlo"; // Transactions

class TransactionService {
  static GSheets gSheets = GSheets(credentials);
  static String worksheetName = "Transactions";
  static Future<List<Transaction>> getTransactions() async {
    try {
      final ss = await gSheets.spreadsheet(_spreadsheetId);
      final sheet = ss.worksheetByTitle(worksheetName);
      final transactionsFromGSheet =
          await sheet!.values.map.allRows(fromRow: 2);
      if (transactionsFromGSheet == null) {
        return Future.value(List.empty());
      }
      final transactions = transactionsFromGSheet
          .map((transaction) => Transaction.fromGsheets(transaction))
          .where((transaction) => transaction.isActiveTransaction())
          .toList();
      return transactions;
    } catch (err) {
      throw Exception("Failed to fetch transactions");
    }
  }

  static Future<List<Transaction>> getTransactionsForStudentWithId(String id) async {
    try {
      final List<Transaction> transactionsData = await getTransactions();
      final transactions = transactionsData
          .where((transaction) => transaction.student.getID() == id)
          .toList();
      return transactions;
    } catch (err) {
      throw Exception("Failed to fetch transactions");
    }
  }

  static save(Transaction transaction) async {
    final ss = await gSheets.spreadsheet(_spreadsheetId);
    final sheet = ss.worksheetByTitle(worksheetName);
    final row = transaction.toGsheets();
    sheet!.values.map.insertRowByKey(transaction.id, row, appendMissing: true);
    ConsolidatedFeesService.upsert(transaction, Action.update);
  }

  static delete(Transaction transaction) async {
    final ss = await gSheets.spreadsheet(_spreadsheetId);
    final sheet = ss.worksheetByTitle(worksheetName);
    sheet!.values.insertValueByKeys('false', columnKey: 'IsActive', rowKey: transaction.id);
    ConsolidatedFeesService.upsert(transaction, Action.delete);
  }
}
