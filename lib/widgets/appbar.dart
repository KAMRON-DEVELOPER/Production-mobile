import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

AppBar buildAppBar(BuildContext context, String title, List<ElevatedButton> elevatedButtons) {

  return AppBar(
    title: Text(title),
    backgroundColor: Colors.grey[800],
    actions: [
      IconButton(
        icon: const Icon(
          Icons.login,
          color: Colors.black,
        ),
        onPressed: () => context.go('/login'),
      ),
      IconButton(
        icon: const Icon(
          Icons.add_circle_outline_sharp,
          color: Colors.black,
        ),
        onPressed: () => context.go('/register'),
      ),
    ],
    bottom: PreferredSize(
      preferredSize: const Size.fromHeight(36.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        children: elevatedButtons,
      )
    ),
  );
}

