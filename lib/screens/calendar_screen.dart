import 'package:flutter/material.dart';
import '../widgets/bottom_nav.dart';

class CalendarScreen extends StatelessWidget {
  const CalendarScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Calendar'),
      ),
      body: const Center(
        child: Text('Calendar Screen - Coming Soon'),
      ),
      bottomNavigationBar: const BottomNavWidget(),
    );
  }
}