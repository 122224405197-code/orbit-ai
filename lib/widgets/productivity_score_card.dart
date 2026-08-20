import 'package:flutter/material.dart';

class ProductivityScoreCard extends StatelessWidget {
  final int score;

  const ProductivityScoreCard({Key? key, required this.score}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Productivity',
              style: Theme.of(context).textTheme.bodySmall,
            ),
            const SizedBox(height: 8),
            RichText(
              text: TextSpan(
                children: [
                  TextSpan(
                    text: score.toString(),
                    style: Theme.of(context).textTheme.headlineSmall,
                  ),
                  TextSpan(
                    text: '/100',
                    style: Theme.of(context).textTheme.bodySmall,
                  ),
                ],
              ),
            ),
            const SizedBox(height: 8),
            ClipRRect(
              borderRadius: BorderRadius.circular(4),
              child: LinearProgressIndicator(
                value: score / 100,
                minHeight: 4,
                backgroundColor: Colors.grey[800],
                valueColor: const AlwaysStoppedAnimation<Color>
                    (Color(0xFF10B981)),
              ),
            ),
          ],
        ),
      ),
    );
  }
}