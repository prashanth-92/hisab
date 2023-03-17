import 'package:flutter/material.dart';
import '../models/student.dart';

class StudentItem extends StatelessWidget {
  const StudentItem({super.key, required this.student});
  final Student student;

  @override
  Widget build(BuildContext context) {
    return Dismissible(
        key: UniqueKey(),
        direction: DismissDirection.endToStart,
        onDismissed: (DismissDirection direction) {
          // TransactionService.delete(transaction);
          // const snackBar = SnackBar(content: Text('Transaction Deleted!'), backgroundColor: Colors.red);
          // ScaffoldMessenger.of(context).showSnackBar(snackBar);
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
                  leading: const Icon(Icons.school, color: Colors.green),
                  title: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [Text(student.name)],
                  ),
                  subtitle: Column(
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(student.className),
                          const Text(" "),
                          Text(truncateWithEllipsis(student.school, 35))
                        ],
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(student.phoneNumber),
                        ],
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ));
  }

  String truncateWithEllipsis(String data, int cutoff) {
    return (data.length <= cutoff)
        ? data
        : '${data.substring(0, cutoff)}...';
  }
}
