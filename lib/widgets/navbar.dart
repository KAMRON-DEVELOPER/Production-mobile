import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:hive/hive.dart';
import 'package:iconsax/iconsax.dart';

class Navbar extends StatefulWidget {
  const Navbar({super.key});

  @override
  State<Navbar> createState() => _NavbarState();
}

class _NavbarState extends State<Navbar> {
  final _selectedIndex = Hive.box('settingsBox').get('navbarIndex') ?? 0;

  void _onTap(int index) {
    try {
      print('tried to change index');
      Hive.box('settingsBox').put('navbarIndex', index);
      print('changes done');
    } catch (error) {
      print('error: $error');
    }
    setState(() {
      print('_selectedIndex = $index;');
    });
    switch (index) {
      case 0:
        print('go home');
        context.go('/');
        break;
      case 1:
        print('go community');
        context.go('/community');
        break;
      case 2:
        context.go('/education');
        break;
      case 3:
        context.go('/entertainment');
        break;
      case 4:
        context.go('/jobs');
        break;
      case 5:
        context.go('/ai');
        break;
    }
  }

  @override
  Widget build(BuildContext context) {
    print('building.......');
    return BottomAppBar(
      height: 64,
      color: const Color(0xff181a20),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          _buildNavbarItem(Iconsax.home_2, 0, _selectedIndex, _onTap),
          _buildNavbarItem(Iconsax.message, 1, _selectedIndex, _onTap),
          _buildNavbarItem(Iconsax.book_saved, 2, _selectedIndex, _onTap),
          _buildNavbarItem(Iconsax.video_play, 3, _selectedIndex, _onTap),
          _buildNavbarItem(Iconsax.brifecase_cross, 4, _selectedIndex, _onTap),
          _buildNavbarItem(Iconsax.cpu, 5, _selectedIndex, _onTap),
        ],
      ),
    );
  }

  Widget _buildNavbarItem(
    IconData icon,
    int itemIndex,
    int selectedIndex,
    Function(int) onTap,
  ) {
    return GestureDetector(
      onTap: () => onTap(itemIndex),
      child: SizedBox(
        height: 64,
        child: Stack(
          alignment: Alignment.center,
          children: [
            Icon(
              icon,
              size: 28,
              color: selectedIndex == itemIndex
                  ? const Color(0xff6e45fe)
                  : const Color(0xffE3F2FD),
            ),
          ],
        ),
      ),
    );
  }
}
