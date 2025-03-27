import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';

import 'package:temwin_front_app/Application/BusinessLogic/Bloc/auth_bloc/bloc/auth_bloc.dart';
import 'package:temwin_front_app/Application/BusinessLogic/Cubit/user_cubit/user_cubit.dart';
import 'package:temwin_front_app/Application/Presentation/Widgets/Commons/alert_dialog.dart';
import 'package:temwin_front_app/Application/Presentation/Widgets/Commons/common_button.dart';
import 'package:temwin_front_app/Core/Navigation/go_router_navigation.dart';
import 'package:temwin_front_app/Core/utils/app_routes_constants.dart';
import 'package:temwin_front_app/Core/utils/colors.dart';
import 'package:temwin_front_app/Domain/entities/user_entity.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class LoginButton extends StatelessWidget {
  const LoginButton(
      {super.key,
      required this.emailController,
      required this.passwordController,
      required this.formKey});

  final TextEditingController emailController;
  final TextEditingController passwordController;
  final GlobalKey<FormState> formKey;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
        width: double.maxFinite,
        child: BlocConsumer<AuthBloc, AuthState>(
          listener: (context, state) {
            if (state is Authenticated) {
              context.read<UserCubit>().getUser();

              // context.pushReplacementNamed(
              //     MyAppRouteConstants.homeScreenRouteName);

              CustomNavigationHelper.router.pushReplacement(
                CustomNavigationHelper.homePath,
              );
            }
            if (state is AuthError) {
              showAlertDialog(context,
                  hasActions: false,
                  contentPadding: EdgeInsets.fromLTRB(10.w, 20, 10.w, 24),
                  content: Column(
                    mainAxisSize: MainAxisSize.min,
                    spacing: 15.h,
                    children: [
                      Row(
                        spacing: 5.w,
                        children: [
                          Icon(
                            Icons.error,
                            color: AppColors.red,
                          ),
                          Text(
                            AppLocalizations.of(context)!.error,
                            // 'Erreur',
                            style: TextStyle(
                                fontWeight: FontWeight.bold, fontSize: 18.sp),
                          ),
                          Spacer(),
                          Icon(Icons.close)
                        ],
                      ),
                      Divider(
                        color: AppColors.grey,
                      ),
                      Text(
                        // AppLocalizations.of(context)!.user_does_not_exist,
                        state.errorMessage,
                        //  "Cet utilisateur n'existe pas",
                        style: TextStyle(
                            fontWeight: FontWeight.bold, fontSize: 14.sp),
                      ),
                      Row(
                        children: [
                          Expanded(
                            child: CommonButton(
                              text: "OK",
                              fn: () {
                                CustomNavigationHelper.router.pop();
                              },
                              color: AppColors.black,
                              textColor: AppColors.white,
                            ),
                          ),
                        ],
                      )
                    ],
                  ));

              // ScaffoldMessenger.of(context).showSnackBar(
              //   SnackBar(
              //     backgroundColor: const Color(0xffD7294A),
              //     content: Text(
              //       state.errorMessage,
              //       textAlign: TextAlign.center,
              //       style: const TextStyle(
              //           fontWeight: FontWeight.bold, color: Colors.white),
              //     ),
              //   ),
              // );
            }
          },
          builder: (context, state) {
            return TextButton(
                onPressed: state is Authenticating
                    ? () {}
                    : () {
                        // print('go clicked');
                        if (formKey.currentState!.validate()) {
                          debugPrint("Valided");
                          debugPrint("email : ${emailController.text}");
                          debugPrint("password : ${passwordController.text}");
                          context.read<AuthBloc>().add(SignIn(
                              userCreds: UserEntity(
                                  email: emailController.text,
                                  password: passwordController.text)));
                        }
                      },
                style: TextButton.styleFrom(
                    backgroundColor: AppColors.white, elevation: 10),
                child: state is Authenticating
                    ? const CircularProgressIndicator(
                        strokeWidth: 1,
                        valueColor: AlwaysStoppedAnimation<Color>(
                          Colors.green,
                        ),
                      )
                    : Text(AppLocalizations.of(context)!.login,
                        //  "Connexion",
                        style: TextStyle(
                            fontSize: 20.sp,
                            fontWeight: FontWeight.bold,
                            color: AppColors.green)));
          },
        ));
  }
}
