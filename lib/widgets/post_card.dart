import 'package:flutter/material.dart';
import 'package:cached_network_image/cached_network_image.dart';
import '../models/post.dart';
import 'package:timeago/timeago.dart' as timeago;

class PostCard extends StatelessWidget {
  final Post post;
  const PostCard({super.key, required this.post});

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.symmetric(vertical: 8),
      child: Padding(
        padding: const EdgeInsets.all(12),
        child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
          Row(children: [
            CircleAvatar(radius: 20, backgroundImage: NetworkImage(post.userAvatar)),
            const SizedBox(width: 10),
            Expanded(child: Text(post.username, style: const TextStyle(fontWeight: FontWeight.bold))),
            Text(timeago.format(post.createdAt)),
          ]),
          const SizedBox(height: 10),
          Text(post.content),
          if (post.imageUrl != null) ...[
            const SizedBox(height: 10),
            // cached image placeholder + hero for smooth opening later
            Hero(
              tag: post.id,
              child: CachedNetworkImage(
                imageUrl: post.imageUrl!,
                placeholder: (c, s) => Container(height: 180, color: Colors.grey[200], child: const Center(child: CircularProgressIndicator())),
                errorWidget: (c, s, e) => const SizedBox(height: 180, child: Center(child: Icon(Icons.broken_image))),
                fit: BoxFit.cover,
              ),
            ),
          ],
          const SizedBox(height: 8),
          Row(children: [
            IconButton(onPressed: () {}, icon: const Icon(Icons.favorite_border)),
            Text('${post.likes}'),
            const SizedBox(width: 16),
            IconButton(onPressed: () {}, icon: const Icon(Icons.comment_outlined)),
            Text('${post.comments}'),
            const Spacer(),
            IconButton(onPressed: () {}, icon: const Icon(Icons.more_horiz)),
          ]),
        ]),
      ),
    );
  }
}