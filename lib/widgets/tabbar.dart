import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:mobile/hive/profile_model.dart';
import 'package:provider/provider.dart';
import '../provider/theme_provider.dart';

class CustomTabBar extends StatefulWidget {
  const CustomTabBar({super.key});

  @override
  State<CustomTabBar> createState() => _CustomTabBarState();
}

class _CustomTabBarState extends State<CustomTabBar> {
  final profileBox = Hive.box<ProfileModel>('profileBox');
  List<Map<String, String>> defaultTabs = [
    {"name": "dashboard", "route": "/home"},
    {"name": "notes", "route": "/home/notes"},
  ];
  List<Map<String, String>>? userTabs;

  @override
  void initState() {
    super.initState();
    userTabs = profileBox.get("profileData")?.tabs?.map((userTab) {
      return {
        "name": userTab["category_name"] ?? "",
        "route": "home/${userTab["category_name"]?.toLowerCase() ?? ""}",
      };
    }).cast<Map<String, String>>().toList();
    print('userTabs >> $userTabs');
    userTabs?.map((userTab) => defaultTabs.add(userTab));
    if (userTabs != null) {
      defaultTabs.addAll(userTabs!);
    }
    defaultTabs.add({"name": "    +    ", "route": "/home/create-tab"});
    print('1) defaultTabs >> $defaultTabs');
  }

  @override
  Widget build(BuildContext context) {
    final theme = Provider.of<ThemeProvider>(context).currentTheme;
    // List<Map<String, String>> allTabs = [...defaultTabs, ...?userTabs, {"name": "    +    ", "route": "/home/create-tab"}];
    print('2) defaultTabs >> $defaultTabs');
    return Positioned(
      top: 0,
      left: 0,
      right: 0,
      child: Container(
        height: 40,
        decoration: BoxDecoration(
          color: theme.background1,
          border: const Border(
            top: BorderSide(color: Colors.green, width: 0.1),
          ),
        ),
        child: ListView.separated(
          padding: const EdgeInsets.all(4),
          scrollDirection: Axis.horizontal,
          separatorBuilder: (context, index) => const SizedBox(width: 4),
          itemCount: defaultTabs.length,
          itemBuilder: (context, index) => GestureDetector(
            onTap: () => Navigator.pushNamed(context, defaultTabs[index]["route"]!),
            child: Container(
              alignment: Alignment.center,
              padding: const EdgeInsets.fromLTRB(16, 2, 16, 2),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(6),
                color: index != 0 ? theme.background3 : theme.activeTabColor,
              ),
              child: Text(
                defaultTabs[index]["name"]!,
                style: TextStyle(
                  color: theme.text1,
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
