import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/app_state_provider.dart';
import '../models/user_profile.dart';
import '../theme/app_theme.dart';

class OnboardingScreen extends StatefulWidget {
  const OnboardingScreen({Key? key}) : super(key: key);

  @override
  State<OnboardingScreen> createState() => _OnboardingScreenState();
}

class _OnboardingScreenState extends State<OnboardingScreen> {
  late PageController _pageController;
  int _currentPage = 0;
  String _userName = '';
  List<UserLifestyle> _selectedLifestyles = [];
  List<UserGoal> _selectedGoals = [];

  @override
  void initState() {
    super.initState();
    _pageController = PageController();
  }

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  void _nextPage() {
    _pageController.nextPage(
      duration: const Duration(milliseconds: 300),
      curve: Curves.easeInOut,
    );
  }

  void _previousPage() {
    _pageController.previousPage(
      duration: const Duration(milliseconds: 300),
      curve: Curves.easeInOut,
    );
  }

  void _completeOnboarding() {
    if (_userName.isEmpty || _selectedLifestyles.isEmpty || _selectedGoals.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Please complete all steps')),
      );
      return;
    }

    final profile = UserProfile(
      userId: 'user_${DateTime.now().millisecondsSinceEpoch}',
      name: _userName,
      lifestyles: _selectedLifestyles,
      priorities: _selectedGoals,
      isAIEnabled: true,
      allowsNotifications: true,
    );

    // Save profile and navigate to dashboard
    context.read<AppStateProvider>().setUserProfile(profile);
    Navigator.of(context).pushReplacementNamed('/dashboard');
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: PageView(
        controller: _pageController,
        onPageChanged: (page) => setState(() => _currentPage = page),
        children: [
          _buildWelcomePage(),
          _buildNamePage(),
          _buildLifestylePage(),
          _buildGoalsPage(),
          _buildSummaryPage(),
        ],
      ),
    );
  }

  Widget _buildWelcomePage() {
    return Container(
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [
            AppTheme.primaryColor,
            AppTheme.accentColor,
          ],
        ),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const SizedBox(height: 40),
          const Icon(Icons.public, size: 80, color: Colors.white),
          const SizedBox(height: 24),
          Text(
            'Welcome to Orbit AI',
            style: Theme.of(context).textTheme.displayMedium?.copyWith(
                  color: Colors.white,
                ),
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: 16),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 24),
            child: Text(
              'Your Life Tracker - Personalized to Your Unique Journey',
              style: Theme.of(context).textTheme.titleLarge?.copyWith(
                    color: Colors.white70,
                  ),
              textAlign: TextAlign.center,
            ),
          ),
          const SizedBox(height: 60),
          FilledButton(
            onPressed: _nextPage,
            child: const Text('Get Started'),
          ),
          const SizedBox(height: 40),
        ],
      ),
    );
  }

  Widget _buildNamePage() {
    return Padding(
      padding: const EdgeInsets.all(24.0),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            "What's your name?",
            style: Theme.of(context).textTheme.displayMedium,
          ),
          const SizedBox(height: 32),
          TextField(
            onChanged: (value) => setState(() => _userName = value),
            decoration: InputDecoration(
              hintText: 'Enter your name',
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(12),
              ),
              filled: true,
              fillColor: AppTheme.surfaceColor,
            ),
            style: Theme.of(context).textTheme.bodyLarge,
          ),
          const SizedBox(height: 40),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              OutlinedButton(
                onPressed: _previousPage,
                child: const Text('Back'),
              ),
              FilledButton(
                onPressed: _userName.isNotEmpty ? _nextPage : null,
                child: const Text('Next'),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildLifestylePage() {
    return SingleChildScrollView(
      child: Padding(
        padding: const EdgeInsets.all(24.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(height: 32),
            Text(
              'Select Your Lifestyle',
              style: Theme.of(context).textTheme.displayMedium,
            ),
            const SizedBox(height: 8),
            Text(
              'Choose all that apply',
              style: Theme.of(context).textTheme.bodyMedium,
            ),
            const SizedBox(height: 24),
            Wrap(
              spacing: 12,
              runSpacing: 12,
              children: UserLifestyle.values.map((lifestyle) {
                final isSelected = _selectedLifestyles.contains(lifestyle);
                return FilterChip(
                  label: Text(_formatEnum(lifestyle.toString())),
                  selected: isSelected,
                  onSelected: (selected) {
                    setState(() {
                      if (selected) {
                        _selectedLifestyles.add(lifestyle);
                      } else {
                        _selectedLifestyles.remove(lifestyle);
                      }
                    });
                  },
                );
              }).toList(),
            ),
            const SizedBox(height: 40),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                OutlinedButton(
                  onPressed: _previousPage,
                  child: const Text('Back'),
                ),
                FilledButton(
                  onPressed: _selectedLifestyles.isNotEmpty ? _nextPage : null,
                  child: const Text('Next'),
                ),
              ],
            ),
            const SizedBox(height: 40),
          ],
        ),
      ),
    );
  }

  Widget _buildGoalsPage() {
    return SingleChildScrollView(
      child: Padding(
        padding: const EdgeInsets.all(24.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(height: 32),
            Text(
              'What Are Your Priorities?',
              style: Theme.of(context).textTheme.displayMedium,
            ),
            const SizedBox(height: 8),
            Text(
              'Select your top goals',
              style: Theme.of(context).textTheme.bodyMedium,
            ),
            const SizedBox(height: 24),
            Wrap(
              spacing: 12,
              runSpacing: 12,
              children: UserGoal.values.map((goal) {
                final isSelected = _selectedGoals.contains(goal);
                return FilterChip(
                  label: Text(_formatEnum(goal.toString())),
                  selected: isSelected,
                  onSelected: (selected) {
                    setState(() {
                      if (selected) {
                        _selectedGoals.add(goal);
                      } else {
                        _selectedGoals.remove(goal);
                      }
                    });
                  },
                );
              }).toList(),
            ),
            const SizedBox(height: 40),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                OutlinedButton(
                  onPressed: _previousPage,
                  child: const Text('Back'),
                ),
                FilledButton(
                  onPressed: _selectedGoals.isNotEmpty ? _nextPage : null,
                  child: const Text('Next'),
                ),
              ],
            ),
            const SizedBox(height: 40),
          ],
        ),
      ),
    );
  }

  Widget _buildSummaryPage() {
    return SingleChildScrollView(
      child: Padding(
        padding: const EdgeInsets.all(24.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(height: 32),
            Text(
              'You\'re All Set!',
              style: Theme.of(context).textTheme.displayMedium,
            ),
            const SizedBox(height: 24),
            Card(
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    _buildSummaryRow('Name', _userName),
                    const SizedBox(height: 12),
                    _buildSummaryRow(
                      'Lifestyles',
                      _selectedLifestyles
                          .map((e) => _formatEnum(e.toString()))
                          .join(', '),
                    ),
                    const SizedBox(height: 12),
                    _buildSummaryRow(
                      'Goals',
                      _selectedGoals
                          .map((e) => _formatEnum(e.toString()))
                          .join(', '),
                    ),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 40),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                OutlinedButton(
                  onPressed: _previousPage,
                  child: const Text('Back'),
                ),
                FilledButton(
                  onPressed: _completeOnboarding,
                  child: const Text('Start Tracking'),
                ),
              ],
            ),
            const SizedBox(height: 40),
          ],
        ),
      ),
    );
  }

  Widget _buildSummaryRow(String label, String value) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: Theme.of(context).textTheme.bodyMedium,
        ),
        const SizedBox(height: 4),
        Text(
          value,
          style: Theme.of(context).textTheme.bodyLarge,
        ),
      ],
    );
  }

  String _formatEnum(String enumString) {
    return enumString
        .split('.')
        .last
        .replaceAllMapped(RegExp(r'([A-Z])'), (match) => ' ${match.group(1)}')
        .trim()
        .replaceFirst(' ', '');
  }
}