import 'package:hospital25/presentation/routers/import_helper.dart';

void customSnackBarTablet(
    {required BuildContext context,
    required String message,
    Color color = Colors.red,
    Widget? trailing,
    int durationBySeconds = 4}) {
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
      duration: Duration(seconds: durationBySeconds),
    ),
  );
}
