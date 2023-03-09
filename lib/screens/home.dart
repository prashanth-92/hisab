import 'package:flutter/material.dart';
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
  var txns = getTransactions();
  @override
  Widget build(BuildContext context) {
    var transactions = getTransactions();
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: ListView.builder(
        itemCount: transactions.length, 
        itemBuilder: (BuildContext context, int index) { 
          return TransactionItem(transaction: txns[index]);
         },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.of(context).restorablePush(_dialogBuilder);
        },
        child: const Icon(Icons.add),
      ),
    );
  }

  static Route<Object?> _dialogBuilder(
      BuildContext context, Object? arguments) {
    return getAddFeesDialog(context, arguments);
  }
}
