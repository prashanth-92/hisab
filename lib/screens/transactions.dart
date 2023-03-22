import 'package:flutter/material.dart';
import 'package:hisab/models/transaction.dart';
import 'package:hisab/screens/add_fees.dart';

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
                      return TransactionItem(
                          transaction: snapshot.data![index]);
                    },
                  );
                } else if (snapshot.hasError) {
                  return Text('${snapshot.error}');
                }
                return const CircularProgressIndicator();
              })),
      floatingActionButton: FloatingActionButton(
        onPressed: _addNewTransaction,
        child: const Icon(Icons.add),
      ),
    );
  }

  _addNewTransaction() async {
    final result = await Navigator.push(
        context,
        PageRouteBuilder(
            opaque: false,
            pageBuilder: (BuildContext context, _, __) => const AddFees()));
    if (!mounted || result.runtimeType != Transaction) {
      return;
    }
    final existingTransactions = await transactions;
    setState(() {
      existingTransactions.add(result as Transaction);
    });
    const snackBar = SnackBar(
        content: Text('Transaction Added!'), backgroundColor: Colors.green);
    // ignore: use_build_context_synchronously
    ScaffoldMessenger.of(context).showSnackBar(snackBar);
  }
}
