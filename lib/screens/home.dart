import 'package:flutter/material.dart';
import 'package:hisab/models/transaction.dart';
import 'package:hisab/screens/addfees.dart';

import '../components/transaction_item.dart';
import '../service/transaction_service.dart';

class Home extends StatefulWidget {
  const Home({super.key, required this.title});
  final String title;

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  late Future<List<Transaction>> transactions;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    transactions = TransactionService.getTransactions();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
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
        onPressed: () async {
          final result =
              await Navigator.push(context, _dialogBuilder(context, null));
          if (!mounted || result.runtimeType != Transaction) {
            return;
          }
          final existingTransactions = await transactions;
          setState(() {
            existingTransactions.add(result as Transaction);
          });
        },
        child: const Icon(Icons.add),
      ),
    );
  }

  Route<Object?> _dialogBuilder(BuildContext context, Object? arguments) {
    return getAddFeesDialog(context, arguments);
  }
}
