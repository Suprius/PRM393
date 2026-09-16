import 'package:flutter/material.dart';

void main() {
  // List<int> x=[1,3,5,7,9];
  // List<int> y=[...x,for(var z in x) if(z%2==0) z+1];
  // print(y);
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});
  @override
  Widget build(BuildContext context) {
    return const MaterialApp(home: Scaffold(body: BodyScreen()));
  }
}

class BodyScreen extends StatelessWidget {
  const BodyScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return const Center(child: Text("This is the first time with flutter!"));
  }
}
