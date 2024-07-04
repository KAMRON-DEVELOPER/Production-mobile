import 'package:flutter/material.dart';
import 'package:iconsax/iconsax.dart';

import '../../widgets/appbar.dart';
import '../../widgets/navbar.dart';
import '../../widgets/tab_button.dart';

class AiScreen extends StatelessWidget {
  const AiScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xff353b4d),
      appBar: buildAppBar(
        context,
        "Home screen",
        [
          const TabButton(label: 'ai', route: '/ai'),
          const TabButton(label: 'ai chat', route: '/ai-chat'),
        ],
      ),
      body: const Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text('AI body'),
            Icon(
              Iconsax.cpu,
              size: 64,
            ),
          ],
        ),
      ),
      bottomNavigationBar: const Navbar(),
    );
  }
}
