import 'package:flutter/material.dart';
import 'package:hisab/models/transaction.dart';
import '../components/transaction_item.dart';
import '../service/transaction_service.dart';

class Transactions extends StatefulWidget {
  const Transactions({super.key});

  @override
  State<Transactions> createState() => _TransactionState();
}

class _TransactionState extends State<Transactions> {
  late Future<List<Transaction>> transactions;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    transactions = TransactionService.getTransactions();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
          child: FutureBuilder<List<Transaction>>(
              future: transactions,
              builder: (context, snapshot) {
                if (snapshot.hasData) {
                  return ListView.builder(
                    itemCount: snapshot.data!.length,
                    itemBuilder: (BuildContext context, int index) {
                      final Transaction transaction = snapshot.data![index];
                      return Dismissible(
                          key: UniqueKey(),
                          direction: DismissDirection.endToStart,
                          onDismissed: (DismissDirection direction) {
                            TransactionService.delete(transaction);
                            const snackBar = SnackBar(
                                content: Text('Transaction Deleted!'),
                                backgroundColor: Colors.red);
                            ScaffoldMessenger.of(context)
                                .showSnackBar(snackBar);
                          },
                          background: Container(
                            alignment: Alignment.centerRight,
                            color: Colors.red,
                            child: const Icon(Icons.delete),
                          ),
                          child: TransactionItem(transaction: transaction));
                    },
                  );
                } else if (snapshot.hasError) {
                  return Text('${snapshot.error}');
                }
                return const CircularProgressIndicator();
              })),
    );
  }
}
