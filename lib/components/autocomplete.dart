import 'package:flutter/material.dart';

import '../models/student.dart';

class AutocompleteStudent extends StatelessWidget {
  const AutocompleteStudent({super.key, required this.onSelectParam});

  static const List<Student> _userOptions = <Student>[
    Student(name: 'Alice', email: 'alice@example.com', school: 'SBSM'),
    Student(name: 'Bob', email: 'robert@example.com', school: 'JV'),
    Student(name: 'Charlie', email: 'charlie123@gmail.com', school: 'SNMSSS'),
  ];
  final Function(Student) onSelectParam;

  static String _displayStringForOption(Student option) => option.name;

  @override
  Widget build(BuildContext context) {
    return Autocomplete<Student>(
      displayStringForOption: _displayStringForOption,
      optionsBuilder: (TextEditingValue textEditingValue) {
        if (textEditingValue.text == '') {
          return const Iterable<Student>.empty();
        }
        return _userOptions.where((Student option) {
          return option
              .toString()
              .contains(textEditingValue.text.toLowerCase());
        });
      },
      onSelected: (Student selection) {
        onSelectParam(selection);
      },
    );
  }
}