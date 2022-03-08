import 'dart:developer';

import 'package:flutter/cupertino.dart';
import 'package:hospital25/core/constants/dimensions.dart';
import 'package:hospital25/core/languages/languages.dart';
import 'package:hospital25/presentation/routers/import_helper.dart';

void customSnackBar(
    {required BuildContext context,
    required String message,
    Color color = Colors.red,
    bool floating = false,
    Widget? trailing,
    double? bottomMargin,
    int durationBySeconds = 3}) {
  final mediaQuery = MediaQuery.of(context);
  log('Top Padding: ${mediaQuery.padding.top}');
  log('Top viewInsets: ${mediaQuery.viewInsets.top}');
  log('Top viewPadding: ${mediaQuery.viewPadding.top}');
  ScaffoldMessenger.of(context).removeCurrentSnackBar();
  ScaffoldMessenger.of(context).showSnackBar(
    SnackBar(
      content: Row(
        children: [
          Expanded(
            child: Text(
              message,
              textAlign: trailing != null ? TextAlign.start : TextAlign.center,
              style: Theme.of(context)
                  .textTheme
                  .bodyText2!
                  .copyWith(color: Colors.white),
            ),
          ),
          if (trailing != null) trailing,
        ],
      ),
      backgroundColor: color,
      behavior: floating ? SnackBarBehavior.floating : SnackBarBehavior.fixed,
      dismissDirection: DismissDirection.vertical,
      margin: floating
          ? EdgeInsets.only(
              bottom: 0.76.sh,
              right: hMediumPadding,
              left: hMediumPadding,
            )
          : null,
      duration: Duration(seconds: durationBySeconds),
    ),
  );
}

Future<bool?> showWarningDialog(BuildContext context,
    {String? content,
    String? title,
    String? lfButtonTxt,
    String? rtButtonTxt}) {
  return showCupertinoDialog<bool?>(
    context: context,
    builder: (context) {
      final language = Languages.of(context);
      return CupertinoAlertDialog(
        title: Text(
          title ?? AppCubit.appText?.error ?? language.error,
          style: Theme.of(context).textTheme.subtitle1,
        ),
        content: Text(
          content ??
              AppCubit.appText?.connectYourDevice ??
              language.connectYourDevice,
          style: Theme.of(context).textTheme.caption,
        ),
        actions: [
          TextButton(
            onPressed: () {
              Navigator.of(context).pop(false);
            },
            child: Text(
              lfButtonTxt ?? AppCubit.appText?.exitTxt ?? language.exitTxt,
              style: Theme.of(context)
                  .textTheme
                  .bodyText2!
                  .copyWith(color: Colors.red),
            ),
          ),
          TextButton(
            onPressed: () {
              Navigator.pop(context, true);
            },
            child: Text(
              rtButtonTxt ?? AppCubit.appText?.tryAgain ?? language.tryAgain,
              style: Theme.of(context)
                  .textTheme
                  .bodyText2!
                  .copyWith(color: Colors.blue),
            ),
          ),
        ],
      );
    },
  );
}

Future showLoadingDialog(BuildContext context) {
  return showDialog(
    barrierDismissible: false,
    context: context,
    builder: (context) => Container(
      color: Colors.transparent,
      child: const Center(
        child: CircularProgressIndicator(),
      ),
    ),
  );
}
