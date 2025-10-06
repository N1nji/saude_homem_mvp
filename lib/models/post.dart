class Post {
  final String id;
  final String username;
  final String userAvatar;
  final String content;
  final String? imageUrl;
  final DateTime createdAt;
  final int likes;
  final int comments;

  Post({
    required this.id,
    required this.username,
    required this.userAvatar,
    required this.content,
    this.imageUrl,
    required this.createdAt,
    this.likes = 0,
    this.comments = 0,
  });
}