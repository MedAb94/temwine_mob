import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class CommonButton extends StatelessWidget {
  const CommonButton(
      {super.key,
      required this.text,
      required this.fn,
      required this.color,
      this.isLoading = false,
      this.isDisabled = false,
      this.loadingText,
      this.textColor,
      this.buttonFontSize});

  final String text;
  final VoidCallback fn;
  final Color color;
  final bool isLoading;
  final bool isDisabled;
  final String? loadingText;
  final Color? textColor;
  final double? buttonFontSize;

  @override
  Widget build(BuildContext context) {
    return TextButton(
        onPressed: isDisabled == true
            ? null
            : isLoading
                ? () {}
                : () => fn(),
        style: TextButton.styleFrom(
            backgroundColor: isDisabled ? color.withOpacity(0.2) : color
            //const Color(0xff002F5F)
            ),
        child: isLoading && loadingText != null
            ? Row(
                children: [
                  const CircularProgressIndicator.adaptive(
                    strokeWidth: 1,
                    valueColor: AlwaysStoppedAnimation<Color>(
                      Colors.white,
                    ),
                  ),
                  SizedBox(
                    width: 10.w,
                  ),
                  Text(loadingText!,
                      style: TextStyle(
                          fontSize: buttonFontSize ?? 20.sp,
                          fontWeight: FontWeight.bold,
                          color: Colors.white))
                ],
              )
            : isLoading && loadingText == null
                ? CircularProgressIndicator.adaptive(
                    strokeWidth: Platform.isIOS ? 2 : 1,
                    valueColor: const AlwaysStoppedAnimation<Color>(
                      Colors.white,
                    ),
                  )
                : Text(text,
                    style: TextStyle(
                        fontSize: buttonFontSize ?? 18.sp,
                        fontWeight: FontWeight.bold,
                        color: textColor ?? Colors.white)));
  }
}

class CommonButtonWithIcon extends StatelessWidget {
  const CommonButtonWithIcon(
      {super.key,
      required this.text,
      required this.fn,
      required this.color,
      this.isLoading = false,
      this.isDisabled = false,
      this.loadingText,
      this.textColor,
      this.buttonFontSize,
      this.icon});

  final String text;
  final VoidCallback fn;
  final Color color;
  final bool isLoading;
  final bool isDisabled;
  final String? loadingText;
  final Color? textColor;
  final double? buttonFontSize;
  final IconData? icon;

  @override
  Widget build(BuildContext context) {
    return TextButton(
        onPressed: isDisabled == true
            ? null
            : isLoading
                ? () {}
                : () => fn(),
        style: TextButton.styleFrom(
            backgroundColor: isDisabled ? color.withOpacity(0.2) : color
            //const Color(0xff002F5F)
            ),
        child: isLoading && loadingText != null
            ? Row(
                children: [
                  const CircularProgressIndicator.adaptive(
                    strokeWidth: 1,
                    valueColor: AlwaysStoppedAnimation<Color>(
                      Colors.white,
                    ),
                  ),
                  SizedBox(
                    width: 10.w,
                  ),
                  Text(loadingText!,
                      style: TextStyle(
                          fontSize: buttonFontSize ?? 20.sp,
                          fontWeight: FontWeight.bold,
                          color: Colors.white))
                ],
              )
            : isLoading && loadingText == null
                ? CircularProgressIndicator.adaptive(
                    strokeWidth: Platform.isIOS ? 2 : 1,
                    valueColor: const AlwaysStoppedAnimation<Color>(
                      Colors.white,
                    ),
                  )
                : Row(
                    spacing: 6.w,
                    children: [
                      Icon(
                        icon,
                        color: Colors.white,
                      ),
                      Text(text,
                          style: TextStyle(
                              fontSize: buttonFontSize ?? 18.sp,
                              fontWeight: FontWeight.bold,
                              color: textColor ?? Colors.white)),
                    ],
                  ));
  }
}
