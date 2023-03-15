import 'package:flutter/material.dart';
import 'package:hisab/service/student_service.dart';

import '../models/student.dart';

class AutocompleteStudent extends StatelessWidget {
  const AutocompleteStudent({super.key, required this.onSelectParam});

  final Function(Student) onSelectParam;

  static String displayStringForOption(Student student) => student.name;

  @override
  Widget build(BuildContext context) {
    var students = StudentService.instance!.students;
    return Autocomplete<Student>(
      displayStringForOption: displayStringForOption,
      optionsBuilder: (TextEditingValue textEditingValue) {
        if (textEditingValue.text == '') {
          return const Iterable<Student>.empty();
        }
        return students.where((option) => option.name
            .toLowerCase()
            .contains(textEditingValue.text.toLowerCase()));
      },
      onSelected: (Student selection) {
        onSelectParam(selection);
      },
    );
  }
}
