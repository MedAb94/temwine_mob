import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'package:temwin_front_app/Application/Presentation/Widgets/Commons/common_button.dart';
import 'package:temwin_front_app/Core/Navigation/go_router_navigation.dart';
import 'package:temwin_front_app/Core/utils/colors.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

showAlertDialog(BuildContext context,
    {VoidCallback? onCancel,
    VoidCallback? onConfirm,
    String? title,
    String? text1,
    String? text2,
    Color? color1,
    color2,
    textColor1,
    textColor2,
    required Widget content,
    double? buttonFontSize,
    hasActions = true,
    barrierDismissible = false,
    EdgeInsetsGeometry? titlePadding,
    EdgeInsetsGeometry? contentPadding}) {
  // set up the buttons
  Widget cancelButton = CommonButton(
    text: text1 ?? "CANCEL",
    fn: () => onCancel!(),
    color: color1 ?? Colors.white,
    textColor: textColor1 ?? AppColors.black,
    buttonFontSize: Platform.isAndroid ? buttonFontSize : 14.sp,
  );

  // TextButton(
  //   child:

  //   //  Text("Cancel"),
  //   // onPressed: () => onCancel(),
  // );
  Widget continueButton = CommonButton(
    text: text2 ?? "CONTINUE",
    fn: () => onConfirm!(),
    color: color2 ?? Colors.white,
    textColor: textColor2 ?? AppColors.black,
    buttonFontSize: Platform.isAndroid ? buttonFontSize : 14.sp,
  );

  // TextButton(
  //   child: Text("Continue"),
  //   onPressed: () => onConfirm(),
  // );
  // set up the AlertDialog

  if (Platform.isAndroid) {
    AlertDialog alert = AlertDialog(
      titlePadding: titlePadding,
      contentPadding: contentPadding,
      // iconPadding: const EdgeInsets.all(0),
      // icon: Align(
      //   alignment: Alignment.topRight,
      //   child: InkWell(
      //     onTap: () {
      //       Navigator.pop(context);
      //     },
      //     child: Icon(Icons.close),
      //     // child: Image.asset(
      //     //   'assets/cancel.png',
      //     //   height: 30,
      //     // ),
      //   ),
      // ),
      title: title != null ? Text(title) : null,
      content: content,
      actions: hasActions
          ? [
              cancelButton,
              continueButton,
            ]
          : null,
    );
    // show the dialog
    showDialog<bool>(
      context: context,
      barrierDismissible: barrierDismissible,
      builder: (BuildContext dialogContext) {
        return alert;
      },
    );
  } else {
    CupertinoAlertDialog cupertinoAlertDialog = CupertinoAlertDialog(
      //titlePadding: titlePadding,
      // contentPadding: contentPadding,
      title: title != null ? Text(title) : null,
      content: content,
      actions: hasActions
          ? [
              Padding(
                padding: EdgeInsets.symmetric(vertical: 6.h, horizontal: 5.w),
                child: cancelButton,
              ),
              Padding(
                  padding: EdgeInsets.symmetric(vertical: 6.h, horizontal: 5.w),
                  child: continueButton),
            ]
          : [],
    );

    showCupertinoDialog(
      context: context,
      barrierDismissible: barrierDismissible,
      builder: (BuildContext dialogContext) {
        return cupertinoAlertDialog;
      },
    );
  }
}

showSellDialog(BuildContext context, List<String> texts,
    [bool isError = false]) {
  showAlertDialog(context,
      hasActions: false,
      contentPadding: EdgeInsets.fromLTRB(10.w, 20, 10.w, 24),
      content: SizedBox(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          spacing: 15.h,
          children: [
            Row(
              spacing: 5.w,
              children: [
                Icon(
                  isError ? Icons.error : Icons.check,
                  color: isError ? AppColors.red : AppColors.green,
                ),
                Text(
                  isError
                      ? AppLocalizations.of(context)!.error
                      : AppLocalizations.of(context)!.success,
                  // 'Success',
                  style:
                      TextStyle(fontWeight: FontWeight.bold, fontSize: 18.sp),
                ),
                Spacer(),
                Icon(Icons.close)
              ],
            ),
            Divider(
              color: AppColors.grey,
            ),
            ...texts.map(
              (textMessage) => Row(
                spacing: 5.w,
                children: [
                  Material(
                    color: AppColors.green, // Background color
                    shape: CircleBorder(),
                    child: IconButton(
                      icon: Icon(
                        Icons.check,
                        color: AppColors.white,
                      ),
                      onPressed: null,
                      color: AppColors.green,
                      disabledColor: AppColors.green,
                      splashColor: AppColors.green,
                    ),
                  ),
                  Expanded(
                    child: Text(
                      textMessage,
                      // AppLocalizations.of(context)!.payment_success,
                      maxLines: 2,
                      // "Paiement effectue avec succes",
                      style: TextStyle(
                          fontWeight: FontWeight.bold, fontSize: 14.sp),
                    ),
                  ),
                ],
              ),
            ),

            // Row(
            //   spacing: 5.w,
            //   children: [
            //     Material(
            //       color: AppColors.green, // Background color
            //       shape: CircleBorder(),
            //       child: IconButton(
            //         icon: Icon(
            //           Icons.check,
            //           color: AppColors.white,
            //         ),
            //         onPressed: null,
            //         color: AppColors.green,
            //         disabledColor: AppColors.green,
            //         splashColor: AppColors.green,
            //       ),
            //     ),
            //     Expanded(
            //       child: Text(
            //         AppLocalizations.of(context)!.sale_with_success,
            //         maxLines: 2,
            //         //  "Vente effectue avec succes",
            //         style: TextStyle(
            //             fontWeight: FontWeight.bold, fontSize: 14.sp),
            //       ),
            //     ),
            //   ],
            // ),
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
        ),
      ));
}
