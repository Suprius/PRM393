import 'package:flutter/material.dart';

import '../widgets/home_page_lab4_list_item.dart';
import 'core_widgets_demo.dart';
import 'input_controls_demo.dart';

class HomePageLab4 extends StatelessWidget {
  const HomePageLab4({super.key});

  @override
  Widget build(BuildContext context) => Scaffold(
    appBar: AppBar(title: const Text('Lab 4 – Flutter UI Fundamentals')),
    body: ListView(
      padding: const EdgeInsets.all(16),
      children: const [
        HomePageLab4ListItem(
          title: 'Exercise 1 – Core Widgets Demo',
          destination: CoreWidgetsDemo(),
        ),
        SizedBox(height: 12),
        HomePageLab4ListItem(
          title: 'Exercise 2 – Input Controls Demo',
          destination: InputControlsDemo(),
        ),
      ],
    ),
  );
}
