import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:google_fonts/google_fonts.dart';

import 'pages/terms_page.dart';
import 'pages/tutorial_page.dart';
import 'pages/video_page.dart';
import 'pages/splashscreen.dart';
import 'pages/login.dart';
import 'pages/register.dart';
import 'pages/home.dart';
import 'pages/feed.dart';
import 'pages/chat.dart';
import 'pages/create_post.dart';
import 'providers/auth_provider.dart';
import 'providers/feed_provider.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => AuthProvider()),
        ChangeNotifierProvider(create: (_) => FeedProvider()),
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Espaço Seguro',
        theme: ThemeData(
          useMaterial3: true,
          primarySwatch: Colors.indigo,
          textTheme: GoogleFonts.interTextTheme(),
          visualDensity: VisualDensity.adaptivePlatformDensity,
        ),
        initialRoute: '/splashscreen',
        routes: {
          '/terms': (context) => const TermsPage(),
          '/tutorial_page': (_) => const TutorialPage(),
          '/video': (_) => const VideoPage(),
          '/splashscreen': (_) => const SplashPage(),
          '/login': (_) => const LoginPage(),
          '/register': (_) => const RegisterPage(),
          '/home': (_) => const HomePage(),
          '/feed': (_) => const FeedPage(),
          '/chat': (_) => const ChatPage(),
          '/createPost': (_) => const CreatePostPage(),
        },
      ),
    );
  }
}


