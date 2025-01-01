import 'package:flutter/material.dart';
import 'package:instagram_clone/view/widgets/post_card.dart';

class PostScreen extends StatelessWidget {
  final dynamic snap;

  const PostScreen({
    super.key,
    required this.snap,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Post"),
        backgroundColor: Colors.black,
      ),
      body: PostCard(
        snap: snap,
      ),
    );
  }
}
