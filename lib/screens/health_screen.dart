import 'package:flutter/material.dart';
import '../widgets/bottom_nav.dart';

class HealthScreen extends StatelessWidget {
  const HealthScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Health'),
      ),
      body: const Center(
        child: Text('Health Screen - Coming Soon'),
      ),
      bottomNavigationBar: const BottomNavWidget(),
    );
  }
}