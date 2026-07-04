import 'package:flutter/material.dart';

class ResourcesScreen extends StatelessWidget {
  const ResourcesScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Resources')),
      body: ListView(
        padding: const EdgeInsets.all(24.0),
        children: [
          Text(
            'Ecosystem Resources',
            style: Theme.of(context).textTheme.headlineMedium?.copyWith(
                  fontWeight: FontWeight.bold,
                ),
          ),
          const SizedBox(height: 24),
          _buildResourceCard(
            context,
            title: 'LaeLogecsLogex GitHub Repository',
            subtitle: 'The primary source of the Ten Emulator specification and Laegna Logex theory.',
            url: 'https://github.com/tambetvali/LaeLogecsLogex',
            icon: Icons.code,
          ),
          _buildResourceCard(
            context,
            title: 'SpiReason',
            subtitle: 'Explore the broader philosophical and logical concepts.',
            url: 'https://spireason.neocities.org',
            icon: Icons.auto_awesome,
          ),
          _buildResourceCard(
            context,
            title: 'Tambet Vali on GitHub',
            subtitle: 'More repositories and tools in the ecosystem.',
            url: 'https://github.com/tambetvali',
            icon: Icons.person,
          ),
        ],
      ),
    );
  }

  Widget _buildResourceCard(
    BuildContext context, {
    required String title,
    required String subtitle,
    required String url,
    required IconData icon,
  }) {
    return Card(
      margin: const EdgeInsets.only(bottom: 16.0),
      color: const Color(0xFF242430),
      elevation: 2,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      child: ListTile(
        contentPadding: const EdgeInsets.all(16.0),
        leading: Container(
          padding: const EdgeInsets.all(12),
          decoration: BoxDecoration(
            color: Theme.of(context).colorScheme.primary.withOpacity(0.2),
            shape: BoxShape.circle,
          ),
          child: Icon(icon, color: Theme.of(context).colorScheme.primary),
        ),
        title: Text(
          title,
          style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
        ),
        subtitle: Padding(
          padding: const EdgeInsets.only(top: 8.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(subtitle),
              const SizedBox(height: 8),
              Text(
                url,
                style: TextStyle(
                  color: Colors.blue[300],
                  decoration: TextDecoration.underline,
                ),
              ),
            ],
          ),
        ),
        isThreeLine: true,
      ),
    );
  }
}
