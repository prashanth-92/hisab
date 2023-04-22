import 'package:flutter/material.dart';
import '../models/student.dart';
import '../models/transaction.dart';
import '../screens/add_fees.dart';

class StudentItem extends StatelessWidget {
  const StudentItem({super.key, required this.student});
  final Student student;

  @override
  Widget build(BuildContext context) {
    return Center(
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
              trailing: IconButton(
                icon: const Icon(Icons.add),
                onPressed: () async {
                  final result = await Navigator.push(
                      context,
                      PageRouteBuilder(
                          opaque: false,
                          pageBuilder: (BuildContext context, _, __) =>
                              AddFees.fromStudent(student)));
                  const snackBar = SnackBar(
                      content: Text('Transaction Added!'),
                      backgroundColor: Colors.green);
                  if (result.runtimeType != Transaction) {
                    return;
                  }
                  // ignore: use_build_context_synchronously
                  ScaffoldMessenger.of(context).showSnackBar(snackBar);
                },
              ),
            ),
          ],
        ),
      ),
    );
  }

  String truncateWithEllipsis(String data, int cutoff) {
    return (data.length <= cutoff) ? data : '${data.substring(0, cutoff)}...';
  }
}
