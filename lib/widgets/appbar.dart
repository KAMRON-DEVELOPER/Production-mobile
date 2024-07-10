import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../provider/theme_provider.dart';

AppBar buildAppBar(
    BuildContext context, String title, List<StatelessWidget> tabs) {
  final themeProvider = Provider.of<ThemeProvider>(context);
  final theme = themeProvider.currentTheme;

  return AppBar(
    title: Text(
      title,
      style: const TextStyle(color: Color(0xff6e45fe)),
    ),
    backgroundColor: theme.appBarTheme.backgroundColor,
    actions: const [],
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
      ),
    ),
  );
}
