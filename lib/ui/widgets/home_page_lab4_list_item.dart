import 'package:flutter/material.dart';

class HomePageLab4ListItem extends StatelessWidget {
  const HomePageLab4ListItem({
    super.key,
    required this.title,
    required this.destination,
  });
  final String title;
  final Widget destination;

  @override
  Widget build(BuildContext context) => Card(
    child: ListTile(
      contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      title: Text(title),
      trailing: const Icon(Icons.chevron_right),
      onTap: () =>
          Navigator.of(context)
              .push(MaterialPageRoute<void>(builder: (_) => destination)),
    ),
  );
}
