import 'package:gsheets/gsheets.dart';
import 'package:hisab/models/student.dart';
import 'package:hisab/service/credentials.dart';

const _spreadsheetId =
    '1prCgM_JkpkP_1ZdvD8fW0Hefqv-My9eCECqKXPu0CzU'; //Student particulars 2022

class StudentService {
  final List<Student> students;
  static StudentService? instance;

  StudentService._(this.students);

  static Future<StudentService> init() async {
    final gsheets = GSheets(Credentials);
    final ss = await gsheets.spreadsheet(_spreadsheetId);
    final sheet = ss.worksheetByTitle('Form Responses 1');
    final studentsFromGSheet = await sheet!.values.map.allRows(fromRow: 2);
    final students = studentsFromGSheet!
        .map((student) => Student.fromGsheets(student))
        .toList();
    // ignore: prefer_conditional_assignment
    if (instance == null) {
      instance = StudentService._(students);
    }
    return instance!;
  }
}
