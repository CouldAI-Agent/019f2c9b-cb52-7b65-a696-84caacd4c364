import 'package:flutter/material.dart';

class TheoryScreen extends StatelessWidget {
  const TheoryScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Theory')),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(24.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Ten Emulator Theory',
              style: Theme.of(context).textTheme.headlineMedium?.copyWith(
                    fontWeight: FontWeight.bold,
                  ),
            ),
            const SizedBox(height: 16),
            const Text(
              'While Ten is primarily a tool rather than a theory, its theoretical and mathematical foundations can be extracted from its core logical framework:',
              style: TextStyle(fontSize: 16),
            ),
            const SizedBox(height: 24),
            _buildSection(
              context,
              title: 'State Space and Tri-Band Structure',
              content: 'Ten is a finite constraint solver based on three parallel bands of truth, creating a state space of 27 possible states (3 × 3 × 3):\n'
                  '• Bool band (Goal): {True, False, Unknown}\n'
                  '• Short band (Immediate): {A, O, Unknown}\n'
                  '• Long band (Stabilized): {E, I, Unknown}',
            ),
            _buildSection(
              context,
              title: 'Mathematical Implication Rules',
              content: 'The theory relies on a finite implication graph (combinatorics) rather than standard proof calculus. Implications act as logical arrows between bands:\n'
                  '• A ⇒ E (If short is A, long must be E)\n'
                  '• E ⇒ A (If long is E, short must be A)\n'
                  '• O ⇒ I and I ⇒ O (For goal False)',
            ),
            _buildSection(
              context,
              title: 'Paradox and Consistency Theory',
              content: 'Ten functions as a function mapping: State → {True, False, Unknown, Contradiction}. It theoretically addresses classical paradoxes by hosting them as local states rather than system crashes:\n'
                  '• Turing-style Undecidability: Ten represents undecidable fragments by refusing to commit, remaining Unknown or returning Contradiction.\n'
                  '• Liar & Barber Paradoxes: When combinations force incompatible values, the implication graph detects a cyclic contradiction. Ten marks this as a Contradiction, allowing the system to see and avoid the paradoxical state rather than blindly accepting a boolean logic collapse.',
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildSection(BuildContext context, {required String title, required String content}) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 24.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            title,
            style: Theme.of(context).textTheme.titleLarge?.copyWith(
                  fontWeight: FontWeight.w600,
                  color: Theme.of(context).colorScheme.primary,
                ),
          ),
          const SizedBox(height: 12),
          Text(
            content,
            style: const TextStyle(fontSize: 16, height: 1.5),
          ),
        ],
      ),
    );
  }
}
