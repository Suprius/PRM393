import 'package:lab/models/person.dart';

class Teacher extends Person{
  List<String>? subject;
  Teacher({required super.id, required super.name, this.subject});
  factory Teacher.fromJson(Map<String, dynamic> json){
    return Teacher(id: (json['id']??"") as String,
        name: (json['name']??"") as String,
        subject: (json['subject']??[]) as List<String>);
  }
}