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
  late Future<List<Transaction>> transactions;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    transactions = TransactionService.getTransactionsForStudentWithId(
        widget.student.getID());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.student.name),
      ),
      backgroundColor: Colors.white.withOpacity(0.85),
      body: Center(
          child: FutureBuilder<List<Transaction>>(
              future: transactions,
              builder: (context, snapshot) {
                if (snapshot.hasData) {
                  if (snapshot.data!.isEmpty) {
                    return const Text("No data available");
                  } else {
                    return ListView.builder(
                      itemCount: snapshot.data!.length,
                      itemBuilder: (BuildContext context, int index) {
                        return TransactionItem(
                            transaction: snapshot.data![index]);
                      },
                    );
                  }
                } else if (snapshot.hasError) {
                  return Text('${snapshot.error}');
                }
                return const CircularProgressIndicator();
              })),
    );
  }
}
