import 'package:flutter/material.dart';
import 'package:mobile/screens/screens.dart';

final Map<String, Widget Function(BuildContext)> namedRoutes = {
  '/home': (context) => const HomeScreen(),
  '/home/notes': (context) => const NotesScreen(),
  '/home/register': (context) => const RegisterScreen(),
  '/home/login': (context) => const LoginScreen(),
  '/community': (context) => const CommunityScreen(),
  '/education': (context) => const EducationScreen(),
  '/entertainment': (context) => const EntertainmentScreen(),
  '/jobs': (context) => const JobsScreen(),
  '/ai': (context) => const AiScreen(),
};

