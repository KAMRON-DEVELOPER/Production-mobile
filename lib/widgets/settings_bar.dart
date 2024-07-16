import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:provider/provider.dart';
import '../provider/theme_provider.dart';

class SettingsBar extends StatelessWidget {
  final String currentTheme =
      Hive.box('settingsBox').get('theme', defaultValue: 'dark');
  final String currentLanguage =
      Hive.box('settingsBox').get('language', defaultValue: "o'zbekcha");
  SettingsBar({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Provider.of<ThemeProvider>(context).currentTheme;
    final themeProvider = Provider.of<ThemeProvider>(context);
    const double itemWidth = 64;
    final List<Map<String, dynamic>> themes = [
      {"color": Colors.white, "name": 'light'},
      {"color": Colors.black, "name": 'dark'},
      {"color": Colors.indigo, "name": 'black'},
      {"color": Colors.purple, "name": 'purple'},
    ];
    final List<Map<String, dynamic>> languages = [
      {"icon": Colors.white, "name": "o'zbekcha"},
      {"icon": Colors.black, "name": 'english'},
      {"icon": Colors.indigo, "name": 'russian'},
      {"icon": Colors.purple, "name": 'turkish'},
    ];

    return Positioned(
      bottom: 12,
      left: 12,
      right: 12,
      child: BackdropFilter(
        filter: ImageFilter.blur(sigmaX: 3, sigmaY: 3),
        child: Container(
          padding: const EdgeInsets.all(12),
          decoration: BoxDecoration(
            color: theme.background1,
            borderRadius: BorderRadius.circular(12.0),
            boxShadow: const [
              BoxShadow(
                color: Colors.black26,
                blurRadius: 10.0,
              ),
            ],
          ),
          child: Column(
            children: [
              //! Theme
              Container(
                padding: const EdgeInsets.only(left: 16, right: 16),
                decoration: BoxDecoration(
                  color: theme.background2,
                  borderRadius: BorderRadius.circular(12.0),
                ),
                child: Column(
                  children: [
                    const Text(
                      'Themes',
                      style:
                          TextStyle(fontSize: 20.0, color: Colors.blueAccent),
                    ),
                    const SizedBox(height: 8),
                    SizedBox(
                      height: 84,
                      child: LayoutBuilder(builder: (context, constraints) {
                        final separatorWidth = (constraints.maxWidth -
                                (itemWidth * themes.length)) /
                            (themes.length - 1);
                        return ListView.separated(
                          scrollDirection: Axis.horizontal,
                          itemCount: themes.length,
                          separatorBuilder: (context, index) =>
                              SizedBox(width: separatorWidth),
                          itemBuilder: (context, index) {
                            return Column(
                              children: [
                                GestureDetector(
                                  onTap: () => themeProvider
                                      .switchTheme(themes[index]['name']),
                                  child: Container(
                                    width: itemWidth,
                                    height: itemWidth,
                                    decoration: BoxDecoration(
                                      color: themes[index]['color'],
                                      shape: BoxShape.circle,
                                      border: Border.all(
                                        color: currentTheme ==
                                                themes[index]['name']
                                            ? Colors.blueAccent
                                            : Colors.transparent,
                                        width: 2.0,
                                      ),
                                    ),
                                  ),
                                ),
                                Text(themes[index]['name']),
                              ],
                            );
                          },
                        );
                      }),
                    ),
                  ],
                ),
              ),

              const SizedBox(height: 16),

              //! Languages
              Container(
                padding: const EdgeInsets.only(left: 16, right: 16),
                decoration: BoxDecoration(
                  color: theme.background2,
                  borderRadius: BorderRadius.circular(12.0),
                ),
                child: Column(
                  children: [
                    const Text(
                      'Languages',
                      style:
                          TextStyle(fontSize: 20.0, color: Colors.blueAccent),
                    ),
                    const SizedBox(height: 8),
                    SizedBox(
                      height: 84,
                      child: LayoutBuilder(builder: (context, constraints) {
                        final separatorWidth = (constraints.maxWidth -
                                (itemWidth * themes.length)) /
                            (themes.length - 1);
                        return ListView.separated(
                          scrollDirection: Axis.horizontal,
                          itemCount: themes.length,
                          separatorBuilder: (context, index) =>
                              SizedBox(width: separatorWidth),
                          itemBuilder: (context, index) {
                            return Column(
                              children: [
                                GestureDetector(
                                  onTap: () => print(languages[index]['name']),
                                  child: Container(
                                    width: itemWidth,
                                    height: itemWidth,
                                    decoration: BoxDecoration(
                                      color: languages[index]['icon'],
                                      shape: BoxShape.circle,
                                      border: Border.all(
                                        color: currentTheme ==
                                                themes[index]['name']
                                            ? Colors.blueAccent
                                            : Colors.transparent,
                                        width: 2.0,
                                      ),
                                    ),
                                  ),
                                ),
                                Text(languages[index]['name']),
                              ],
                            );
                          },
                        );
                      }),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
