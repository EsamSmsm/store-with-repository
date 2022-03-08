import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:hospital25/core/languages/language_ar.dart';
import 'package:hospital25/logic/bloc/firebaseAuth/firebase_auth_bloc.dart';
import 'package:hospital25/logic/cubit/app/app_cubit.dart';
import 'package:hospital25/presentation/routers/app_router.dart';
import 'package:hospital25/presentation/widgets/components/components.dart';

class SplashScreen extends StatefulWidget {
  final FirebaseAuthBloc authBloc;
  const SplashScreen({
    Key? key,
    required this.authBloc,
  }) : super(key: key);

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen>
    with SingleTickerProviderStateMixin {
  late final AnimationController animationController;
  late final Animation<double> animation;

  @override
  void initState() {
    super.initState();
    animationController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 1500),
    );
    animation = Tween<double>(
      begin: 0.5,
      end: 1,
    ).animate(animationController);

    animationController.repeat(reverse: true);
  }

  @override
  void dispose() {
    animationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocListener<FirebaseAuthBloc, FirebaseAuthState>(
        listenWhen: (previous, current) {
          if (previous is AuthCheckLoading || current is AuthCheckFailed) {
            return true;
          }
          return false;
        },
        listener: (context, state) async {
          final categoryCubit = AppCubit.get(context);
          if (AppCubit.appText == null) {
            await categoryCubit.getAppText(context);
            categoryCubit.getAppCurrency(context);
          }
          if (state is! AuthCheckFailed ||
              state is! AuthCheckLoading ||
              state is! FirebaseAuthInitial ||
              state is! AuthCheckUnauthenticated) {
            // await Future.delayed(Duration(minutes: 10));

            if (mounted) {
              if (AppCubit.appText != null && AppCubit.currency != null) {
                Navigator.maybeOf(context)?.pushNamedAndRemoveUntil(
                  AppRouter.authScreen,
                  (_) => false,
                );
              } else {
                AppCubit.currency ??= 'EGP';
                try {
                  final tryAgain = await showWarningDialog(
                    context,
                    title: LanguageAr().error,
                    content: AppCubit.appTextErrorMsg ??
                        LanguageAr().connectionFailed,
                  );
                  if (tryAgain != null && tryAgain) {
                    Navigator.pushNamedAndRemoveUntil(
                      context,
                      AppRouter.splash,
                      (route) => false,
                    );
                  } else {
                    await SystemChannels.platform
                        .invokeMethod('SystemNavigator.pop');
                  }
                } catch (e) {
                  log('Error While reopen splash screen');
                }
              }
            }
          } else if (state is AuthCheckLoading ||
              state is FirebaseAuthInitial) {
            // Do Nothing...
          } else {
            Navigator.maybeOf(context)?.pushNamedAndRemoveUntil(
              AppRouter.authScreen,
              (_) => false,
            );
          }
        },
        child: Stack(
          clipBehavior: Clip.none,
          alignment: Alignment.center,
          children: [
            Center(
              child: Image.asset(
                'assets/images/splash_screen.png',
                width: double.infinity,
                height: double.infinity,
                fit: BoxFit.cover,
              ),
            ),
            Positioned.directional(
              textDirection: TextDirection.ltr,
              top: 95.h,
              child: Column(
                children: [
                  Image.asset(
                    'assets/images/logo_white.png',
                    width: 120.w,
                    height: 84.h,
                    fit: BoxFit.contain,
                  ),
                  Text(
                    'natural swedish cosmetics',
                    style: Theme.of(context).textTheme.bodyText1!.copyWith(
                          color: Colors.white,
                          fontFamily: 'Roboto',
                        ),
                  ),
                ],
              ),
            ),
            Positioned.directional(
              textDirection: TextDirection.ltr,
              bottom: 120.h,
              child: FadeTransition(
                opacity: animation,
                child: Center(
                  child: SizedBox(
                    width: 35.w,
                    height: 35.w,
                    child: const CircularProgressIndicator(color: Colors.white),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
