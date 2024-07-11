import 'dart:ui';
import 'package:flutter/material.dart';

class SettingsBar extends StatelessWidget {
  const SettingsBar({super.key});

  @override
  Widget build(BuildContext context) {
    return Positioned(
      bottom: 0,
      left: 0,
      right: 0,
      child: BackdropFilter(
        filter: ImageFilter.blur(sigmaX: 3, sigmaY: 4),
        child: Container(
          margin: const EdgeInsets.all(8.0),
          padding: const EdgeInsets.all(16.0),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(12.0),
            boxShadow: const [
              BoxShadow(
                color: Colors.black26,
                blurRadius: 10.0,
              ),
            ],
          ),
          child: const Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text('Settings Menu', style: TextStyle(fontSize: 20.0)),
              // Add your menu items here
            ],
          ),
        ),
      ),
    );
  }
}
