import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:temwin_front_app/Application/BusinessLogic/Cubit/password_obscure_cubit/password_obscure_cubit.dart';
import 'package:temwin_front_app/Application/Presentation/Widgets/Commons/custom_text_field.dart';
import 'package:temwin_front_app/Core/dependency_injection.dart/injections.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class PasswordField extends StatelessWidget {
  const PasswordField(
      {super.key,
      required this.controller,
      this.hint,
      this.validator,
      this.label});

  final TextEditingController controller;
  final String? hint;
  final String? Function(String?)? validator;
  final String? label;

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => sl<PasswordObscureCubit>(),
      child: BlocBuilder<PasswordObscureCubit, bool>(
        builder: (context, state) {
          return CustomTextField(
            controller: controller,
            isPassword: true,
            prefixIcon: Icons.lock,
            label: label,
            hint: hint ?? AppLocalizations.of(context)!.password,
            //  "Mot de passe",
            validator: validator ??
                (password) => password != null &&
                        password.isNotEmpty &&
                        password.length >= 4
                    ? null
                    : AppLocalizations.of(context)!.password_invalid,
            // "Password is invalid",
            isObscure: state,
            setObscure: () {
              state == true
                  ? context.read<PasswordObscureCubit>().disable()
                  : context.read<PasswordObscureCubit>().enable();
            },
          );
        },
      ),
    );
  }
}
