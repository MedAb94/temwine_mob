import 'package:email_validator/email_validator.dart';
import 'package:flutter/material.dart';
import 'package:temwin_front_app/Application/Presentation/Widgets/Commons/custom_text_field.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class EmailAddressField extends StatelessWidget {
  const EmailAddressField({
    super.key,
    required this.controller,
  });

  final TextEditingController controller;

  @override
  Widget build(BuildContext context) {
    return CustomTextField(
      controller: controller,
      hint: AppLocalizations.of(context)!.tell,
      //"Telephone",
      prefixIcon: Icons.phone,
      validator: (email) => email != null && email.isNotEmpty
          ? null
          : AppLocalizations.of(context)!.phone_number_invalid,
      //xs "phone number is invalid",
      // EmailValidator.validate(email ?? "") ? null : "Email is invalid",
    );
  }
}
