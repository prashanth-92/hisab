import '../models/student.dart';

const List<Student> students = <Student>[
  Student(name: 'Alice', email: 'alice@example.com', school: 'SBSM'),
  Student(name: 'Bob', email: 'robert@example.com', school: 'JV'),
  Student(name: 'Charlie', email: 'charlie123@gmail.com', school: 'SNMSSS'),
];

List<Student> getStudents() {
  //return http.get(Uri.parse('https://jsonplaceholder.typicode.com/albums/1'));
  return students;
}