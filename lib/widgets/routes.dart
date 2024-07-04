import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:mobile/bloc/authentication/authentication_bloc.dart';
import 'package:mobile/screens/screens.dart';
import 'package:page_transition/page_transition.dart';

// ignore: unused_element
final GoRouter routes = GoRouter(
  initialLocation: '/',
  routes: <RouteBase>[
    GoRoute(
      path: '/',
      pageBuilder: (BuildContext context, GoRouterState state) {
        return buildCustomTransition(
          screen: const HomeScreen(),
          transitionDuration: 300,
          transitionType: PageTransitionType.leftToRight,
          duration: 100,
        );
      },
      routes: <RouteBase>[
        GoRoute(
          path: 'register',
          pageBuilder: (BuildContext context, GoRouterState state) {
            return buildCustomTransition(
              screen: MultiBlocProvider(
                providers: [
                  BlocProvider(
                    create: (context) => AuthenticationBloc(),
                  ),
                ],
                child: const RegisterScreen(),
              ),
              transitionDuration: 300,
              duration: 100,
              transitionType: PageTransitionType.rightToLeft,
            );
          },
        ),
        GoRoute(
          path: 'login',
          pageBuilder: (BuildContext context, GoRouterState state) {
            return buildCustomTransition(
              screen: MultiBlocProvider(
                providers: [
                  BlocProvider(
                    create: (context) => AuthenticationBloc(),
                  ),
                ],
                child: const LoginScreen(),
              ),
              transitionDuration: 300,
              duration: 100,
              transitionType: PageTransitionType.rightToLeft,
            );
          },
        ), //! login
        GoRoute(
          path: 'notes',
          pageBuilder: (BuildContext context, GoRouterState state) {
            return buildCustomTransition(
              screen: const NotesScreen(),
              transitionDuration: 300,
              duration: 100,
              transitionType: PageTransitionType.rightToLeft,
            );
          },
        ), //! notes
      ],
    ),
    GoRoute(
        path: '/community',
        pageBuilder: (BuildContext context, GoRouterState state) {
          return buildCustomTransition(
            screen: const CommunityScreen(),
            transitionDuration: 300,
            transitionType: PageTransitionType.bottomToTop,
            duration: 100,
          );
        },
        routes: [
          GoRoute(
            path: 'news',
            pageBuilder: (BuildContext context, GoRouterState state) {
              return buildCustomTransition(
                  screen: const NewsScreen(),
                  transitionDuration: 300,
                  duration: 100,
                  transitionType: PageTransitionType.bottomToTop);
            },
          ),
          GoRoute(
            path: 'news-detail',
            pageBuilder: (BuildContext context, GoRouterState state) {
              return buildCustomTransition(
                screen: const NewsDetailScreen(),
                transitionDuration: 300,
                duration: 100,
                transitionType: PageTransitionType.bottomToTop,
              );
            },
          ),
          GoRoute(
            path: 'groups',
            pageBuilder: (BuildContext context, GoRouterState state) {
              return buildCustomTransition(
                  screen: const GroupsScreen(),
                  transitionDuration: 300,
                  duration: 100,
                  transitionType: PageTransitionType.bottomToTop);
            },
          ),
          GoRoute(
            path: 'group',
            pageBuilder: (BuildContext context, GoRouterState state) {
              return buildCustomTransition(
                  screen: const GroupScreen(),
                  transitionDuration: 300,
                  duration: 100,
                  transitionType: PageTransitionType.bottomToTop);
            },
          ),
          GoRoute(
            path: 'chats',
            pageBuilder: (BuildContext context, GoRouterState state) {
              return buildCustomTransition(
                  screen: const ChatsScreen(),
                  transitionDuration: 300,
                  duration: 100,
                  transitionType: PageTransitionType.bottomToTop);
            },
          ),
          GoRoute(
            path: 'chat',
            pageBuilder: (BuildContext context, GoRouterState state) {
              return buildCustomTransition(
                  screen: const ChatScreen(),
                  transitionDuration: 300,
                  duration: 100,
                  transitionType: PageTransitionType.bottomToTop);
            },
          ),
          GoRoute(
            path: 'my-profile',
            pageBuilder: (BuildContext context, GoRouterState state) {
              return buildCustomTransition(
                  screen: const MyProfileScreen(),
                  transitionDuration: 300,
                  duration: 100,
                  transitionType: PageTransitionType.bottomToTop);
            },
          ),
          GoRoute(
            path: 'profile',
            pageBuilder: (BuildContext context, GoRouterState state) {
              return buildCustomTransition(
                  screen: const ProfileScreen(),
                  transitionDuration: 300,
                  duration: 100,
                  transitionType: PageTransitionType.bottomToTop);
            },
          ),
        ]),
    GoRoute(
        path: '/education',
        builder: (BuildContext context, GoRouterState state) {
          return const EducationScreen();
        },
        routes: [
          GoRoute(
            path: 'courses',
            builder: (BuildContext context, GoRouterState state) {
              return const CoursesScreen();
            },
          ), //! courses screen
          GoRoute(
            path: 'course',
            builder: (BuildContext context, GoRouterState state) {
              return const CourseScreen();
            },
          ), //! course screen
          GoRoute(
            path: 'create-course',
            builder: (BuildContext context, GoRouterState state) {
              return const CreateCourseScreen();
            },
          ), //! create course screen
          GoRoute(
            path: 'books',
            builder: (BuildContext context, GoRouterState state) {
              return const BooksScreen();
            },
          ), //! books screen
          GoRoute(
            path: 'books',
            builder: (BuildContext context, GoRouterState state) {
              return const BookScreen();
            },
          ), //! book screen
          GoRoute(
            path: 'my-courses',
            builder: (BuildContext context, GoRouterState state) {
              return const MyCoursesScreen();
            },
          ), //! my courses screen
        ]), //! education
    GoRoute(
      path: '/entertainment',
      builder: (BuildContext context, GoRouterState state) {
        return const EntertainmentScreen();
      },
      routes: <RouteBase>[
        GoRoute(
          path: 'movies',
          builder: (BuildContext context, GoRouterState state) {
            return const MoviesScreen();
          },
        ), //! movies
        GoRoute(
          path: 'cartoons',
          builder: (BuildContext context, GoRouterState state) {
            return const CartoonsScreen();
          },
        ), //! cartoons
        GoRoute(
          path: 'series',
          builder: (BuildContext context, GoRouterState state) {
            return const SeriesScreen();
          },
        ), //! series
        GoRoute(
          path: 'musics',
          builder: (BuildContext context, GoRouterState state) {
            return const MusicsScreen();
          },
        ), //! musics
        GoRoute(
          path: 'my-wishlist',
          builder: (BuildContext context, GoRouterState state) {
            return const MyWishlistScreen();
          },
        ), //! my wishlist
        GoRoute(
          path: 'video-player',
          builder: (BuildContext context, GoRouterState state) {
            return const VideoPlayerScreen();
          },
        ), //! video player
        GoRoute(
          path: 'music-player',
          builder: (BuildContext context, GoRouterState state) {
            return const MusicPlayerScreen();
          },
        ), //! music player
      ],
    ),
    GoRoute(
      path: '/jobs',
      builder: (BuildContext context, GoRouterState state) {
        return const JobsScreen();
      },
      routes: <RouteBase>[
        GoRoute(
          path: 'job',
          builder: (BuildContext context, GoRouterState state) {
            return const JobScreen();
          },
        ), //! job
        GoRoute(
          path: 'create-job',
          builder: (BuildContext context, GoRouterState state) {
            return const CreateJobScreen();
          },
        ), //! create job
        GoRoute(
          path: 'my-job',
          builder: (BuildContext context, GoRouterState state) {
            return const MyJobScreen();
          },
        ), //! my job
      ],
    ),
    GoRoute(
      path: '/ai',
      builder: (BuildContext context, GoRouterState state) {
        return const AiScreen();
      },
      routes: <RouteBase>[
        GoRoute(
          path: 'ai-chat',
          builder: (BuildContext context, GoRouterState state) {
            return const AiChatScreen();
          },
        ), //! AI chat
      ],
    ),
  ],
);

CustomTransitionPage<dynamic> buildCustomTransition({
  required Widget screen,
  required int transitionDuration,
  required int duration,
  required PageTransitionType transitionType,
}) {
  return CustomTransitionPage(
    child: screen,
    transitionDuration: Duration(milliseconds: transitionDuration),
    transitionsBuilder: (context, animation, secondaryAnimation, child) {
      return PageTransition(
        type: transitionType,
        child: child,
        duration: Duration(milliseconds: duration),
      ).buildTransitions(context, animation, secondaryAnimation, child);
    },
  );
}
