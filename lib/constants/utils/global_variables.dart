import 'package:flutter/material.dart';
import 'package:instagram_clone/view/screens/add_post_screen.dart';
import 'package:instagram_clone/view/screens/feed_screen.dart';

const webScreenSize = 600;

const homeScreenItems = [
  FeedScreen(),
  Text('Search'),
  AddPostScreen(),
  Text('Notification'),
  Text('Profile'),
];
