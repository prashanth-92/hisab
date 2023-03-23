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
    print(transaction.student.getID());
    final consolidatedFees =
        ConsolidatedFees.fromTransaction(transaction, transaction.amount);
    final row = consolidatedFees.toGsheets();
    await sheet!.values.map
        .insertRowByKey(consolidatedFees.id, row, appendMissing: true);
    print("Complete===>");
    await sheet.values.rowByKey(transaction.student.getID());
    final data = await sheet.values.map.rowByKey(transaction.student.getID(), fromColumn: 1);
    print(ConsolidatedFees.fromGsheets(data!));
  }
}
