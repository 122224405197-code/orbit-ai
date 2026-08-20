import 'package:flutter/material.dart';
import '../widgets/bottom_nav.dart';

class FinanceScreen extends StatelessWidget {
  const FinanceScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Finance'),
      ),
      body: const Center(
        child: Text('Finance Screen - Coming Soon'),
      ),
      bottomNavigationBar: const BottomNavWidget(),
    );
  }
}