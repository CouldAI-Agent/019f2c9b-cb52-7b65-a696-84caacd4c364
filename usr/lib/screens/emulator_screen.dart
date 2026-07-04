import 'package:flutter/material.dart';

class EmulatorScreen extends StatefulWidget {
  const EmulatorScreen({super.key});

  @override
  State<EmulatorScreen> createState() => _EmulatorScreenState();
}

class _EmulatorScreenState extends State<EmulatorScreen> {
  // Goal: null (unset), true, false
  bool? goal;
  
  // Short Term: A (true), O (false), null (unknown)
  bool? shortTerm;

  // Long Term: E (true), I (false), null (unknown)
  bool? longTerm;

  String _getMachineStatus() {
    if (goal == null) return "Screen Off (Unset Goal)";

    if (shortTerm == null || longTerm == null) {
      return "Unknown / Partial State";
    }

    // Logic resolution based on the rules:
    // Format Conversion: IO=I, IA=O, EO=A, EA=E
    // T = Seek True, F = Seek False
    
    // Evaluate conflicts
    if (goal == true) {
      if (shortTerm == true && longTerm == true) return "Success: Consistent True (EA=E)";
      if (shortTerm == true && longTerm == false) return "Conflict: IA=O (Failed True Goal)";
      if (shortTerm == false && longTerm == true) return "Conflict: EO=A (Failed True Goal)";
      if (shortTerm == false && longTerm == false) return "Failure: IO=I (Inconsistent)";
    } else {
      if (shortTerm == false && longTerm == false) return "Success: Consistent False (IO=I)";
      if (shortTerm == true && longTerm == false) return "Conflict: IA=O (Failed False Goal)";
      if (shortTerm == false && longTerm == true) return "Conflict: EO=A (Failed False Goal)";
      if (shortTerm == true && longTerm == true) return "Failure: EA=E (Inconsistent)";
    }

    return "Evaluating...";
  }

  Color _getStatusColor() {
    final status = _getMachineStatus();
    if (status.contains("Screen Off")) return Colors.black;
    if (status.contains("Unknown")) return Colors.grey;
    if (status.contains("Success")) {
      return goal == true ? Colors.green : Colors.blue; 
    }
    if (status.contains("Conflict")) return Colors.yellow;
    if (status.contains("Failure")) return Colors.red;
    return Colors.black;
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(24.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          const Text(
            'Ten Emulator',
            style: TextStyle(fontSize: 28, fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 24),
          
          // Screen (User API)
          Container(
            padding: const EdgeInsets.all(24),
            decoration: BoxDecoration(
              color: _getStatusColor(),
              borderRadius: BorderRadius.circular(16),
              border: Border.all(color: Colors.white24, width: 2),
            ),
            child: Column(
              children: [
                const Text(
                  'OUTPUT SCREEN',
                  style: TextStyle(color: Colors.white70, fontWeight: FontWeight.bold),
                ),
                const SizedBox(height: 16),
                Text(
                  _getMachineStatus(),
                  style: const TextStyle(
                    color: Colors.white,
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                  ),
                  textAlign: TextAlign.center,
                ),
              ],
            ),
          ),
          const SizedBox(height: 32),
          
          // Goal Controls
          Card(
            color: const Color(0xFF232332),
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                children: [
                  const Text('User API (Goal)', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
                  const SizedBox(height: 16),
                  SegmentedButton<bool?>(
                    segments: const [
                      ButtonSegment(value: true, label: Text('True (T)')),
                      ButtonSegment(value: null, label: Text('Unset')),
                      ButtonSegment(value: false, label: Text('False (F)')),
                    ],
                    selected: {goal},
                    onSelectionChanged: (Set<bool?> newSelection) {
                      setState(() {
                        goal = newSelection.first;
                      });
                    },
                  ),
                ],
              ),
            ),
          ),
          const SizedBox(height: 24),
          
          // Short and Long Term Controls
          LayoutBuilder(
            builder: (context, constraints) {
              final isWide = constraints.maxWidth > 600;
              final shortTermCard = _buildControlCard(
                'Short Term (Local)',
                shortTerm,
                'True (A)',
                'False (O)',
                (val) => setState(() => shortTerm = val),
              );
              final longTermCard = _buildControlCard(
                'Long Term (Global)',
                longTerm,
                'True (E)',
                'False (I)',
                (val) => setState(() => longTerm = val),
              );

              if (isWide) {
                return Row(
                  children: [
                    Expanded(child: shortTermCard),
                    const SizedBox(width: 16),
                    Expanded(child: longTermCard),
                  ],
                );
              } else {
                return Column(
                  children: [
                    shortTermCard,
                    const SizedBox(height: 16),
                    longTermCard,
                  ],
                );
              }
            },
          ),
        ],
      ),
    );
  }

  Widget _buildControlCard(
    String title,
    bool? value,
    String trueLabel,
    String falseLabel,
    Function(bool?) onChanged,
  ) {
    return Card(
      color: const Color(0xFF232332),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            Text(title, style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
            const SizedBox(height: 16),
            SegmentedButton<bool?>(
              segments: [
                ButtonSegment(value: true, label: Text(trueLabel)),
                const ButtonSegment(value: null, label: Text('Unknown')),
                ButtonSegment(value: false, label: Text(falseLabel)),
              ],
              selected: {value},
              onSelectionChanged: (Set<bool?> newSelection) {
                onChanged(newSelection.first);
              },
            ),
          ],
        ),
      ),
    );
  }
}
