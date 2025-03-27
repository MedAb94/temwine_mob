import 'package:go_router/go_router.dart';
import 'package:temwin_front_app/Application/Presentation/Screens/Home/home.dart';
import 'package:temwin_front_app/Application/Presentation/Screens/Login/login.dart';
import 'package:temwin_front_app/Application/Presentation/Screens/MrzScanner/isolate_camera.screen.dart';
import 'package:temwin_front_app/Application/Presentation/Screens/PointOfSell/point_of_sell.dart';
import 'package:temwin_front_app/Application/Presentation/Screens/PointOfSell/point_of_sell_offline.dart';
import 'package:temwin_front_app/Application/Presentation/Screens/Settings/settings.dart';
import 'package:temwin_front_app/Application/Presentation/Screens/Splash/splash.dart';
import 'package:temwin_front_app/Application/Presentation/Screens/History/history.dart';
import 'package:temwin_front_app/Core/utils/app_routes_constants.dart';
import 'package:flutter/material.dart';
import 'package:temwin_front_app/Domain/entities/pos_bnf_data_entity.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

// class GoRouterNavigation {
//   static GoRouter getRoutes() {
//     return GoRouter(initialLocation: "/", routes: [
//       GoRoute(
//         name: MyAppRouteConstants.splashRouteName,
//         path: '/',
//         builder: (context, state) {
//           return const Splash();
//           //MaterialPage(key: state.pageKey, child: const Home());
//         },
//       ),

//       // GoRoute(
//       //   name: MyAppRouteConstants.homeScreenRouteName,
//       //   path: '/HomeScreen',
//       //   builder: (context, state) {
//       //     return const

//       //         Home();

//       //   },
//       // ),
//       GoRoute(
//         name: MyAppRouteConstants.loginRouteName,
//         path: '/login',
//         builder: (context, state) {
//           return const Login();
//           //MaterialPage(key: state.pageKey, child: const Login());
//         },
//       ),
//     ]);
//   }
// }

// main() {
//   CustomNavigationHelper.instance;
//   runApp(const App());
// }

// class App extends StatelessWidget {
//   const App({Key? key}) : super(key: key);

//   @override
//   Widget build(BuildContext context) {
//     return MaterialApp.router(
//       debugShowCheckedModeBanner: false,
//       routerConfig: CustomNavigationHelper.router,
//     );
//   }
// }

class CustomNavigationHelper {
  static final CustomNavigationHelper _instance =
      CustomNavigationHelper._internal();

  static CustomNavigationHelper get instance => _instance;

  static late final GoRouter router;

  static final GlobalKey<NavigatorState> parentNavigatorKey =
      GlobalKey<NavigatorState>();
  static final GlobalKey<NavigatorState> homeTabNavigatorKey =
      GlobalKey<NavigatorState>();
  static final GlobalKey<NavigatorState> searchTabNavigatorKey =
      GlobalKey<NavigatorState>();
  static final GlobalKey<NavigatorState> settingsTabNavigatorKey =
      GlobalKey<NavigatorState>();

  BuildContext get context =>
      router.routerDelegate.navigatorKey.currentContext!;

  GoRouterDelegate get routerDelegate => router.routerDelegate;

  GoRouteInformationParser get routeInformationParser =>
      router.routeInformationParser;

  // static const String signUpPath = '/signUp';
  static const String splashPath = '/splash';
  static const String loginPath = '/signIn';
  static const String posPath = '/pos';
  static const String posOfflinePath = '/pos-offline';
  static const String cameraIsolatePath = '/camera-isolate';
  // static const String detailPath = '/detail';
  // static const String rootDetailPath = '/rootDetail';

  static const String homePath = '/home';
  static const String settingsPath = '/settings';
  static const String historyPath = '/history';

  factory CustomNavigationHelper() {
    return _instance;
  }

  CustomNavigationHelper._internal() {
    final routes = [
      StatefulShellRoute.indexedStack(
        parentNavigatorKey: parentNavigatorKey,
        branches: [
          StatefulShellBranch(
            navigatorKey: homeTabNavigatorKey,
            routes: [
              GoRoute(
                path: homePath,
                pageBuilder: (context, GoRouterState state) {
                  return getPage(
                    child: const HomePage(),
                    state: state,
                  );
                },
              ),
            ],
          ),
          StatefulShellBranch(
            navigatorKey: searchTabNavigatorKey,
            routes: [
              GoRoute(
                path: historyPath,
                pageBuilder: (context, state) {
                  return getPage(
                    child: const HistoryPage(),
                    state: state,
                  );
                },
              ),
            ],
          ),
          StatefulShellBranch(
            navigatorKey: settingsTabNavigatorKey,
            routes: [
              GoRoute(
                path: settingsPath,
                pageBuilder: (context, state) {
                  return getPage(
                    child: const SettingsPage(),
                    state: state,
                  );
                },
              ),
            ],
          ),
        ],
        pageBuilder: (
          BuildContext context,
          GoRouterState state,
          StatefulNavigationShell navigationShell,
        ) {
          return getPage(
            child: BottomNavigationPage(
              child: navigationShell,
            ),
            state: state,
          );
        },
      ),
      // GoRoute(
      //   parentNavigatorKey: parentNavigatorKey,
      //   path: signUpPath,
      //   pageBuilder: (context, state) {
      //     return getPage(
      //       child: const SignUpPage(),
      //       state: state,
      //     );
      //   },
      // ),
      GoRoute(
        parentNavigatorKey: parentNavigatorKey,
        path: loginPath,
        pageBuilder: (context, state) {
          return getPage(
            child: const Login(),
            state: state,
          );
        },
      ),
      GoRoute(
        parentNavigatorKey: parentNavigatorKey,
        path: splashPath,
        pageBuilder: (context, state) {
          return getPage(
            child: const Splash(),
            state: state,
          );
        },
      ),
      GoRoute(
        path: posPath,
        pageBuilder: (context, state) {
          PosBnfDataEntity data = state.extra as PosBnfDataEntity;
          return getPage(
            child: PointOfSell(data: data),
            state: state,
          );
        },
      ),
      GoRoute(
        path: posOfflinePath,
        pageBuilder: (context, state) {
          PosBnfDataEntity data = state.extra as PosBnfDataEntity;
          return getPage(
            child: PointOfSellOffline(bnf: data),
            state: state,
          );
        },
      ),
      GoRoute(
        path: cameraIsolatePath,
        pageBuilder: (context, state) {
          bool isOffline = state.extra as bool;
          return getPage(
            child: IsolateCameraScreen(isOffline: isOffline),
            state: state,
          );
        },
      ),
      // GoRoute(
      //   path: detailPath,
      //   pageBuilder: (context, state) {
      //     return getPage(
      //       child: const DetailPage(),
      //       state: state,
      //     );
      //   },
      // ),
      // GoRoute(
      //   parentNavigatorKey: parentNavigatorKey,
      //   path: rootDetailPath,
      //   pageBuilder: (context, state) {
      //     return getPage(
      //       child: const DetailPage(),
      //       state: state,
      //     );
      //   },
      // ),
    ];

    router = GoRouter(
      navigatorKey: parentNavigatorKey,
      initialLocation: splashPath,
      routes: routes,
    );
  }

  static Page getPage({
    required Widget child,
    required GoRouterState state,
  }) {
    return MaterialPage(
      key: state.pageKey,
      child: child,
    );
  }
}

class DetailPage extends StatelessWidget {
  const DetailPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Detail"),
      ),
    );
  }
}

// class SignUpPage extends StatelessWidget {
//   const SignUpPage({super.key});

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: const Text("SignUp"),
//       ),
//       body: Center(
//         child: Column(
//           mainAxisAlignment: MainAxisAlignment.center,
//           children: [
//             ElevatedButton(
//               onPressed: () {
//                 CustomNavigationHelper.router.push(
//                   CustomNavigationHelper.loginPath,
//                 );
//               },
//               child: const Text('Push SignIn'),
//             ),
//             const Padding(
//               padding: EdgeInsets.all(8.0),
//               child: Text(
//                 'Using push method of router enable us to go back functionality',
//                 textAlign: TextAlign.center,
//               ),
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }

// class SignInPage extends StatelessWidget {
//   const SignInPage({super.key});

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: const Text("SignIn"),
//       ),
//       body: Center(
//         child: Column(
//           mainAxisAlignment: MainAxisAlignment.center,
//           children: [
//             ElevatedButton(
//               onPressed: () {
//                 CustomNavigationHelper.router.push(
//                   CustomNavigationHelper.homePath,
//                 );
//               },
//               child: const Text('Push Home Page'),
//             ),
//             const Padding(
//               padding: EdgeInsets.all(8.0),
//               child: Text(
//                 'Using push method of router enable us to push that page as standalone page instead of showing with Shell',
//                 textAlign: TextAlign.center,
//               ),
//             ),
//             ElevatedButton(
//               onPressed: () {
//                 CustomNavigationHelper.router.go(
//                   CustomNavigationHelper.homePath,
//                 );
//               },
//               child: const Text('Go Home Page'),
//             ),
//             const Padding(
//               padding: EdgeInsets.all(8.0),
//               child: Text(
//                 'Instead if we use go method of router we will have the home page with the Shell',
//                 textAlign: TextAlign.center,
//               ),
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }

class BottomNavigationPage extends StatefulWidget {
  const BottomNavigationPage({
    super.key,
    required this.child,
  });

  final StatefulNavigationShell child;

  @override
  State<BottomNavigationPage> createState() => _BottomNavigationPageState();
}

class _BottomNavigationPageState extends State<BottomNavigationPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: widget.child,
      ),
      bottomNavigationBar: BottomNavigationBar(
        type: BottomNavigationBarType.fixed,
        currentIndex: widget.child.currentIndex,
        onTap: (index) {
          widget.child.goBranch(
            index,
            initialLocation: index == widget.child.currentIndex,
          );
          setState(() {});
        },
        items: [
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: AppLocalizations.of(context)!.home,
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.history),
            label: AppLocalizations.of(context)!.history,
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.settings),
            label: AppLocalizations.of(context)!.settings,
          ),
        ],
      ),
    );
  }
}
