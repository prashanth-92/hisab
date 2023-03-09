import 'package:gsheets/gsheets.dart';
import 'package:hisab/models/student.dart';

const _credentials = r'''
{}
''';

const _spreadsheetId =
    '1prCgM_JkpkP_1ZdvD8fW0Hefqv-My9eCECqKXPu0CzU'; //Student particulars 2022

class StudentManager {
  final List<Student> students;
  static StudentManager? instance;

  StudentManager._(this.students);

  static Future<StudentManager> init() async {
    final gsheets = GSheets(_credentials);
    final ss = await gsheets.spreadsheet(_spreadsheetId);
    final sheet = ss.worksheetByTitle('Form Responses 1');
    final studentsFromGSheet = await sheet!.values.map.allRows(fromRow: 2);
    final students = studentsFromGSheet!.map((student) => Student.fromGsheets(student)).toList();
    // ignore: prefer_conditional_assignment
    if (instance == null) {
      instance = StudentManager._(students);
    }
    return instance!;
  }
}
