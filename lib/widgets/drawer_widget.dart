import 'package:flutter/material.dart';
import 'package:mobile/widgets/settings_bar.dart';
import 'package:mobile/widgets/tabbar.dart';
import 'package:provider/provider.dart';
import '../provider/theme_provider.dart';
import '../provider/toggle_settings_provider.dart';
import 'appbar.dart';
import 'navbar.dart';

Widget buildDrawerWidget({
  required BuildContext context,
  required String appBarTitle,
  required Widget content,
}) {
  final theme = Provider.of<ThemeProvider>(context).currentTheme;
  final isOpenSettings = context.watch<ToggleSettingsProvider>().isOpen;

  return Scaffold(
    backgroundColor: theme.background2,
    appBar: buildAppBar(context, appBarTitle),
    body: Stack(
      clipBehavior: Clip.none,
      children: [
        Positioned.fill(child: content),
        const CustomTabBar(),
        if (isOpenSettings) (SettingsBar()),
      ],
    ),
    bottomNavigationBar: const Navbar(),
  );
}
