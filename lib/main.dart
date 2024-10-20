import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:instagram_clone/constants/utils/colors.dart';
// import 'package:instagram_clone/view/responsive/mobile_screen_layout.dart';
// import 'package:instagram_clone/view/responsive/responsive_layout_screen.dart';
// import 'package:instagram_clone/view/responsive/web_screen_layout.dart';
// import 'package:instagram_clone/view/screens/login_screen.dart';
import 'package:instagram_clone/view/screens/signup_screen.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  if (kIsWeb) {
    await Firebase.initializeApp(
      options: const FirebaseOptions(
        apiKey: "AIzaSyAkW_6I4vyBI08bN2aH8qggmtikZ-DukHU",
        appId: "1:161986778515:web:c915b40344cabf6ffa8466",
        messagingSenderId: "161986778515",
        projectId: "instagram-clone-e17ad",
        storageBucket: "instagram-clone-e17ad.appspot.com",
      ),
    );
  } else {
    await Firebase.initializeApp();
  }

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Instagram Clone',
      theme: ThemeData.dark().copyWith(
        scaffoldBackgroundColor: mobileBackgroundColor,
      ),
      // home: const ResponsiveLayout(
      //   mobileScreenLayout: MobileScreenLayout(),
      //   webScreenLayout: WebScreenLayout(),
      // ),
      home: const SignupScreen(),
    );
  }
}
