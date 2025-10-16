import 'package:flutter/material.dart';

class CreatePostPage extends StatefulWidget {
  const CreatePostPage({super.key});

  @override
  State<CreatePostPage> createState() => _CreatePostPageState();
}

class _CreatePostPageState extends State<CreatePostPage> {
  final _textCtrl = TextEditingController();
  bool _sending = false;

  Future<void> _sendPost() async {
    if (_textCtrl.text.trim().isEmpty) return;
    setState(() => _sending = true);
    await Future.delayed(const Duration(seconds: 1)); // simulação
    setState(() => _sending = false);
    Navigator.pop(context);
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text('Post publicado com sucesso!')),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Criar Post'),
        backgroundColor: const Color(0xFF1976D2),
      ),
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          children: [
            TextField(
              controller: _textCtrl,
              maxLines: 5,
              decoration: const InputDecoration(
                hintText: 'O que você quer compartilhar hoje?',
                border: OutlineInputBorder(),
              ),
            ),
            const SizedBox(height: 20),
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: _sending ? null : _sendPost,
                child: _sending
                    ? const SizedBox(
                        height: 20,
                        width: 20,
                        child: CircularProgressIndicator(strokeWidth: 2, color: Colors.white),
                      )
                    : const Text('Publicar'),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
