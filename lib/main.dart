import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:mobile/hive/users_adapter.dart';
import 'package:mobile/hive/users_model.dart';
import 'package:mobile/widgets/routes.dart';
import 'package:path_provider/path_provider.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  final appDocumentDirectory = await getApplicationDocumentsDirectory();
  Hive.init(appDocumentDirectory.path);
  Hive.registerAdapter(UsersAdapter());
  await Hive.openBox<UsersModel>('usersBox');
  await Hive.openBox('settingsBox');
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      debugShowCheckedModeBanner: false,
      title: "NQE",
      routerConfig: routes,
    );
  }
}
