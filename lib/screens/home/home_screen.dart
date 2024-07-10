import 'package:flutter/material.dart';
import 'package:iconsax/iconsax.dart';
import 'package:provider/provider.dart';
import '../../provider/theme_provider.dart';
import '../../widgets/appbar.dart';
import '../../widgets/navbar.dart';
import '../../widgets/tab_button.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final themeProvider = Provider.of<ThemeProvider>(context);
    final theme = themeProvider.currentTheme;

    return Scaffold(
      backgroundColor: theme.canvasColor,
      appBar: buildAppBar(
        context,
        "Home screen",
        [
          const TabButton(label: 'dashboard', route: '/home'),
          const TabButton(label: 'notes', route: '/home/notes'),
        ],
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            ElevatedButton(
              onPressed: () => Navigator.pushNamed(context, '/home/login'),
              child: const Icon(Iconsax.login_1, size: 64),
            ),
            const SizedBox(height: 32),
            ElevatedButton(
              onPressed: () => Navigator.pushNamed(context, '/home/register'),
              child: const Icon(Iconsax.add_square, size: 64),
            ),
            const SizedBox(height: 32),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                ElevatedButton(
                  onPressed: () => themeProvider.switchTheme('light'),
                  child: const Text(
                    'light',
                    style: TextStyle(
                      backgroundColor: Colors.white70,
                      color: Colors.black,
                    ),
                  ),
                ),
                const SizedBox(width: 20),
                ElevatedButton(
                  onPressed: () => themeProvider.switchTheme('dark'),
                  child: const Text(
                    'dark',
                    style: TextStyle(
                      backgroundColor: Colors.indigo,
                      color: Colors.white,
                    ),
                  ),
                ),
                const SizedBox(width: 20),
                ElevatedButton(
                  onPressed: () => themeProvider.switchTheme('black'),
                  child: const Text(
                    'black',
                    style: TextStyle(
                      backgroundColor: Colors.black,
                      color: Colors.white70,
                    ),
                  ),
                ),
                ElevatedButton(
                  onPressed: () => themeProvider.switchTheme('purple'),
                  child: const Text(
                    'purple',
                    style: TextStyle(
                      backgroundColor: Colors.purple,
                      color: Colors.black,
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
      bottomNavigationBar: const Navbar(),
    );
  }
}
