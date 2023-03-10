import 'package:flutter/material.dart';
import 'package:hisab/models/transaction.dart';
import 'package:hisab/service/transaction_service.dart';
import 'package:uuid/uuid.dart';

import '../components/autocomplete.dart';
import '../models/student.dart';

DialogRoute<void> getAddFeesDialog(BuildContext context, Object? arguments) {
  var uuid = const Uuid();
  var schoolController = TextEditingController();
  var feesController = TextEditingController();
  var classController = TextEditingController();
  var phoneController = TextEditingController();
  String studentName = '';
  return DialogRoute<void>(
    context: context,
    builder: (BuildContext context) {
      return AlertDialog(
        title: const Text('Add Fees'),
        content: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              AutocompleteStudent(onSelectParam: (Student student) {
                schoolController.text = student.school;
                classController.text = student.className;
                phoneController.text = student.phoneNumber;
                studentName = student.name;
              }),
              TextField(
                  decoration: const InputDecoration(labelText: 'Class'),
                  enabled: false,
                  controller: classController),
              TextField(
                  decoration: const InputDecoration(labelText: 'School'),
                  enabled: false,
                  controller: schoolController),
              TextField(
                  decoration: const InputDecoration(labelText: 'Phone'),
                  enabled: false,
                  controller: phoneController),
              TextField(
                  decoration: const InputDecoration(labelText: 'Fees Paid'),
                  keyboardType: const TextInputType.numberWithOptions(
                      decimal: true, signed: false),
                  controller: feesController),
              ElevatedButton.icon(
                onPressed: () {
                  var currentValue =
                      double.tryParse(feesController.text.toString()) ?? 0;
                  var increasedValue = currentValue + 500.00;
                  feesController.text = increasedValue.toString();
                },
                icon: const Icon(Icons.currency_rupee_sharp, size: 24.0),
                label: const Text('500'),
              ),
            ],
          ),
        ),
        actions: <Widget>[
          TextButton(
            style: TextButton.styleFrom(
              textStyle: Theme.of(context).textTheme.labelLarge,
            ),
            child: const Text('Save'),
            onPressed: () {
              final transaction = Transaction(
                  id: uuid.v1(),
                  amount: feesController.text,
                  dateModified: DateTime.now().toString(),
                  isActive: "true",
                  student: Student(
                      email: '',
                      name: studentName,
                      school: schoolController.text,
                      phoneNumber: phoneController.text,
                      className: classController.text));
              TransactionService.save(transaction);
              Navigator.of(context).pop(transaction);
            },
          ),
          TextButton(
            style: TextButton.styleFrom(
              textStyle: Theme.of(context).textTheme.labelLarge,
            ),
            child: const Text('Cancel'),
            onPressed: () {
              Navigator.of(context).pop();
            },
          ),
        ],
      );
    },
  );
}
