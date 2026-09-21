import 'package:flutter/material.dart';

class InputControlsDemo extends StatefulWidget {
  const InputControlsDemo({super.key});

  @override
  State<InputControlsDemo> createState() => _InputControlsDemoState();
}

class _InputControlsDemoState extends State<InputControlsDemo> {
  double _rating = 50;
  bool _active = false;
  String? _genre;
  DateTime? _selectedDate;

  Future<void> _pickDate() async {
    final date = await showDatePicker(
      context: context,
      initialDate: _selectedDate ?? DateTime.now(),
      firstDate: DateTime(1900),
      lastDate: DateTime(2100, 12, 31),
    );
    if (!mounted || date == null) return;
    setState(() => _selectedDate = date);
  }

  @override
  Widget build(BuildContext context) => Scaffold(
    appBar: AppBar(title: const Text('Exercise 2 – Input Controls Demo')),
    body: ListView(
      padding: const EdgeInsets.all(16),
      children: [
        Text('Rating (Slider)', style: Theme.of(context).textTheme.titleMedium),
        Slider(
          value: _rating,
          min: 0,
          max: 100,
          divisions: 100,
          label: _rating.round().toString(),
          onChanged: (value) => setState(() => _rating = value),
        ),
        Text('Current value: ${_rating.round()}'),
        const SizedBox(height: 24),
        Text('Active (Switch)', style: Theme.of(context).textTheme.titleMedium),
        SwitchListTile(
          contentPadding: EdgeInsets.zero,
          title: const Text('Is movie active?'),
          value: _active,
          onChanged: (value) => setState(() => _active = value),
        ),
        Text('Active: ${_active ? "Yes" : "No"}'),
        const SizedBox(height: 24),
        Text(
          'Genre (RadioListTile)',
          style: Theme.of(context).textTheme.titleMedium,
        ),
        RadioGroup<String>(
          groupValue: _genre,
          onChanged: (value) => setState(() => _genre = value),
          child: const Column(
            children: [
              RadioListTile<String>(title: Text('Action'), value: 'Action'),
              RadioListTile<String>(title: Text('Comedy'), value: 'Comedy'),
            ],
          ),
        ),
        Text('Selected genre: ${_genre ?? "None"}'),
        const SizedBox(height: 24),
        OutlinedButton(
          onPressed: _pickDate,
          child: const Text('Open Date Picker'),
        ),
        const SizedBox(height: 8),
        Text(
          'Selected date: ${_selectedDate == null ? "None" : MaterialLocalizations.of(context).formatMediumDate(_selectedDate!)}',
        ),
      ],
    ),
  );
}
