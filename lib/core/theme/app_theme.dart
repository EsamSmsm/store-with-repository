import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:hospital25/core/constants/app_config.dart';
import 'package:hospital25/core/constants/dimensions.dart';
import 'package:hospital25/core/theme/colors.dart';

class AppTheme {
  const AppTheme._();

  static ThemeData getLightTheme({required bool isArabic}) {
    return ThemeData(
      backgroundColor: lightBgGrey2,
      scaffoldBackgroundColor: lightBgWhite,
      brightness: Brightness.light,
      visualDensity: VisualDensity.adaptivePlatformDensity,
      bottomAppBarColor: Colors.transparent,
      appBarTheme: AppBarTheme(
        backgroundColor: lightBgWhite,
        elevation: 1,
        toolbarHeight: ScreenUtil().screenWidth > 800 ? 80 : 70,
        systemOverlayStyle: const SystemUiOverlayStyle(
          statusBarColor: Colors.transparent,
          statusBarBrightness: Brightness.light,
          statusBarIconBrightness: Brightness.dark,
          systemNavigationBarIconBrightness: Brightness.dark,
          systemNavigationBarDividerColor: Colors.transparent,
        ),
        iconTheme: const IconThemeData(
          color: Colors.black,
        ),
        titleTextStyle: TextStyle(
          fontSize: 16.sp,
          fontWeight: FontWeight.normal,
          color: Colors.black,
        ),
      ),
      canvasColor: lightBgWhite,
      fontFamily: isArabic ? 'Tajawal' : 'Roboto',
      buttonTheme: ButtonThemeData(
        minWidth: double.infinity,
        height: 60.h,
        buttonColor: lightPrimary,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadiusDirectional.circular(verySmallRadius),
        ),
      ),
      outlinedButtonTheme: OutlinedButtonThemeData(
        style: OutlinedButton.styleFrom(
          side: const BorderSide(color: lightPrimary),
          textStyle: TextStyle(
            fontSize: ScreenUtil().screenWidth > 500 ? 15.sp : 14.sp,
            color: const Color(0xff2F2F2F),
            fontWeight: FontWeight.normal,
            fontFamily: isArabic ? 'Tajawal' : 'Roboto',
          ),
          tapTargetSize: MaterialTapTargetSize.shrinkWrap,
        ),
      ),
      textButtonTheme: TextButtonThemeData(
        style: ButtonStyle(
          foregroundColor: MaterialStateProperty.all<Color>(
            lightPrimary,
          ),
        ),
      ),
      textTheme: TextTheme(
        subtitle1: TextStyle(
          // fontSize: ScreenUtil().screenWidth > 500 ? 16.sp : 15.sp,
          fontSize: 15.sp,
          color: Colors.black,
          fontWeight: FontWeight.w500,
        ),
        subtitle2: TextStyle(
          // fontSize: ScreenUtil().screenWidth > 500 ? 15.sp : 14.sp,
          fontSize: 14.sp,
          color: Colors.black,
          fontWeight: FontWeight.normal,
        ),
        bodyText1: TextStyle(
          // fontSize: ScreenUtil().screenWidth > 500 ? 15.sp : 14.sp,
          fontSize: 13.5.sp,
          color: Colors.black,
          fontWeight: FontWeight.normal,
        ),
        bodyText2: TextStyle(
          // fontSize: ScreenUtil().screenWidth > 500 ? 13.sp : 12.sp,
          fontSize: 13.sp,
          color: const Color(0xff505050),
          fontWeight: FontWeight.normal,
        ),
        headline3: TextStyle(
          // fontSize: ScreenUtil().screenWidth > 500 ? 19.sp : 18.sp,
          fontSize: 28.sp,
          fontWeight: FontWeight.w500,
          color: Colors.black,
        ),
        headline4: TextStyle(
          // fontSize: ScreenUtil().screenWidth > 500 ? 19.sp : 18.sp,
          fontSize: 18.sp,
          fontWeight: FontWeight.normal,
          color: Colors.black,
        ),
        headline5: TextStyle(
          // fontSize: ScreenUtil().screenWidth > 500 ? 17.sp : 16.sp,
          fontSize: 16.sp,
          fontWeight: FontWeight.normal,
          color: Colors.black,
        ),
        headline6: TextStyle(
          // fontSize: ScreenUtil().screenWidth > 500 ? 16.sp : 15.sp,
          fontSize: 15.sp,
          fontWeight: FontWeight.normal,
          color: Colors.black,
        ),
        caption: TextStyle(
          // fontSize: ScreenUtil().screenWidth > 500 ? 13.sp : 12.sp,
          fontSize: 13.sp,
          color: captionColor,
        ),
        button: TextStyle(
          // fontSize: ScreenUtil().screenWidth > 500 ? 15.sp : 14.sp,
          fontSize: 14.sp,
          color: Colors.white,
          fontWeight: FontWeight.normal,
        ),
      ).apply(
        fontSizeDelta: 1,
        fontSizeFactor: isArabic ? 1.07 : 1.05,
      ),
      iconTheme: const IconThemeData().copyWith(size: 16),
      colorScheme: ColorScheme.fromSwatch(
        accentColor: lightPrimary,
        primarySwatch: primarySwatch,
      ),
      sliderTheme: SliderThemeData(
        activeTickMarkColor: authBackgroundColor,
        activeTrackColor: authBackgroundColor,
        disabledActiveTickMarkColor: authBackgroundColor,
        disabledActiveTrackColor: authBackgroundColor,
        inactiveTickMarkColor: authBackgroundColor,
        inactiveTrackColor: authBackgroundColor,
        valueIndicatorColor: Colors.transparent,
        valueIndicatorTextStyle:
            const TextStyle(fontSize: 10, color: Colors.black, height: 0.5),
        overlayShape: const RoundSliderOverlayShape(overlayRadius: 20),
        overlayColor: lightPrimary.withOpacity(0.2),
        rangeThumbShape: const RoundRangeSliderThumbShape(
          enabledThumbRadius: 14,
          elevation: 4,
          pressedElevation: 10,
        ),
      ),
    );
  }

  static void setStatusBarAndNotificationBarColor(ThemeMode themeMode) {
    SystemChrome.setSystemUIOverlayStyle(
      SystemUiOverlayStyle(
        statusBarColor: Colors.transparent,
        statusBarBrightness:
            themeMode == ThemeMode.light ? Brightness.light : Brightness.dark,
        statusBarIconBrightness:
            themeMode == ThemeMode.light ? Brightness.dark : Brightness.light,
        systemNavigationBarIconBrightness:
            themeMode == ThemeMode.light ? Brightness.dark : Brightness.light,
        systemNavigationBarDividerColor: Colors.transparent,
      ),
    );
  }

  static Brightness? get currentSystemBrightness {
    return SchedulerBinding.instance?.window.platformBrightness;
  }
}
