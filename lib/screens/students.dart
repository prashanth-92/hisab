import 'package:flutter/material.dart';
import 'package:hisab/components/student_item.dart';
import 'package:hisab/service/student_service.dart';
import '../models/student.dart';

class Students extends StatefulWidget {
  const Students({super.key});

  @override
  State<Students> createState() => _StudentsState();
}

class _StudentsState extends State<Students> {
  late Future<List<Student>> students;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    students = Future.value(StudentService.instance!.students);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
          child: FutureBuilder<List<Student>>(
              future: students,
              builder: (context, snapshot) {
                if (snapshot.hasData) {
                  return ListView.builder(
                    itemCount: snapshot.data!.length,
                    itemBuilder: (BuildContext context, int index) {
                      return StudentItem(student: snapshot.data![index]);
                    },
                  );
                } else if (snapshot.hasError) {
                  return Text('${snapshot.error}');
                }
                return const CircularProgressIndicator();
              })),
    );
  }
}
