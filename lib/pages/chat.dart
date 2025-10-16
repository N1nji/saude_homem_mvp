import 'package:flutter/material.dart';

class ChatPage extends StatelessWidget {
  const ChatPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Mensagens 💬'),
        backgroundColor: const Color(0xFF1976D2),
      ),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          _chatCard(
            name: 'Dr. João Silva',
            lastMessage: 'Olá! Como posso te ajudar hoje?',
            onTap: () {},
          ),
          _chatCard(
            name: 'Usuário Marcos',
            lastMessage: 'Valeu pela dica, mano!',
            onTap: () {},
          ),
          _chatCard(
            name: 'Dr. Ana Costa',
            lastMessage: 'Ok, marque seu horário amanhã ✅',
            onTap: () {},
          ),
        ],
      ),
    );
  }

  Widget _chatCard({
    required String name,
    required String lastMessage,
    required VoidCallback onTap,
  }) {
    return Card(
      margin: const EdgeInsets.symmetric(vertical: 8),
      elevation: 3,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      child: ListTile(
        leading: const CircleAvatar(
          backgroundImage: NetworkImage('https://i.pravatar.cc/150?img=8'),
          radius: 25,
        ),
        title: Text(
          name,
          style: const TextStyle(fontWeight: FontWeight.bold),
        ),
        subtitle: Text(lastMessage, maxLines: 1, overflow: TextOverflow.ellipsis),
        onTap: onTap,
        trailing: const Icon(Icons.chevron_right, color: Colors.blueAccent),
      ),
    );
  }
}
