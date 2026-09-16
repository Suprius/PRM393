import 'package:lab/models/student.dart';
import 'package:lab/models/teacher.dart';

enum PersonType{
  student,
  teacher
}

class Person{
  final String id;
  final String name;
  Person({required this.id, required this.name});
  factory Person.create({required PersonType personType, required Map<String,dynamic> json}){
    if(personType == PersonType.student) {
      return Student.fromJson(json);
    } else {
      return Teacher.fromJson(json);
    }
  }
}
