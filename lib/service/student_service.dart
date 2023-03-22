import 'package:gsheets/gsheets.dart';
import 'package:hisab/models/student.dart';
import 'package:hisab/service/credentials.dart';

const _spreadsheetId =
    '1u0SjVsmxk6m3lcncFodZ_6zpc0qX8fb3w1xLlNjfPrw'; //Student particulars 2023-2024
const sheetName = 'Form Responses 1';

class StudentService {
  final List<Student> students;
  static StudentService? instance;

  StudentService._(this.students);

  static Future<StudentService> init() async {
    final gsheets = GSheets(credentials);
    final ss = await gsheets.spreadsheet(_spreadsheetId);
    final sheet = ss.worksheetByTitle(sheetName);
    final studentsFromGSheet = await sheet!.values.map.allRows(fromRow: 2);
    if (studentsFromGSheet == null) {
      instance ??= StudentService._(List.empty());
      return instance!;
    }
    final students = studentsFromGSheet
        .map((student) => Student.fromGsheets(student))
        .toSet()
        .toList();
    // ignore: prefer_conditional_assignment
    if (instance == null) {
      instance = StudentService._(students);
    }
    return instance!;
  }
}
