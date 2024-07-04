import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:iconsax/iconsax.dart';

import '../../widgets/appbar.dart';
import '../../widgets/navbar.dart';

class EntertainmentScreen extends StatelessWidget {
  const EntertainmentScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: buildAppBar(
        context,
        "Home screen",
        [
          ElevatedButton(
            onPressed: () => context.go('/'),
            child: const Text('dashboard'),
          ),
          ElevatedButton(
            onPressed: () => context.go('/notes'),
            child: const Text('notes'),
          ),
        ],
      ),
      body: const Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text('entertainment body'),
            Icon(
              Iconsax.video_play,
              size: 64,
            ),
          ],
        ),
      ),
      bottomNavigationBar: const Navbar(),
    );
  }
}
