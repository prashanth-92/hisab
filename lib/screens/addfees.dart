import 'package:flutter/material.dart';

import '../components/autocomplete.dart';
import '../models/student.dart';

DialogRoute<void> getAddFeesDialog(BuildContext context, Object? arguments){
  var schoolController = TextEditingController();
    var feesController = TextEditingController();
    return DialogRoute<void>(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Add Fees'),
          content: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              AutocompleteStudent(onSelectParam: (Student student) {
                schoolController.text = student.school;
              }),
              TextField(
                  decoration: const InputDecoration(labelText: 'School'),
                  enabled: false,
                  controller: schoolController),
              TextField(
                  decoration: const InputDecoration(labelText: 'Fees Paid'),
                  keyboardType: const TextInputType.numberWithOptions(
                      decimal: true, signed: false),
                  controller: feesController),
              ElevatedButton.icon(
                onPressed: () {
                  var currentValue = double.tryParse(feesController.text.toString()) ?? 0;
                  var increasedValue = currentValue + 500.00;
                  feesController.text = increasedValue.toString();
                },
                icon: const Icon(Icons.currency_rupee_sharp, size: 24.0),
                label: const Text('500'), 
              ),
            ],
          ),
          actions: <Widget>[
            TextButton(
              style: TextButton.styleFrom(
                textStyle: Theme.of(context).textTheme.labelLarge,
              ),
              child: const Text('Save'),
              onPressed: () {
                Navigator.of(context).pop();
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