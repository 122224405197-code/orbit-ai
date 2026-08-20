import 'package:flutter/material.dart';
import '../widgets/bottom_nav.dart';

class NotesScreen extends StatelessWidget {
  const NotesScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Notes'),
      ),
      body: const Center(
        child: Text('Notes Screen - Coming Soon'),
      ),
      bottomNavigationBar: const BottomNavWidget(),
    );
  }
}