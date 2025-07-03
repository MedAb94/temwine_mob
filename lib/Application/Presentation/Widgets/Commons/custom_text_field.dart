import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:temwin_front_app/Core/utils/colors.dart';

class CustomTextField extends StatelessWidget {
  const CustomTextField(
      {super.key,
      this.isPassword = false,
      required this.hint,
      required this.controller,
      required this.validator,
      this.isObscure,
      this.isReadOnly = false,
      this.setObscure,
      this.label,
      this.suffix,
      this.prefixIcon,
      this.onChanged,
      this.onFieldSubmitted,
      this.onEditingComplete,
      this.enabled = true,
      this.maxLines = 1,
      this.keyboardType = TextInputType.text});

  final bool isPassword;
  final String hint;
  final TextEditingController controller;
  final String? Function(String?) validator;
  final bool? isObscure;
  final Function()? setObscure;
  final bool isReadOnly;
  final Widget? suffix;
  final String? label;
  final void Function(String)? onChanged;
  final void Function(String)? onFieldSubmitted;
  final void Function()? onEditingComplete;
  //onEditingComplete
  final bool enabled;
  final int maxLines;
  final TextInputType keyboardType;
  final IconData? prefixIcon;

  @override
  Widget build(BuildContext context) {
    return Card(
        elevation: 5,
        color: Colors.white,
        child: Padding(
          padding: EdgeInsets.only(
            left: 11.w,
          ),
          child: Row(
            children: [
              Expanded(
                child:

                    TextFormField(
                  controller: controller,
                  readOnly: isReadOnly,
                  enabled: enabled,
                  obscureText: isPassword ? isObscure! : false,
                  keyboardType: keyboardType,
                  textInputAction: TextInputAction.done,
                  validator: validator,
                  cursorColor: AppColors.blue,
                  textAlignVertical: keyboardType == TextInputType.multiline
                      ? TextAlignVertical.top
                      : TextAlignVertical.center,
                  //textAlign: TextAlign.start,
                  maxLines: maxLines,
                  decoration: InputDecoration(
                      // filled: true,
                      // isCollapsed: true,
                      label: label != null ? Text(label!) : null,
                      border: InputBorder.none,
                      hintText: hint,
                      // suffix: suffix,
                      // contentPadding: EdgeInsets.only(
                      //   left: 11.w,
                      // ),
                      hintStyle: TextStyle(
                        fontSize: 17.sp,
                        color: const Color(0xff4D4D4D),
                      ),
                      prefixIcon: prefixIcon != null
                          ? IconButton(
                              icon: Icon(prefixIcon!),
                              onPressed: () {},
                            )
                          : const SizedBox(),
                      suffixIcon: isPassword
                          ? IconButton(
                              icon: isObscure!
                                  ? const Icon(Icons.visibility_off)
                                  : const Icon(Icons.visibility),
                              onPressed: () {
                                setObscure!();
                              },
                            )
                          : const SizedBox()),
                  onChanged: onChanged,
                  onFieldSubmitted: onFieldSubmitted,
                  onEditingComplete: onEditingComplete,
                ),
              ),
              if (suffix != null) ...[
                suffix!,
                SizedBox(
                  width: 20.w,
                )
              ]
            ],
          ),
        ));
  }
}
