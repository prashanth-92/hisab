import 'package:flutter/material.dart';
import 'package:uuid/uuid.dart';

import '../components/autocomplete.dart';
import '../models/student.dart';
import '../models/transaction.dart';
import '../service/transaction_service.dart';

class AddFees extends StatefulWidget {
  const AddFees({super.key});

  @override
  State<StatefulWidget> createState() => AddFeesDialogState();
}

class AddFeesDialogState extends State<AddFees> {
  var uuid = const Uuid();
  var schoolController = TextEditingController();
  var feesController = TextEditingController();
  var classController = TextEditingController();
  var phoneController = TextEditingController();
  String studentName = '';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Add Fees"),
      ),
      backgroundColor: Colors.white.withOpacity(0.85),
      body: Padding(
        padding: const EdgeInsets.all(25.0),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
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
              Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  ElevatedButton.icon(
                    onPressed: () {
                      _applyAmount(feesController, 500);
                    },
                    icon: const Icon(Icons.currency_rupee_sharp, size: 24.0),
                    label: const Text('+500'),
                    style: _getAmountButtonStyle(true),
                  ),
                  const SizedBox(width: 20),
                  ElevatedButton.icon(
                    onPressed: () {
                      _applyAmount(feesController, -500);
                    },
                    icon: const Icon(Icons.currency_rupee_sharp, size: 24.0),
                    label: const Text('-500'),
                    style: _getAmountButtonStyle(false),
                  ),
                ],
              ),
              Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  ElevatedButton.icon(
                    onPressed: () {
                      _applyAmount(feesController, 2000);
                    },
                    icon: const Icon(Icons.currency_rupee_sharp, size: 24.0),
                    label: const Text('+2000'),
                    style: _getAmountButtonStyle(true),
                  ),
                  const SizedBox(width: 20),
                  ElevatedButton.icon(
                    onPressed: () {
                      _applyAmount(feesController, -2000);
                    },
                    icon: const Icon(Icons.currency_rupee_sharp, size: 24.0),
                    label: const Text('-2000'),
                    style: _getAmountButtonStyle(false),
                  ),
                ],
              ),
              const SizedBox(height: 30),
              Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  ElevatedButton.icon(
                    icon: const Icon(Icons.save_sharp, size: 24.0),
                    style: TextButton.styleFrom(
                      textStyle: Theme.of(context).textTheme.labelLarge,
                    ),
                    label: const Text('Save'),
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
                  const SizedBox(width: 10),
                  ElevatedButton.icon(
                    icon: const Icon(Icons.close_sharp, size: 24.0),
                    style: TextButton.styleFrom(
                      textStyle: Theme.of(context).textTheme.labelLarge,
                    ),
                    label: const Text('Cancel'),
                    onPressed: () {
                      Navigator.of(context).pop();
                    },
                  )
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  _applyAmount(TextEditingController feesController, int amount) {
    var currentValue = double.tryParse(feesController.text.toString()) ?? 0;
    var increasedValue = currentValue + amount;
    feesController.text = increasedValue.toString();
  }

  _getAmountButtonStyle(bool isPositive) {
    return ButtonStyle(
        fixedSize: MaterialStateProperty.all(const Size.fromWidth(100)),
        backgroundColor:
            MaterialStateProperty.all(isPositive ? Colors.green : Colors.red));
  }
}
