import 'dart:ui';

import 'package:flutter/material.dart';

class CustomTabBar extends StatelessWidget {
  const CustomTabBar({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Positioned(
      top: 8,
      left: 0,
      right: 0,
      child: Container(
        height: 40,
        margin: const EdgeInsets.only(left: 8, right: 8),
        decoration: BoxDecoration(
            border: Border.all(color: Colors.yellow.withOpacity(0.1))),
        child: ClipRRect(
          borderRadius: BorderRadius.circular(6),
          child: BackdropFilter(
            filter: ImageFilter.blur(sigmaY: 2, sigmaX: 2),
            child: Container(
              color: Colors.transparent,
              child: ListView.builder(
                padding: const EdgeInsets.all(4),
                scrollDirection: Axis.horizontal,
                itemCount: 5,
                itemBuilder: (context, index) => GestureDetector(
                  onTap: () => print('INDEX: $index'),
                  child: Container(
                    margin: const EdgeInsets.only(right: 4),
                    alignment: Alignment.center,
                    color: Colors.deepOrangeAccent,
                    padding: const EdgeInsets.fromLTRB(4, 2, 4, 2),
                    child: Text('dashboard $index'),
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
