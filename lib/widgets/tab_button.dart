import 'package:flutter/material.dart';

class TabButton extends StatelessWidget {
  final String label;
  final String route;

  const TabButton({
    super.key,
    required this.label,
    required this.route,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      child: Container(
        margin: const EdgeInsets.only(right: 6, left: 6),
        padding: const EdgeInsets.fromLTRB(10, 4, 10, 4),
        decoration: BoxDecoration(
          color: const Color(0xff6e45fe),
          borderRadius: BorderRadius.circular(20),
        ),
        child: Text(
          label,
          style: const TextStyle(
            color: Colors.white,
          ),
        ),
      ),
      // onTap: () => context.go(route),
      onTap: () => Navigator.pushNamed(context, route),
    );
  }
}
