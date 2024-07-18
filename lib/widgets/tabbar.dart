import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../provider/theme_provider.dart';

class CustomTabBar extends StatelessWidget {
  const CustomTabBar({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Provider.of<ThemeProvider>(context).currentTheme;

    return Positioned(
      top: 0,
      left: 0,
      right: 0,
      child: Container(
        height: 40,
        decoration: BoxDecoration(
          color: theme.background1,
          border: const Border(
            top: BorderSide(color: Colors.green, width: 0.1),
          ),
        ),
        child: ListView.separated(
          padding: const EdgeInsets.all(4),
          scrollDirection: Axis.horizontal,
          separatorBuilder: (context, index) => const SizedBox(width: 4),
          itemCount: 5,
          itemBuilder: (context, index) => GestureDetector(
            onTap: () => print('INDEX: $index'),
            child: Container(
              alignment: Alignment.center,
              padding: const EdgeInsets.fromLTRB(4, 2, 4, 2),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(6),
                color: index != 0 ? theme.background3 : theme.activeTabColor,
              ),
              child: Text(
                'dashboard $index',
                style: TextStyle(
                  color: theme.text1,
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
