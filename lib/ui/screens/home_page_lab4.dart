import 'package:flutter/material.dart';

import '../widgets/home_page_lab4_list_item.dart';
import 'core_widgets_demo.dart';
import 'input_controls_demo.dart';
import 'layout_demo.dart';
import 'app_structure_demo.dart';
import 'common_ui_fixes_demo.dart';

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
        SizedBox(height: 12),
        HomePageLab4ListItem(
          title: 'Exercise 3 – Layout Demo',
          destination: LayoutDemo(),
        ),
        SizedBox(height: 12),
        HomePageLab4ListItem(
          title: 'Exercise 4 – App Structure & Theme',
          destination: AppStructureDemo(),
        ),
        SizedBox(height: 12),
        HomePageLab4ListItem(
          title: 'Exercise 5 – Common UI Fixes',
          destination: CommonUiFixesDemo(),
        ),
      ],
    ),
  );
}
