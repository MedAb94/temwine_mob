import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:go_router/go_router.dart';
import 'package:temwin_front_app/Application/BusinessLogic/Bloc/auth_bloc/bloc/auth_bloc.dart';
import 'package:temwin_front_app/Application/BusinessLogic/Cubit/user_cubit/user_cubit.dart';
import 'package:temwin_front_app/Core/Navigation/go_router_navigation.dart';
import 'package:temwin_front_app/Core/utils/app_assets.dart';
import 'package:temwin_front_app/Core/utils/app_routes_constants.dart';

class Splash extends StatefulWidget {
  const Splash({super.key});

  @override
  State<Splash> createState() => _SplashState();
}

class _SplashState extends State<Splash> {
  @override
  void initState() {
    super.initState();
  }

  void navigateToLogin() {
    context.pushReplacementNamed(MyAppRouteConstants.loginRouteName);
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<AuthBloc, AuthState>(
      listener: (context, state) {
        if (state is UnAuthenticated) {
          CustomNavigationHelper.router.pushReplacement(
            CustomNavigationHelper.loginPath,
          );

          //context.pushReplacementNamed(MyAppRouteConstants.loginRouteName);
        }
        if (state is Authenticated) {
          context.read<UserCubit>().getUser();

          //context.pushReplacementNamed(MyAppRouteConstants.homeScreenRouteName);

          CustomNavigationHelper.router.pushReplacement(
            CustomNavigationHelper.homePath,
          );
        }
      },
      child: Scaffold(
        body: SafeArea(
          child: Center(
            child: Image.asset(
              AppAssets.app_logo,
            ),
          ),
        ),
      ),
    );
  }
}
