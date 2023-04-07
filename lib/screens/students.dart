import 'package:flutter/material.dart';
import 'package:hisab/components/student_item.dart';
import 'package:hisab/screens/fees_details.dart';
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
      appBar: AppBar(
        title: const TextField(
          decoration: InputDecoration(
              icon: Icon(Icons.search), hintText: "Search here"),
        ),
        backgroundColor: Colors.white,
      ),
      body: Center(
          child: FutureBuilder<List<Student>>(
              future: students,
              builder: (context, snapshot) {
                return _populateView(snapshot);
              })),
    );
  }

  Widget _populateView(AsyncSnapshot<List<Student>> snapshot) {
    if (snapshot.hasData) {
      return ListView.builder(
        itemCount: snapshot.data!.length,
        itemBuilder: (BuildContext context, int index) {
          return ListTile(
              title: StudentItem(student: snapshot.data![index]),
              onTap: () {
                final Student student = snapshot.data![index];
                Navigator.push(
                    context,
                    PageRouteBuilder(
                        opaque: false,
                        pageBuilder: (BuildContext context, _, __) =>
                            FeesDetails(student: student)));
              });
          //return StudentItem(student: snapshot.data![index]);
        },
      );
    } else if (snapshot.hasError) {
      return Text('${snapshot.error}');
    }
    return const CircularProgressIndicator();
  }
}
