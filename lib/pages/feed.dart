import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/feed_provider.dart';
import '../widgets/post_card.dart';

class FeedPage extends StatefulWidget {
  const FeedPage({super.key});

  @override
  State<FeedPage> createState() => _FeedPageState();
}

class _FeedPageState extends State<FeedPage> {
  final _scroll = ScrollController();

  @override
  void initState() {
    super.initState();
    final provider = Provider.of<FeedProvider>(context, listen: false);
    provider.loadInitial();

    _scroll.addListener(() {
      if (_scroll.position.pixels > _scroll.position.maxScrollExtent - 300) {
        provider.loadMore();
      }
    });
  }

  @override
  void dispose() {
    _scroll.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final feed = context.watch<FeedProvider>();

    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        title: const Text('Feed', style: TextStyle(fontWeight: FontWeight.bold)),
        backgroundColor: Colors.transparent,
        elevation: 0,
        foregroundColor: Colors.black87,
        actions: [
          // Ícone de chat no topo
          IconButton(
            icon: const Icon(Icons.chat_bubble_outline),
            tooltip: 'Mensagens',
            onPressed: () => Navigator.pushNamed(context, '/chat'),
          ),
        ],
      ),

      // Fundo com gradiente
      body: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            colors: [Color(0xFFE3F2FD), Colors.white],
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
          ),
        ),
        child: RefreshIndicator(
          onRefresh: feed.reload,
          child: ListView.builder(
            controller: _scroll,
            padding: const EdgeInsets.only(top: 80, left: 12, right: 12, bottom: 80),
            itemCount: feed.items.length + (feed.hasMore ? 1 : 0),
            itemBuilder: (context, i) {
              if (i >= feed.items.length) {
                return const Padding(
                  padding: EdgeInsets.all(16),
                  child: Center(child: CircularProgressIndicator()),
                );
              }
              final post = feed.items[i];
              return AnimatedPadding(
                duration: const Duration(milliseconds: 250),
                padding: const EdgeInsets.symmetric(vertical: 6),
                child: PostCard(post: post),
              );
            },
          ),
        ),
      ),

      // Botão de criar post
      floatingActionButton: FloatingActionButton(
        backgroundColor: const Color(0xFF1976D2),
        onPressed: () => Navigator.pushNamed(context, '/createPost'),
        child: const Icon(Icons.edit, color: Colors.white),
      ),
    );
  }
}
