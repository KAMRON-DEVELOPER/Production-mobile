import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:iconsax/iconsax.dart';

class Navbar extends StatefulWidget {
  const Navbar({super.key});

  @override
  State<Navbar> createState() => _NavbarState();
}

class _NavbarState extends State<Navbar> {
  int _selectedIndex = 0;

  void _onTap(int index) {
    switch (index) {
      case 0:
        context.go('/');
        break;
      case 1:
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
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return BottomAppBar(
      height: 64,
      color: Colors.grey[800],
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
                  ? Colors.yellow[900]
                  : Colors.grey[900],
            ),
            AnimatedPositioned(
              duration: const Duration(milliseconds: 300),
              bottom: selectedIndex == itemIndex ? 0 : -10,
              child: Container(
                height: selectedIndex == itemIndex ? 4 : 0,
                width: selectedIndex == itemIndex ? 4 : 0,
                decoration: BoxDecoration(
                  color: Colors.yellow[900],
                  shape: BoxShape.circle,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
