import 'package:flutter/material.dart';
import '../widgets/info_card.dart';

class InfoPanelPage extends StatelessWidget {
  const InfoPanelPage({super.key});

  void _showDialog(BuildContext context, String title, String message) {
    showDialog(
      context: context,
      builder: (_) => AlertDialog(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(20),
        ),
        title: Text(title, style: const TextStyle(fontWeight: FontWeight.bold)),
        content: Text(message, textAlign: TextAlign.center),
        actionsAlignment: MainAxisAlignment.center,
        actions: [
          ElevatedButton(
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.blueAccent,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12),
              ),
            ),
            onPressed: () => Navigator.pop(context),
            child: const Text('Fechar'),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final cards = [
      {
        'title': 'Exames Preventivos',
        'icon': Icons.local_hospital,
        'color': Colors.blue,
        'message':
            'Homens devem realizar exames de rotina como PSA e check-ups anuais para prevenção do câncer de próstata. 💙',
      },
      {
        'title': 'Saúde Mental',
        'icon': Icons.psychology_alt,
        'color': Colors.deepPurple,
        'message':
            'Cuidar da mente é essencial! Converse com profissionais e pratique atividades que te façam bem. 🧘‍♂️',
      },
      {
        'title': 'Hábitos Saudáveis',
        'icon': Icons.directions_run,
        'color': Colors.green,
        'message':
            'Alimente-se bem, pratique exercícios e durma bem. Pequenas mudanças trazem grandes resultados! 🏃‍♂️',
      },
      {
        'title': 'Novembro Azul 💙',
        'icon': Icons.video_collection,
        'color': Colors.indigo,
        'message': '',
        'action': (BuildContext context) {
          Navigator.pushNamed(context, '/video');
        },
      },
    ];

    return Scaffold(
      appBar: AppBar(
        title: const Text("Painel de Informações 🩺"),
        backgroundColor: Colors.blueAccent,
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: GridView.count(
          crossAxisCount: 2,
          crossAxisSpacing: 15,
          mainAxisSpacing: 15,
          children: cards.map((c) {
            final title = c['title'] as String;
            final message = c['message'] as String;
            final icon = c['icon'] as IconData;
            final color = c['color'] as Color;

            return InfoCard(
              title: title,
              icon: icon,
              color: color,
              onTap: () {
                if (c['action'] != null) {
                  // Se o card tiver uma ação personalizada, executa ela
                  (c['action'] as Function)(context);
                } else {
                  // Senão, mostra o diálogo normal
                  _showDialog(context, title, message);
                }
              },
            );
          }).toList(),
        ),
      ),
    );
  }
}
