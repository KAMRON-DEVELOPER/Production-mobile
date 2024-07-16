import 'package:flutter/material.dart';
import 'package:mobile/widgets/settings_bar.dart';
import 'package:mobile/widgets/tabbar.dart';
import 'package:provider/provider.dart';
import '../provider/theme_provider.dart';
import '../provider/toggle_settings_provider.dart';
import 'appbar.dart';
import 'navbar.dart';

/*
class DrawerWidget extends StatelessWidget {
  final String appBarTitle;
  final Widget content;
  const DrawerWidget({super.key, required this.appBarTitle, required this.content});

  @override
  Widget build(BuildContext context) {
    final theme = Provider.of<ThemeProvider>(context).currentTheme;
    final isOpenSettings = context.watch<ToggleSettingsProvider>().isOpen;

    return Scaffold(
      backgroundColor: theme.canvasColor,
      appBar: buildAppBar(context, appBarTitle),
      body: Stack(
        children: [
          //! Main body content
          Container(
            constraints: const BoxConstraints.expand(), // Ensure content takes up full screen space
            child: content,
          ),

          //! Custom tabs positioned 10 pixels below the AppBar
          Positioned(
            top: 8,
            left: 0,
            right: 0,
            child: Container(
              color: Colors.blueAccent,
              margin: const EdgeInsets.only(left: 8, right: 8),
              padding: const EdgeInsets.all(8.0),
              child: const SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                child: Row(
                  children: [
                    SizedBox(width: 10),
                    Text('this is tab1'),
                    SizedBox(width: 20),
                    Text('this is tab2'),
                    SizedBox(width: 20),
                    Text('this is tab3'),
                    SizedBox(width: 20),
                    Text('this is tab4'),
                    SizedBox(width: 20),
                    Text('this is tab5'),
                    SizedBox(width: 20),
                    Text('this is tab6'),
                    SizedBox(width: 10),
                  ],
                ),
              ),
            ),
          ),

          //! Settings menu bar positioned 10 pixels above the bottom navigation bar
          if (isOpenSettings)
            Positioned(
              bottom: 0,
              left: 0,
              right: 0,
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
        ],
      ),
      bottomNavigationBar: const Navbar(),
    );
  }
}
*/

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
      children: [
        Positioned.fill(child: content),
        const CustomTabBar(),
        if (isOpenSettings) (SettingsBar()),
      ],
    ),
    bottomNavigationBar: const Navbar(),
  );
}
