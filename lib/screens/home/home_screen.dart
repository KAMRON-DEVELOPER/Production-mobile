import 'package:flutter/material.dart';
import 'package:iconsax/iconsax.dart';
import '../../widgets/appbar.dart';
import '../../widgets/navbar.dart';
import '../../widgets/tab_button.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xff353b4d),
      appBar: buildAppBar(
        context,
        "Home screen",
        [
          const TabButton(label: 'dashboard', route: '/'),
          const TabButton(label: 'notes', route: '/notes'),
        ],
      ),
      body: const Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text('home body'),
            Icon(
              Iconsax.home_2,
              size: 64,
            ),
          ],
        ),
      ),
      bottomNavigationBar: const Navbar(),
    );
  }
}
