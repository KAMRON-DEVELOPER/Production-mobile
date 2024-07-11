import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../provider/theme_provider.dart';

enum Options { search, upload, copy, exit }

AppBar buildAppBar(BuildContext context, String title) {
  final theme = Provider.of<ThemeProvider>(context).currentTheme;

  return AppBar(
    backgroundColor: theme.appBarTheme.backgroundColor,
    toolbarHeight: 64,
    centerTitle: true,
    title: Text(
      title,
      style: const TextStyle(color: Color(0xff6e45fe)),
    ),
  );
}
