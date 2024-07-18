import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../provider/theme_provider.dart';

enum Options { search, upload, copy, exit }

AppBar buildAppBar(BuildContext context, String title) {
  final theme = Provider.of<ThemeProvider>(context).currentTheme;

  return AppBar(
    backgroundColor: theme.background1,
    toolbarHeight: 64,
    centerTitle: true,
    title: Text(
      title,
      style: TextStyle(color: theme.activeTabColor),
    ),
  );
}
