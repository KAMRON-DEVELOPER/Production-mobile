import 'package:flutter/material.dart';
import 'package:iconsax/iconsax.dart';

import '../../widgets/appbar.dart';
import '../../widgets/navbar.dart';

class EntertainmentScreen extends StatelessWidget {
  const EntertainmentScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xff353b4d),
      appBar: buildAppBar(context, "Home screen"),
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
