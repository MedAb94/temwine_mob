import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:intl/intl.dart';

import 'package:temwin_front_app/Application/BusinessLogic/Bloc/auth_bloc/bloc/auth_bloc.dart';
import 'package:temwin_front_app/Application/BusinessLogic/Bloc/sync_bloc/sync_bloc.dart';

import 'package:temwin_front_app/Application/BusinessLogic/Cubit/language_cubit.dart';
import 'package:temwin_front_app/Application/BusinessLogic/Cubit/offline_sales_cubit/offline_sales_storage_cubit.dart';
import 'package:temwin_front_app/Application/BusinessLogic/Cubit/user_cubit/user_cubit.dart';
import 'package:temwin_front_app/Core/Navigation/go_router_navigation.dart';
import 'package:temwin_front_app/Core/dependency_injection.dart/injections.dart';
import 'package:temwin_front_app/Core/utils/colors.dart';
import 'package:temwin_front_app/Core/utils/hive_init_helper.dart';
import 'package:temwin_front_app/bloc_observer.dart';
import 'package:temwin_front_app/l10n/l10n.dart';
// Import intl package

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await initHive();
  await initAdapters();
  await setupLocator();
  CustomNavigationHelper.instance;
  Bloc.observer = SimpleBlocObserver();

  runApp(MultiBlocProvider(providers: [
    BlocProvider<AuthBloc>(create: (_) => sl<AuthBloc>()..add(AuthInit())),
    BlocProvider<UserCubit>(create: (_) => sl<UserCubit>()),
    BlocProvider<LanguageCubit>(
        create: (_) => sl<LanguageCubit>()..getLanguage()),
    BlocProvider<OfflineSalesStorageCubit>(
        create: (_) => sl<OfflineSalesStorageCubit>()),

    BlocProvider<SyncBloc>(create: (_) => sl<SyncBloc>()),
    //
  ], child: const MyApp()));
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        FocusScopeNode currentFocus = FocusScope.of(context);

        if (!currentFocus.hasPrimaryFocus) {
          currentFocus.unfocus();
        }
      },
      child: ScreenUtilInit(
        designSize: const Size(375, 812),
        minTextAdapt: true,
        child: BlocBuilder<LanguageCubit, Locale?>(
          builder: (context, localeState) {
            return MaterialApp.router(
              title: 'Temwin',
              debugShowCheckedModeBanner: false,
              theme: ThemeData(
                // This is the theme of your application.
                //
                // TRY THIS: Try running your application with "flutter run". You'll see
                // the application has a purple toolbar. Then, without quitting the app,
                // try changing the seedColor in the colorScheme below to Colors.green
                // and then invoke "hot reload" (save your changes or press the "hot
                // reload" button in a Flutter-supported IDE, or press "r" if you used
                // the command line to start the app).
                //
                // Notice that the counter didn't reset back to zero; the application
                // state is not lost during the reload. To reset the state, use hot
                // restart instead.
                //
                // This works for code too, not just values: Most code changes can be
                // tested with just a hot reload.
                colorScheme: ColorScheme.fromSeed(seedColor: AppColors.green),
                useMaterial3: true,
              ),
              routerConfig: CustomNavigationHelper.router,
              localizationsDelegates: [
                AppLocalizations.delegate,
                GlobalMaterialLocalizations.delegate,
                GlobalWidgetsLocalizations.delegate,
                GlobalCupertinoLocalizations.delegate, // For Cupertino widgets
              ],
              supportedLocales: L10n.all,
              locale: localeState,
              builder: (context, child) {
                return BlocListener<AuthBloc, AuthState>(
                  listener: (context, authState) {
                    //print("connectivityy =  $state");
                    if (authState is UnAuthenticated ||
                        authState is UnAuthenticated2) {
                      CustomNavigationHelper.router.pushReplacement(
                        CustomNavigationHelper.loginPath,
                      );
                    }
                  },
                  child: child,
                );
              },
              // routeInformationProvider: router.routeInformationProvider,
              // routeInformationParser: router.routeInformationParser,
              // routerDelegate: router.routerDelegate,
            );
          },
        ),
      ),
    );
  }
}
//}
