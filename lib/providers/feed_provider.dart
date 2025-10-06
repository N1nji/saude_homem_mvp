import 'package:flutter/material.dart';
import '../models/post.dart';

class FeedProvider extends ChangeNotifier {
  final List<Post> _items = [];
  bool _loading = false;
  bool _hasMore = true;

  List<Post> get items => _items;
  bool get hasMore => _hasMore;
  bool get loading => _loading;

  Future<void> loadInitial() async {
    if (_items.isNotEmpty) return;
    await Future.delayed(const Duration(milliseconds: 500));
    _items.addAll(_mockPosts.take(5));
    notifyListeners();
  }

  Future<void> reload() async {
    _items.clear();
    _hasMore = true;
    await loadInitial();
  }

  Future<void> loadMore() async {
    if (_loading || !_hasMore) return;
    _loading = true;
    notifyListeners();

    await Future.delayed(const Duration(seconds: 1));
    final next = _mockPosts.skip(_items.length).take(5).toList();
    if (next.isEmpty) {
      _hasMore = false;
    } else {
      _items.addAll(next);
    }
    _loading = false;
    notifyListeners();
  }
}

// POSTS MOCKADOS
final _mockPosts = List.generate(
  15,
  (i) => Post(
    id: 'p$i',
    username: 'Usuário $i',
    userAvatar: 'https://i.pravatar.cc/150?img=${i + 10}',
    content: 'Este é o post número $i sobre saúde do homem 💪',
    imageUrl: (i % 3 == 0) ? 'https://picsum.photos/seed/$i/400/200' : null,
    createdAt: DateTime.now().subtract(Duration(minutes: i * 5)),
    likes: i * 2,
    comments: i,
  ),
);
