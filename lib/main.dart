import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_native_splash/flutter_native_splash.dart';
import 'package:hive/hive.dart';
import 'package:mobile/bloc/authentication/authentication_bloc.dart';
import 'package:mobile/bloc/connectivity/connectivity_bloc.dart';
import 'package:mobile/bloc/counter/counter_bloc.dart';
import 'package:mobile/bloc/profile/profile_bloc.dart';
import 'package:mobile/cubit/counter_cubit/counter_cubit.dart';
import 'package:mobile/hive/profile_adapter.dart';
import 'package:mobile/hive/tab_adapter.dart';
import 'package:mobile/hive/users_adapter.dart';
import 'package:mobile/models/note.dart';
import 'package:mobile/models/tab.dart';
import 'package:mobile/models/user.dart';
import 'package:mobile/models/users.dart';
import 'package:mobile/provider/change_active_index_provider.dart';
import 'package:mobile/provider/language_provider.dart';
import 'package:mobile/provider/network_provider.dart';
import 'package:mobile/provider/selected_note_provider.dart';
import 'package:mobile/provider/theme_provider.dart';
import 'package:mobile/provider/toggle_settings_provider.dart';
import 'package:mobile/screens/home/verify_screen.dart';
import 'package:page_transition/page_transition.dart';
import 'package:path_provider/path_provider.dart';
import 'package:mobile/screens/screens.dart';
import 'package:provider/provider.dart';
import 'bloc/notes/notes_bloc.dart';
import 'cubit/todo_cubit/todo_cubit.dart';
import 'hive/note_adapter.dart';

void main() async {
  WidgetsBinding widgetsBinding = WidgetsFlutterBinding.ensureInitialized();
  FlutterNativeSplash.preserve(widgetsBinding: widgetsBinding);
  final appDocumentDirectory = await getApplicationDocumentsDirectory();
  Hive.init(appDocumentDirectory.path);
  Hive.registerAdapter(UsersAdapter());
  Hive.registerAdapter(ProfileAdapter());
  Hive.registerAdapter(NoteAdapter());
  Hive.registerAdapter(TabAdapter());
  await Hive.openBox<Users>('usersBox');
  await Hive.openBox<User>('profileBox');
  await Hive.openBox<Note>('NotesBox');
  await Hive.openBox<MyTab>("tabsBox");
  await Hive.openBox('settingsBox');
  FlutterNativeSplash.remove();

  // Enable debugInvertOversizeImages in debug mode only
  assert(() {
    debugInvertOversizedImages = true;
    return true;
  }());

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => ConnectivityBloc(),
      child: MultiProvider(
        providers: [
          ChangeNotifierProvider(create: (_) => ThemeProvider()),
          ChangeNotifierProvider(create: (_) => LanguageProvider()),
          ChangeNotifierProvider(create: (_) => ToggleSettingsProvider()),
          ChangeNotifierProvider(create: (_) => ConnectivityProvider()),
          ChangeNotifierProvider(create: (_) => ActiveIndexProvider()),
          ChangeNotifierProvider(create: (_) => SelectedNoteProvider()),
        ],
        child: Consumer<ThemeProvider>(
          builder: (context, themeProvider, child) {
            return MaterialApp(
              debugShowCheckedModeBanner: false,
              supportedLocales: const [
                Locale('en', 'US'), // English
                Locale('uz', 'UZ'), // Uzbek
                Locale('ru', 'RU'), // Russian
                Locale('tr', 'TR'), // Turkish
              ],
              title: "NQE",
              initialRoute: '/home',
              onGenerateRoute: (settings) {
                switch (settings.name) {
                  case '/home':
                    return PageTransition(
                      child: BlocProvider(
                        create: (context) => ProfileBloc(
                          connectivityBloc: context.read<ConnectivityBloc>(),
                        ),
                        child: const HomeScreen(),
                      ),
                      type: PageTransitionType.fade,
                      duration: const Duration(milliseconds: 300),
                      alignment: Alignment.center,
                      settings: settings,
                    );
                  case '/home/notes':
                    return PageTransition(
                      child: BlocProvider(
                        create: (context) => NotesBloc(
                          connectivityBloc: context.read<ConnectivityBloc>(),
                        ),
                        child: const NotesScreen(),
                      ),
                      type: PageTransitionType.rightToLeft,
                      duration: const Duration(seconds: 1),
                      alignment: Alignment.center,
                      settings: settings,
                    );
                  case '/home/register':
                    return PageTransition(
                      child: BlocProvider(
                        create: (context) => AuthenticationBloc(),
                        child: const RegisterScreen(),
                      ),
                      type: PageTransitionType.fade,
                      duration: const Duration(milliseconds: 300),
                      alignment: Alignment.center,
                      settings: settings,
                    );
                  case '/home/verify':
                    return PageTransition(
                      child: BlocProvider(
                        create: (context) => AuthenticationBloc(),
                        child: const VerifyScreen(),
                      ),
                      type: PageTransitionType.fade,
                      duration: const Duration(milliseconds: 300),
                      alignment: Alignment.center,
                      settings: settings,
                    );
                  case '/home/login':
                    return PageTransition(
                      child: BlocProvider(
                        create: (context) => AuthenticationBloc(),
                        child: const LoginScreen(),
                      ),
                      type: PageTransitionType.fade,
                      duration: const Duration(milliseconds: 300),
                      alignment: Alignment.center,
                      settings: settings,
                    );
                  case '/community':
                    return PageTransition(
                      child: const CommunityScreen(),
                      type: PageTransitionType.fade,
                      duration: const Duration(milliseconds: 300),
                      alignment: Alignment.center,
                      settings: settings,
                    );
                  case '/education':
                    return PageTransition(
                      child: BlocProvider(
                        create: (context) => TodoCubit(),
                        child: const EducationScreen(),
                      ),
                      type: PageTransitionType.fade,
                      duration: const Duration(milliseconds: 300),
                      alignment: Alignment.center,
                      settings: settings,
                    );
                  case '/entertainment':
                    return PageTransition(
                      child: BlocProvider(
                        create: (context) => CounterBloc(),
                        child: const EntertainmentScreen(),
                      ),
                      type: PageTransitionType.fade,
                      duration: const Duration(milliseconds: 300),
                      alignment: Alignment.center,
                      settings: settings,
                    );
                  case '/jobs':
                    return PageTransition(
                      child: BlocProvider(
                        create: (_) => CounterCubit(),
                        child: const JobsScreen(),
                      ),
                      type: PageTransitionType.fade,
                      duration: const Duration(milliseconds: 300),
                      alignment: Alignment.center,
                      settings: settings,
                    );
                  case '/ai':
                    return PageTransition(
                      child: const AiScreen(),
                      type: PageTransitionType.fade,
                      duration: const Duration(milliseconds: 300),
                      alignment: Alignment.center,
                      settings: settings,
                    );
                  default:
                    return null;
                }
              },
            );
          },
        ),
      ),
    );
  }
}
