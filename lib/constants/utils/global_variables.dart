import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:instagram_clone/view/screens/add_post_screen.dart';
import 'package:instagram_clone/view/screens/feed_screen.dart';
import 'package:instagram_clone/view/screens/profile_screen.dart';
import 'package:instagram_clone/view/screens/search_screen.dart';

const webScreenSize = 600;

List<Widget> homeScreenItems = [
  const FeedScreen(),
  const SearchScreen(),
  const AddPostScreen(),
  const Text('Notification'),
  ProfileScreen(
    uid: FirebaseAuth.instance.currentUser!.uid,
  ),
];
