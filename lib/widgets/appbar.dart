import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

AppBar buildAppBar(
    BuildContext context, String title, List<StatelessWidget> tabs) {
  return AppBar(
      title: Text(
        title,
        style: const TextStyle(color: Color(0xff6e45fe)),
      ),
      backgroundColor: const Color(0xff181a20),
      actions: [
        IconButton(
          icon: const Icon(
            Icons.login,
            color: Colors.white,
          ),
          onPressed: () => context.go('/login'),
        ),
        IconButton(
          icon: const Icon(
            Icons.add_circle_outline_sharp,
            color: Colors.white,
          ),
          onPressed: () => context.go('/register'),
        ),
      ],
      bottom: PreferredSize(
          preferredSize: const Size.fromHeight(36),
          child: Container(
            width: MediaQuery.of(context).size.width,
            // color: Colors.white10,
            padding: const EdgeInsets.only(bottom: 8, top: 8),
            child: SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: tabs,
              ),
            ),
          )));
}
