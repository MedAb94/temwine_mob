import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:temwin_front_app/Application/Presentation/Widgets/Login/email_address_text_field.dart';
import 'package:temwin_front_app/Application/Presentation/Widgets/Login/login_button.dart';
import 'package:temwin_front_app/Application/Presentation/Widgets/Login/password_text_field.dart';
import 'package:temwin_front_app/Core/utils/app_assets.dart';
import 'package:temwin_front_app/Core/utils/colors.dart';

class Login extends StatefulWidget {
  const Login({super.key});

  @override
  State<Login> createState() => _LoginState();
}

class _LoginState extends State<Login> {
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final formKey = GlobalKey<FormState>();

  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    emailController.clear();
    emailController.dispose();
    passwordController.clear();
    passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.green,
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 21.w),
          child: Column(
            spacing: 20.h,
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Image.asset(
                AppAssets.app_logo,
                width: 120.w,
                height: 120.w,
              ),
              SizedBox(
                height: 20.h,
              ),
              Form(
                  key: formKey,
                  child: Column(
                    children: [
                      EmailAddressField(
                        controller: emailController,
                      ),
                      SizedBox(
                        height: 10.h,
                      ),
                      PasswordField(
                        controller: passwordController,
                      ),
                      SizedBox(
                        height: 20.h,
                      ),
                      LoginButton(
                        formKey: formKey,
                        emailController: emailController,
                        passwordController: passwordController,
                      )
                    ],
                  )),
            ],
          ),
        ),
      ),
    );
  }
}
