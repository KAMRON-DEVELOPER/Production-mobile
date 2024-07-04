import 'package:flutter/material.dart';
import 'package:iconsax/iconsax.dart';

import '../../widgets/appbar.dart';
import '../../widgets/navbar.dart';
import '../../widgets/tab_button.dart';

class JobsScreen extends StatelessWidget {
  const JobsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xff353b4d),
      appBar: buildAppBar(
        context,
        "Home screen",
        [
          const TabButton(label: 'jobs', route: '/jobs'),
          const TabButton(label: 'my jobs', route: '/my-jobs'),
          const TabButton(label: 'hire job', route: '/hire-job'),
        ],
      ),
      body: const Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text('jobs body'),
            Icon(
              Iconsax.brifecase_cross,
              size: 64,
            ),
          ],
        ),
      ),
      bottomNavigationBar: const Navbar(),
    );
  }
}
