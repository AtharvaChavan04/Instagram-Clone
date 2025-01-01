import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:instagram_clone/constants/utils/colors.dart';
import 'package:instagram_clone/view/screens/profile_screen.dart';

class FollowersScreen extends StatelessWidget {
  final List followers; 

  const FollowersScreen({
    super.key,
    required this.followers,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Followers"),
        backgroundColor: mobileBackgroundColor,
      ),
      body: followers.isEmpty
          ? const Center(
              child: Text(
                "No followers yet.",
                style: TextStyle(color: Colors.white),
              ),
            )
          : ListView.builder(
              itemCount: followers.length,
              itemBuilder: (context, index) {
                return FutureBuilder(
                  future: FirebaseFirestore.instance
                      .collection('users')
                      .doc(followers[index])
                      .get(),
                  builder: (context, snapshot) {
                    if (!snapshot.hasData) {
                      return const Center(
                        child: CircularProgressIndicator(),
                      );
                    }
                    var userSnap = snapshot.data as DocumentSnapshot;
                    return ListTile(
                      leading: CircleAvatar(
                        backgroundImage: NetworkImage(userSnap['photoUrl']),
                      ),
                      title: Text(
                        userSnap['username'],
                        style: const TextStyle(color: Colors.white),
                      ),
                      onTap: () {
                        Navigator.of(context).push(
                          MaterialPageRoute(
                            builder: (context) => ProfileScreen(
                              uid: userSnap['uid'],
                            ),
                          ),
                        );
                      },
                    );
                  },
                );
              },
            ),
    );
  }
}
