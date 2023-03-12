import 'package:flutter/material.dart';
import 'package:hisab/service/transaction_service.dart';

import '../models/transaction.dart';

class TransactionItem extends StatelessWidget {
  const TransactionItem({super.key, required this.transaction});
  final Transaction transaction;

  @override
  Widget build(BuildContext context) {
    return Dismissible(
        key: UniqueKey(),
        direction: DismissDirection.endToStart,
        onDismissed: (DismissDirection direction) {
          TransactionService.delete(transaction);
          const snackBar = SnackBar(content: Text('Transaction Deleted!'), backgroundColor: Colors.red);
          ScaffoldMessenger.of(context).showSnackBar(snackBar);
        },
        background: Container(
          alignment: Alignment.centerRight,
          color: Colors.red,
          child: const Icon(Icons.delete),
        ),
        child: Center(
          child: Card(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: <Widget>[
                ListTile(
                  leading:
                      const Icon(Icons.account_balance, color: Colors.green),
                  title: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      const Icon(Icons.currency_rupee_sharp),
                      Text(transaction.amount)
                    ],
                  ),
                  subtitle: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(transaction.student.name),
                      Text(transaction.student.email),
                      Text(transaction.student.school),
                    ],
                  ),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: <Widget>[
                    Text(transaction.dateModified),
                    IconButton(
                        onPressed: () {
                          // Delete transaction
                        },
                        icon: const Icon(
                          Icons.delete,
                          size: 24.0,
                          color: Colors.red,
                        )),
                    const SizedBox(width: 8)
                  ],
                ),
              ],
            ),
          ),
        ));
  }
}
