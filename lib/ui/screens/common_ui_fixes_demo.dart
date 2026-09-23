import 'package:flutter/material.dart';

class CommonUiFixesDemo extends StatefulWidget {
  const CommonUiFixesDemo({super.key});

  @override
  State<CommonUiFixesDemo> createState() => _CommonUiFixesDemoState();
}

class _CommonUiFixesDemoState extends State<CommonUiFixesDemo> {
  static const _movies = ['Movie A', 'Movie B', 'Movie C', 'Movie D'];
  int _counter = 0;
  DateTime? _selectedDate;

  Future<void> _pickDate() async {
    // context của State nằm dưới MaterialApp, có Navigator và localizations.
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
    appBar: AppBar(title: const Text('Exercise 5 – Common UI Fixes')),
    body: SafeArea(
      // Sửa overflow: nội dung dài cuộn được trên màn hình nhỏ.
      child: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Text(
              'Correct ListView inside Column using Expanded',
              style: Theme.of(context).textTheme.titleMedium,
            ),
            const SizedBox(height: 12),
            // SingleChildScrollView không giới hạn chiều cao: cấp chiều cao
            // hữu hạn trước khi dùng Expanded trong Column bên trong.
            SizedBox(
              height: 240,
              child: Column(
                children: [
                  Expanded(
                    child: ListView.builder(
                      primary: false,
                      itemCount: _movies.length,
                      itemBuilder: (context, index) => ListTile(
                        leading: const Icon(Icons.movie),
                        title: Text(_movies[index]),
                      ),
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 16),
            Text(
              'Scrollable content on small screens',
              style: Theme.of(context).textTheme.titleMedium,
            ),
            const SizedBox(height: 8),
            const Text('Scroll down to try the counter and date picker.'),
            const SizedBox(height: 16),
            Text('Counter: $_counter'),
            const SizedBox(height: 8),
            FilledButton.icon(
              // Sửa state: setState yêu cầu Flutter vẽ lại giá trị mới.
              onPressed: () => setState(() => _counter++),
              icon: const Icon(Icons.add),
              label: const Text('Increment counter'),
            ),
            const SizedBox(height: 16),
            Text(
              'Selected date: ${_selectedDate == null ? "None" : MaterialLocalizations.of(context).formatMediumDate(_selectedDate!)}',
            ),
            const SizedBox(height: 8),
            OutlinedButton(
              onPressed: _pickDate,
              child: const Text('Open Date Picker'),
            ),
          ],
        ),
      ),
    ),
  );
}
