import 'package:flutter/material.dart';
import 'package:hisab/models/transaction.dart';

import '../components/transaction_item.dart';
import '../models/student.dart';
import '../service/transaction_service.dart';

class FeesDetails extends StatefulWidget {
  final Student student;
  const FeesDetails({super.key, required this.student});

  @override
  State<FeesDetails> createState() => _FeesDetailsState();
}

class _FeesDetailsState extends State<FeesDetails> {
  List<Transaction>? transactions;
  String? totalFees;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    TransactionService.getTransactionsForStudentWithId(widget.student.getID())
        .then((transactions) => {
              setState(() => {
                    if (transactions.isNotEmpty)
                      {
                        this.transactions = transactions,
                        totalFees = transactions
                            .where((transaction) =>
                                transaction.isActiveTransaction())
                            .map((transaction) =>
                                double.parse(transaction.amount))
                            .reduce((previous, next) => previous + next)
                            .toString()
                      }
                    else
                      {this.transactions = List.empty()}
                  })
            });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text(widget.student.name),
        ),
        backgroundColor: Colors.white,
        body: getTransactions());
  }

  Widget getTransactions() {
    if (transactions != null && transactions!.isEmpty) {
      return getDefaultNoDataFound();
    } else {
      return transactions == null
          ? getCenteredLoader()
          : getTotalFeesAndTransactions();
    }
  }

  Column getDefaultNoDataFound() {
    return Column(children: [
      Expanded(
          child: Container(
        color: Colors.white,
        height: 50.0,
        child: const Center(
          child: Text(
            "No data found",
            style: TextStyle(
              fontSize: 18.0,
              color: Colors.black,
            ),
          ),
        ),
      ))
    ]);
  }

  Column getTotalFeesAndTransactions() {
    return Column(children: [
      Expanded(
          flex: 1,
          child: Text(
            "Total Fees Paid: $totalFees",
            style: const TextStyle(fontSize: 20),
          )),
      Expanded(
          flex: 30,
          child: ListView.builder(
            scrollDirection: Axis.vertical,
            itemCount: transactions!.length,
            itemBuilder: (BuildContext context, int index) {
              return TransactionItem(transaction: transactions![index]);
            },
          ))
    ]);
  }

  Column getCenteredLoader() {
    return Column(children: [
      Expanded(
          child: Container(
        color: Colors.white,
        height: 50.0,
        child: const Center(
          child: CircularProgressIndicator(),
        ),
      ))
    ]);
  }
}
