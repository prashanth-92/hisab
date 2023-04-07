import 'package:gsheets/gsheets.dart';
import 'package:hisab/models/consolidated_fees.dart';
import 'package:hisab/models/transaction.dart';

import 'credentials.dart';

const _spreadsheetId =
    "1R2Bee34p64PAHeo41uZgc5InBfu1TRJNq1kF-kkjqlo"; // Transactions

class ConsolidatedFeesService {
  static GSheets gSheets = GSheets(credentials);
  static String consolidatedSheet = "Consolidated";

  static save(Transaction transaction) async {
    final ss = await gSheets.spreadsheet(_spreadsheetId);
    final sheet = ss.worksheetByTitle(consolidatedSheet);
    final existingConsolidatedFees =
        await sheet!.values.map.rowByKey(transaction.student.getID());
    if (existingConsolidatedFees != null) {
      final existingFees = existingConsolidatedFees["TotalFeesPaid"];
      transaction.amount =
          (double.parse(existingFees!) + double.parse(transaction.amount))
              .toString();
    }
    final consolidatedFees =
        ConsolidatedFees.fromTransaction(transaction, transaction.amount);
    final row = consolidatedFees.toGsheets();
    await sheet.values.map.insertRowByKey(consolidatedFees.id, row);
  }
}
