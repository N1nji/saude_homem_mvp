import 'package:flutter/material.dart';

class InfoPage extends StatelessWidget {
  const InfoPage({super.key});

  @override
  Widget build(BuildContext context) {
    final infos = [
      'Faça exames preventivos regularmente.',
      'Beba bastante água ao longo do dia.',
      'Pratique atividades físicas pelo menos 30 minutos/dia.',
      'Não tenha vergonha de falar sobre saúde mental.',
    ];

    return Scaffold(
      appBar: AppBar(title: const Text('Informações')),
      body: ListView.separated(
        padding: const EdgeInsets.all(16),
        itemCount: infos.length,
        separatorBuilder: (_, __) => const Divider(),
        itemBuilder: (context, i) => ListTile(
          leading: const Icon(Icons.health_and_safety, color: Colors.indigo),
          title: Text(infos[i]),
        ),
      ),
    );
  }
}