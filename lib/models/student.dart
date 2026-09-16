import 'package:lab/models/person.dart';

class Student extends Person{
  double? math;
  double? physic;
  double? chem;

  Student({required super.id, required super.name,
    this.math, this.physic, this.chem});
  factory Student.fromJson(Map<String, dynamic> json){
    return Student(id: (json['id']??"") as String,
        name: (json['name']??"") as String,
        math: (json['math'] as num).toDouble(),
        physic: (json['physic'] as num).toDouble(),
        chem: (json['chem'] as num).toDouble());
  }
}