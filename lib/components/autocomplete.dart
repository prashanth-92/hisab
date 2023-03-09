import 'package:flutter/material.dart';
import 'package:hisab/service/student_service.dart';

import '../models/student.dart';

class AutocompleteStudent extends StatelessWidget {
  const AutocompleteStudent({super.key, required this.onSelectParam});

  final Function(Student) onSelectParam;

  static String _displayStringForOption(Student student) => student.name;

  @override
  Widget build(BuildContext context) {
    var students = getStudents();
    return Autocomplete<Student>(
      displayStringForOption: _displayStringForOption,
      optionsBuilder: (TextEditingValue textEditingValue) {
        if (textEditingValue.text == '') {
          return const Iterable<Student>.empty();
        }
        return students.where((Student option) {
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