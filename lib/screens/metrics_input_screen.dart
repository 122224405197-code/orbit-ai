import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/app_state_provider.dart';
import '../theme/app_theme.dart';
import '../models/adaptive_metric.dart';
import 'package:uuid/uuid.dart';

class MetricsInputScreen extends StatefulWidget {
  const MetricsInputScreen({Key? key}) : super(key: key);

  @override
  State<MetricsInputScreen> createState() => _MetricsInputScreenState();
}

class _MetricsInputScreenState extends State<MetricsInputScreen> {
  final Map<String, int> _selectedMetrics = {
    'Energy': 75,
    'Mood': 80,
    'Focus': 70,
    'Stress': 30,
    'Productivity': 75,
  };

  String _selectedCategory = 'Health';
  String? _note;

  final List<String> _categories = [
    'Health',
    'Work',
    'Wellness',
    'Learning',
    'Relationships',
    'Creativity',
    'Finance',
  ];

  void _submitMetrics() {
    final provider = context.read<AppStateProvider>();
    
    for (var entry in _selectedMetrics.entries) {
      final metric = AdaptiveMetric(
        id: const Uuid().v4(),
        userId: 'user_123',
        name: entry.key,
        type: _getMetricType(entry.key),
        category: _selectedCategory,
        value: entry.value,
        note: _note,
      );
      provider.addMetric(metric);
    }

    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text('Metrics saved successfully!')),
    );
    
    Navigator.pop(context);
  }

  MetricType _getMetricType(String name) {
    switch (name.toLowerCase()) {
      case 'energy':
        return MetricType.energy;
      case 'mood':
        return MetricType.mood;
      case 'focus':
        return MetricType.focus;
      case 'stress':
        return MetricType.stress;
      case 'productivity':
        return MetricType.productivity;
      default:
        return MetricType.custom;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Log Your Metrics'),
        elevation: 0,
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'How are you feeling today?',
                style: Theme.of(context).textTheme.headlineSmall,
              ),
              const SizedBox(height: 24),
              ..._selectedMetrics.entries.map((entry) {
                return Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(entry.key),
                        Text(
                          '${entry.value}%',
                          style: TextStyle(
                            color: AppTheme.accentColor,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ],
                    ),
                    Slider(
                      value: entry.value.toDouble(),
                      min: 0,
                      max: 100,
                      onChanged: (value) {
                        setState(() {
                          _selectedMetrics[entry.key] = value.toInt();
                        });
                      },
                    ),
                    const SizedBox(height: 8),
                  ],
                );
              }).toList(),
              const SizedBox(height: 24),
              Text(
                'Category',
                style: Theme.of(context).textTheme.bodyMedium,
              ),
              const SizedBox(height: 8),
              Wrap(
                spacing: 8,
                children: _categories.map((category) {
                  final isSelected = _selectedCategory == category;
                  return FilterChip(
                    label: Text(category),
                    selected: isSelected,
                    onSelected: (selected) {
                      setState(() => _selectedCategory = category);
                    },
                  );
                }).toList(),
              ),
              const SizedBox(height: 24),
              TextField(
                onChanged: (value) => _note = value,
                decoration: InputDecoration(
                  hintText: 'Add a note (optional)',
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                  filled: true,
                  fillColor: AppTheme.surfaceColor,
                ),
                maxLines: 3,
              ),
              const SizedBox(height: 32),
              SizedBox(
                width: double.infinity,
                child: FilledButton(
                  onPressed: _submitMetrics,
                  child: const Text('Save Metrics'),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}