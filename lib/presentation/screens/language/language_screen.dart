import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:hospital25/core/constants/app_config.dart';
import 'package:hospital25/core/constants/constants.dart';
import 'package:hospital25/core/constants/dimensions.dart';
import 'package:hospital25/core/languages/languages.dart';
import 'package:hospital25/core/languages/languages_cache.dart.dart';
import 'package:hospital25/core/theme/colors.dart';
import 'package:hospital25/core/utilities/hydrated_storage.dart';
import 'package:hospital25/presentation/routers/app_router.dart';
import 'package:hospital25/presentation/widgets/defaultButton/default_button.dart';

class LanguageScreen extends StatefulWidget {
  @override
  _LanguageScreenState createState() => _LanguageScreenState();
}

class _LanguageScreenState extends State<LanguageScreen> {
  bool isArabic = false;
  bool isEnglish = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.symmetric(
            horizontal: hLargePadding,
            vertical: vMediumPadding,
          ),
          child: Column(
            children: [
              SizedBox(height: 0.085.sh),
              Image.asset(
                'assets/images/logo.png',
                width: 120.w,
                height: 50.h,
                fit: BoxFit.contain,
              ),
              SizedBox(height: vSmallPadding),
              Text(
                'natural swedish cosmetics',
                textAlign: TextAlign.center,
                style: Theme.of(context).textTheme.bodyText2!.copyWith(
                      color: const Color(0xff4B4B4B),
                      fontFamily: 'Roboto',
                    ),
              ),
              SizedBox(height: vVeryLargePadding),
              Text(
                isArabic ? 'اهلا بك في $appNameAr' : 'Welcome in $appNameEng',
                textAlign: TextAlign.center,
                style: Theme.of(context).textTheme.subtitle1!.copyWith(
                      color: Colors.black,
                      fontFamily: isArabic ? 'Tajawal' : 'Roboto',
                      height: 1,
                    ),
              ),
              SizedBox(height: vSmallPadding),
              Text(
                isArabic ? 'اختر لغتك' : 'Choose your language',
                textAlign: TextAlign.center,
                style: Theme.of(context).textTheme.headline6!.copyWith(
                      color: Colors.black,
                      fontFamily: isArabic ? 'Tajawal' : 'Roboto',
                      height: 1,
                    ),
              ),
              SizedBox(height: vVeryLargePadding),
              Directionality(
                textDirection: TextDirection.ltr,
                child: Material(
                  borderRadius: BorderRadius.circular(largeRadius),
                  clipBehavior: Clip.antiAlias,
                  color: Colors.transparent,
                  child: InkWell(
                    onTap: () async {
                      await changeLanguage(context, 'en');

                      setState(() {
                        isEnglish = true;
                        isArabic = false;
                      });
                    },
                    child: Container(
                      padding: EdgeInsets.symmetric(
                        horizontal: ScreenUtil().screenWidth > 800
                            ? hLargePadding
                            : hMediumPadding,
                        vertical: vVerySmallMargin,
                      ),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(largeRadius),
                        color: isEnglish
                            ? Theme.of(context).colorScheme.primary
                            : disabledButtonColor,
                      ),
                      child: Row(
                        children: [
                          Text(
                            'English',
                            style: Theme.of(context)
                                .textTheme
                                .bodyText1!
                                .copyWith(
                                  color:
                                      isEnglish ? Colors.white : Colors.black,
                                  fontFamily: 'Roboto',
                                ),
                          ),
                          const Spacer(),
                          Icon(
                            Icons.check_circle,
                            color: Colors.white,
                            size: 30.w,
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
              SizedBox(height: vMediumPadding * 1.1),
              Directionality(
                textDirection: TextDirection.ltr,
                child: Material(
                  borderRadius: BorderRadius.circular(largeRadius),
                  clipBehavior: Clip.antiAlias,
                  color: Colors.transparent,
                  child: InkWell(
                    onTap: () async {
                      await changeLanguage(context, 'ar');
                      setState(() {
                        isArabic = true;
                        isEnglish = false;
                      });
                    },
                    child: Container(
                      padding: EdgeInsets.symmetric(
                        horizontal: ScreenUtil().screenWidth > 800
                            ? hLargePadding
                            : hMediumPadding,
                        vertical: vVerySmallMargin,
                      ),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(largeRadius),
                        color: isArabic
                            ? Theme.of(context).colorScheme.primary
                            : disabledButtonColor,
                      ),
                      child: Row(
                        children: [
                          Text(
                            'تسوق بالعربي',
                            style: Theme.of(context)
                                .textTheme
                                .bodyText1!
                                .copyWith(
                                  color: isArabic ? Colors.white : Colors.black,
                                  fontFamily: 'Tajawal',
                                ),
                          ),
                          const Spacer(),
                          Icon(
                            Icons.check_circle,
                            color: Colors.white,
                            size: 30.w,
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
              SizedBox(height: vLargePadding),
              Text(
                isArabic
                    ? 'يمكنك تغيير لغتك في اي وقت\nمن الإعدادات '
                    : 'Your language preference can be changed at\nany time in settings',
                textAlign: TextAlign.center,
                style: Theme.of(context).textTheme.bodyText2!.copyWith(
                      height: 2,
                      color: Colors.black,
                      fontFamily: isArabic ? 'Tajawal' : 'Roboto',
                    ),
              ),
              SizedBox(height: vVeryLargePadding),
              if (isArabic || isEnglish)
                DefaultButton(
                  text: '',
                  borderRadius: veryLargeRadius,
                  width: 206.w,
                  height: 45.w,
                  onPressed: () {
                    hydratedStorage.write(isNewUserTxt, false);
                    Navigator.pushReplacementNamed(
                      context,
                      AppRouter.splash,
                    );
                  },
                  child: Text(
                    Languages.of(context).startShopping,
                    textAlign: TextAlign.center,
                    style: Theme.of(context).textTheme.subtitle1!.copyWith(
                          fontFamily: isArabic ? 'Tajawal' : 'Roboto',
                          height: 1,
                          color: Colors.white,
                        ),
                  ),
                )
              else
                SizedBox(height: 50.h),
              SizedBox(height: vVeryLargeMargin),
            ],
          ),
        ),
      ),
    );
  }
}
