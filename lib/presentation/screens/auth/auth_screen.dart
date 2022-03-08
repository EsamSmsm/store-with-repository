import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter_animator/flutter_animator.dart';
import 'package:flutter_switch/flutter_switch.dart';
import 'package:hospital25/core/constants/constants.dart';
import 'package:hospital25/core/constants/dimensions.dart';
import 'package:hospital25/core/theme/colors.dart';
import 'package:hospital25/logic/cubit/apple/apple_cubit.dart';
import 'package:hospital25/presentation/routers/app_router.dart';
import 'package:hospital25/presentation/routers/import_helper.dart';
import 'package:hospital25/presentation/widgets/components/components.dart';
import 'package:hospital25/presentation/widgets/defaultButton/default_button.dart';
import 'package:hospital25/presentation/widgets/e_tager_icons_icons.dart';
import 'package:hospital25/presentation/widgets/textFieldWithLabel/text_field_with_label.dart';
import 'package:lottie/lottie.dart';

class AuthScreen extends StatefulWidget {
  @override
  _AuthScreenState createState() => _AuthScreenState();
}

class _AuthScreenState extends State<AuthScreen> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final _usernameOrEmailCtrl = TextEditingController();
  final _phoneCtrl = TextEditingController();
  final _usernameCtrl = TextEditingController();
  final _emailCtrl = TextEditingController();
  final _passwordCtrl = TextEditingController();
  bool _isLoginMode = true;
  bool _showPassword = false;
  bool _showConfirmPassword = false;
  bool rememberMe = true;
  bool resetPassword = false;

  @override
  void dispose() {
    _phoneCtrl.dispose();
    _usernameOrEmailCtrl.dispose();
    _usernameCtrl.dispose();
    _emailCtrl.dispose();
    _passwordCtrl.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        Navigator.pushReplacementNamed(context, AppRouter.homeLayout);
        return true;
      },
      child: Scaffold(
        backgroundColor: authBackgroundColor,
        appBar: AppBar(
          backgroundColor: Colors.transparent,
          elevation: 0,
          leadingWidth: 200,
          toolbarHeight: 50.w,
          leading: InkWell(
            onTap: () =>
                Navigator.pushReplacementNamed(context, AppRouter.homeLayout),
            child: Row(
              children: [
                SizedBox(width: hLargePadding),
                Icon(
                  Icons.arrow_back_ios,
                  size: 12,
                  color: Theme.of(context).colorScheme.secondary,
                ),
                SizedBox(width: hSmallPadding),
                Text(
                  AppCubit.appText!.back,
                  style: Theme.of(context).textTheme.bodyText2!.copyWith(
                        color: Theme.of(context).colorScheme.secondary,
                      ),
                ),
              ],
            ),
          ),
        ),
        body: SingleChildScrollView(
          child: Column(
            children: [
              SizedBox(height: vSmallPadding),
              if (_isLoginMode)
                SlideInUp(
                  key: const Key('login'),
                  preferences: const AnimationPreferences(
                    duration: Duration(milliseconds: 700),
                  ),
                  child: Center(
                    child: Image.asset(
                      'assets/images/login.png',
                      height: 0.15.sh,
                      fit: BoxFit.cover,
                    ),
                  ),
                )
              else ...[
                SlideInUp(
                  key: const Key('register'),
                  preferences: const AnimationPreferences(
                    duration: Duration(milliseconds: 700),
                  ),
                  child: Center(
                    child: Image.asset(
                      'assets/images/register.png',
                      height: 0.15.sh,
                    ),
                  ),
                ),
              ],
              SizedBox(height: vLargePadding),
              _buildAuthModeChangeRow(),
              SizedBox(height: vSmallPadding),
              Container(
                height: 0.7.sh,
                decoration: BoxDecoration(
                  color: Theme.of(context).scaffoldBackgroundColor,
                  borderRadius:
                      BorderRadius.vertical(top: Radius.circular(largeRadius)),
                ),
                child: SingleChildScrollView(
                  physics: const NeverScrollableScrollPhysics(),
                  child: Column(
                    children: [
                      SizedBox(height: vMediumMargin),
                      if (_isLoginMode)
                        Padding(
                          padding: ScreenUtil().screenWidth > 600
                              ? EdgeInsets.symmetric(horizontal: hLargePadding)
                              : EdgeInsets.zero,
                          child: buildLoginAuth(context),
                        )
                      else
                        Padding(
                          padding: ScreenUtil().screenWidth > 600
                              ? EdgeInsets.symmetric(horizontal: hLargePadding)
                              : EdgeInsets.zero,
                          child: buildRegisterAuth(context),
                        ),
                    ],
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }

  void changeAuthMode({required bool isLogin}) {
    _usernameOrEmailCtrl.clear();
    _usernameCtrl.clear();
    _emailCtrl.clear();
    _passwordCtrl.clear();
    setState(() => _isLoginMode = isLogin);
  }

  Widget buildAppleButton() {
    return BlocConsumer<AppleCubit, AppleState>(
      listener: (context, state) {
        if (state is AppleSignInSuccess) {
          if (FirebaseAuthBloc.user != null) {
            Navigator.of(context).pushNamedAndRemoveUntil(
              AppRouter.homeLayout,
              (route) => false,
            );
          }
        } else if (state is AppleSignInFailed) {
          if (state.error.contains('Cancelled')) {
            return;
          } else {
            final error = state.error.contains('Null')
                ? AppCubit.appText!.failedToLogin
                : state.error;
            customSnackBar(context: context, message: error);
          }
        }
      },
      builder: (context, state) {
        final appleCubit = AppleCubit.get(context);

        if (appleCubit.isAvailable) {
          return Row(
            children: [
              if (state is AppleSignInLoading)
                Padding(
                  padding: EdgeInsets.symmetric(vertical: vSmallPadding),
                  child: SizedBox(
                    height: 59.w,
                    width: 59.w,
                    child: CupertinoActivityIndicator(
                      radius: 18.r,
                    ),
                  ),
                )
              else
                InkWell(
                  onTap: () async => AppleCubit.get(context).appleLogin(),
                  child: Padding(
                    padding: EdgeInsets.symmetric(
                      vertical: vVerySmallMargin,
                      horizontal: hVerySmallPadding * 0.7,
                    ).copyWith(top: vSmallPadding),
                    child: Image.asset(
                      'assets/images/apple.png',
                      width: 38.w,
                      height: 38.w,
                    ),
                  ),
                ),
              SizedBox(width: hMediumPadding),
            ],
          );
        } else {
          return const Offstage();
        }
      },
    );
  }

  Widget buildFacebookButton() {
    return BlocConsumer<FacebookCubit, FacebookState>(
      listener: (context, state) {
        if (state is FacebookSuccess) {
          if (FirebaseAuthBloc.user != null) {
            Navigator.of(context).pushNamedAndRemoveUntil(
              AppRouter.homeLayout,
              (route) => false,
            );
          }
        } else if (state is FacebookFailed) {
          if (state.error.contains('Cancelled')) {
            return;
          } else {
            final error = state.error.contains('Null')
                ? AppCubit.appText!.failedToLogin
                : state.error;
            customSnackBar(context: context, message: error);
          }
        }
      },
      builder: (context, state) => state is FacebookLoading
          ? Padding(
              padding: EdgeInsets.symmetric(vertical: vSmallPadding),
              child: SizedBox(
                height: 59.w,
                width: 59.w,
                child: LottieBuilder.asset(
                  'assets/animations/facebook_loading.json',
                ),
              ),
            )
          : InkWell(
              onTap: () async => FacebookCubit.get(context).facebookLogin(),
              child: Padding(
                padding: EdgeInsets.symmetric(
                  vertical: vVerySmallMargin,
                  horizontal: hVerySmallPadding * 0.7,
                ).copyWith(top: vSmallPadding),
                child: Image.asset(
                  'assets/images/facebook.png',
                  width: 35.w,
                  height: 35.w,
                ),
              ),
            ),
    );
  }

  Widget buildGoogleButton() {
    return BlocConsumer<GoogleCubit, GoogleState>(
      listener: (context, state) {
        if (state is GoogleSuccess) {
          if (FirebaseAuthBloc.user != null) {
            Navigator.of(context).pushNamedAndRemoveUntil(
              AppRouter.homeLayout,
              (route) => false,
            );
          }
        } else if (state is GoogleFailed) {
          if (state.error == 'CANCELLED') {
            return;
          } else {
            final error = state.error.contains('Null')
                ? AppCubit.appText!.failedToLogin
                : state.error;
            customSnackBar(context: context, message: error);
          }
        } else if (state is GoogleCancelled) {}
      },
      builder: (context, state) => state is GoogleLoading
          ? Padding(
              padding: EdgeInsets.symmetric(vertical: vSmallPadding),
              child: SizedBox(
                height: 59.w,
                width: 59.w,
                child: LottieBuilder.asset(
                  'assets/animations/google_loading.json',
                ),
              ),
            )
          : InkWell(
              onTap: () async => GoogleCubit.get(context).googleLogin(),
              child: Padding(
                padding: EdgeInsets.symmetric(
                  vertical: vVerySmallMargin,
                  horizontal: hVerySmallPadding * 0.7,
                ).copyWith(top: vSmallPadding),
                child: Image.asset(
                  'assets/images/google.png',
                  width: 51.w,
                  height: 51.w,
                ),
              ),
            ),
    );
  }

  Widget buildLoginAuth(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    return BlocConsumer<LoginCubit, LoginState>(
      listener: (context, state) {
        if (state is LoginSuccess || state is LoginUnverified) {
          Navigator.pushNamedAndRemoveUntil(
            context,
            AppRouter.homeLayout,
            (route) => false,
          );
        } else if (state is LoginFailed) {
          final error = state.error.contains('Null')
              ? AppCubit.appText!.failedToLogin
              : state.error;
          customSnackBar(context: context, message: error);
          print('Error : ${state.error}');
        }
      },
      builder: (context, state) => SlideInUp(
        preferences: const AnimationPreferences(
          duration: Duration(milliseconds: 600),
        ),
        child: Column(
          children: [
            Form(
              key: _formKey,
              child: _loginForm(),
            ),
            Padding(
              padding: EdgeInsets.symmetric(
                horizontal: ScreenUtil().screenWidth > 800
                    ? hLargePadding
                    : hMediumPadding,
                vertical: vMediumPadding,
              ),
              child: Row(
                children: [
                  Text(
                    AppCubit.appText!.rememberMe,
                    style: Theme.of(context).textTheme.caption!.copyWith(
                          color: isDark ? null : Colors.black54,
                        ),
                  ),
                  const Spacer(),
                  FlutterSwitch(
                    width: 45.w,
                    height: 22.h,
                    padding: 2,
                    toggleSize: 20.w,
                    value: rememberMe,
                    activeColor: Theme.of(context).colorScheme.primary,
                    inactiveColor: Colors.grey.shade300,
                    onToggle: (value) => setState(() => rememberMe = value),
                  ),
                ],
              ),
            ),
            SizedBox(height: vMediumPadding),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: hMediumMargin),
              child: DefaultButton(
                text: AppCubit.appText!.startShopping,
                smallSize: true,
                width: 210.w,
                borderRadius: veryLargeRadius,
                isLoading: state is LoginLoading,
                onPressed: submit,
              ),
            ),
            SizedBox(height: vLargePadding),
            Text(
              AppCubit.appText!.loginBySocialMedia,
              style: Theme.of(context).textTheme.caption,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                if (Platform.isIOS) ...[
                  buildAppleButton(),
                ],
                buildGoogleButton(),
                SizedBox(width: hMediumPadding),
                buildFacebookButton(),
              ],
            ),
            InkWell(
              onTap: () {},
              child: Text(
                AppCubit.appText!.lostYourPass,
                style: Theme.of(context).textTheme.caption,
              ),
            ),
            SizedBox(height: vMediumPadding),
            Text(AppCubit.appText!.byLogin),
            SizedBox(height: vVerySmallPadding),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                InkWell(
                  onTap: () {},
                  child: Text(
                    AppCubit.appText!.termsAndConditions,
                    style: Theme.of(context)
                        .textTheme
                        .bodyText2!
                        .copyWith(decoration: TextDecoration.underline),
                  ),
                ),
                Text('  ${AppCubit.appText!.and}  '),
                InkWell(
                  onTap: () {},
                  child: Text(
                    AppCubit.appText!.privacyPolicy,
                    style: Theme.of(context)
                        .textTheme
                        .bodyText2!
                        .copyWith(decoration: TextDecoration.underline),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget buildRegisterAuth(BuildContext context) {
    return BlocConsumer<RegistrationCubit, RegistrationState>(
      listener: (context, state) {
        if (state is RegistrationSuccess) {
          Navigator.pushNamedAndRemoveUntil(
            context,
            AppRouter.homeLayout,
            (route) => false,
          );
        } else if (state is RegistrationFailed) {
          final error = state.error.contains('Null')
              ? AppCubit.appText!.failedToLogin
              : state.error;
          customSnackBar(context: context, message: error);
          print('Error : ${state.error}');
        }
      },
      builder: (context, registerState) => SlideInUp(
        preferences: const AnimationPreferences(
          duration: Duration(milliseconds: 400),
        ),
        key: const Key('Register'),
        child: Column(
          children: [
            Form(
              key: _formKey,
              child: _registerForm(),
            ),
            SizedBox(height: vMediumMargin),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: hMediumMargin),
              child: BlocConsumer<CustomerCubit, CustomerState>(
                listener: (context, state) async {},
                builder: (context, customerState) {
                  return DefaultButton(
                    text: AppCubit.appText!.startShopping,
                    smallSize: true,
                    width: 210.w,
                    borderRadius: veryLargeRadius,
                    isLoading: registerState is RegistrationLoading ||
                        customerState is VerifyPhoneLoading,
                    onPressed: submit,
                  );
                },
              ),
            ),
            SizedBox(height: vMediumPadding),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text('${AppCubit.appText!.haveAccount} '),
                InkWell(
                  onTap: () => changeAuthMode(isLogin: true),
                  child: Text(
                    AppCubit.appText!.login,
                    style: Theme.of(context).textTheme.bodyText2!.copyWith(
                          color: Theme.of(context).colorScheme.primary,
                        ),
                  ),
                )
              ],
            ),
            SizedBox(height: vLargePadding),
            Text(AppCubit.appText!.byRegister),
            SizedBox(height: vVerySmallPadding),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                InkWell(
                  onTap: () {},
                  child: Text(
                    AppCubit.appText!.termsAndConditions,
                    style: Theme.of(context)
                        .textTheme
                        .bodyText2!
                        .copyWith(decoration: TextDecoration.underline),
                  ),
                ),
                Text('  ${AppCubit.appText!.and}  '),
                InkWell(
                  onTap: () {},
                  child: Text(
                    AppCubit.appText!.privacyPolicy,
                    style: Theme.of(context)
                        .textTheme
                        .bodyText2!
                        .copyWith(decoration: TextDecoration.underline),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _loginForm() {
    return Padding(
      padding: EdgeInsets.symmetric(
        horizontal:
            ScreenUtil().screenWidth > 800 ? hLargePadding : hMediumPadding,
      ),
      child: Column(
        children: [
          FilledTextFieldWithLabel(
            key: const Key('phone'),
            labelText: AppCubit.appText!.phone,
            labelColor: Theme.of(context).colorScheme.primary,
            hintText: AppCubit.appText!.phone,
            controller: _phoneCtrl,
            keyboardType: TextInputType.phone,
            textDirection: TextDirection.ltr,
            suffixIcon: FittedBox(
              fit: BoxFit.scaleDown,
              child: Icon(
                ETagerIcons.phone,
                size: 18.w,
              ),
            ),
            validator: (value) {
              if (value!.isEmpty) {
                return AppCubit.appText!.filedIsRequired;
              } else if (!phoneValidationRegExp.hasMatch(value)) {
                return AppCubit.appText!.enterValidNumber;
              }
              return null;
            },
          ),
          SizedBox(height: vSmallMargin),
          FilledTextFieldWithLabel(
            key: const Key('password'),
            labelText: AppCubit.appText!.pass,
            labelColor: Theme.of(context).colorScheme.primary,
            controller: _passwordCtrl,
            obscureText: !_showPassword,
            textDirection: TextDirection.ltr,
            inputAction: TextInputAction.done,
            suffixIcon: InkWell(
              onTap: () => setState(() => _showPassword = !_showPassword),
              canRequestFocus: false,
              child: Icon(
                _showPassword ? ETagerIcons.eye_slash : ETagerIcons.eye,
                size: 18,
              ),
            ),
            validator: (value) {
              if (value!.isEmpty) {
                return AppCubit.appText!.pleaseEnterPass;
              }
              if (value.length < 6) {
                return AppCubit.appText!.passShort;
              }
              return null;
            },
          ),
        ],
      ),
    );
  }

  Padding _registerForm() {
    return Padding(
      padding: EdgeInsets.symmetric(
        horizontal:
            ScreenUtil().screenWidth > 800 ? hLargePadding : hMediumPadding,
      ),
      child: Column(
        children: [
          FilledTextFieldWithLabel(
            key: const Key('phone'),
            labelText: AppCubit.appText!.phone,
            labelColor: Theme.of(context).colorScheme.primary,
            hintText: AppCubit.appText!.phone,
            controller: _phoneCtrl,
            keyboardType: TextInputType.phone,
            textDirection: TextDirection.ltr,
            suffixIcon: FittedBox(
              fit: BoxFit.scaleDown,
              child: Icon(
                ETagerIcons.phone,
                size: 18.w,
              ),
            ),
            validator: (value) {
              if (value!.isEmpty) {
                return AppCubit.appText!.filedIsRequired;
              } else if (!phoneValidationRegExp.hasMatch(value)) {
                return AppCubit.appText!.enterValidNumber;
              }
              return null;
            },
          ),
          SizedBox(height: vSmallMargin),
          FilledTextFieldWithLabel(
            key: const Key('password'),
            labelText: AppCubit.appText!.pass,
            labelColor: Theme.of(context).colorScheme.primary,
            textDirection: TextDirection.ltr,
            controller: _passwordCtrl,
            obscureText: !_showPassword,
            suffixIcon: InkWell(
              onTap: () => setState(() => _showPassword = !_showPassword),
              canRequestFocus: false,
              child: Icon(
                _showPassword ? ETagerIcons.eye_slash : ETagerIcons.eye,
                size: 18,
              ),
            ),
            validator: (value) {
              if (value!.isEmpty) {
                return AppCubit.appText!.pleaseEnterPass;
              }
              if (value.length < 6) {
                return AppCubit.appText!.passShort;
              }
              return null;
            },
          ),
          SizedBox(height: vSmallMargin),
          FilledTextFieldWithLabel(
            key: const Key('confirm password'),
            labelText: AppCubit.appText!.confirmPass,
            labelColor: Theme.of(context).colorScheme.primary,
            textDirection: TextDirection.ltr,
            obscureText: !_showConfirmPassword,
            inputAction: TextInputAction.done,
            suffixIcon: FittedBox(
              fit: BoxFit.scaleDown,
              child: InkWell(
                onTap: () => setState(
                  () => _showConfirmPassword = !_showConfirmPassword,
                ),
                canRequestFocus: false,
                radius: 5,
                borderRadius: BorderRadius.circular(largeRadius),
                child: Icon(
                  _showConfirmPassword
                      ? ETagerIcons.eye_slash
                      : ETagerIcons.eye,
                  size: 18,
                ),
              ),
            ),
            validator: (value) {
              if (value != _passwordCtrl.text) {
                return AppCubit.appText!.passNotMatch;
              }
              return null;
            },
          ),
        ],
      ),
    );
  }

  Row _buildAuthModeChangeRow() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        AuthModeItem(
          title: AppCubit.appText!.login,
          showIndicator: _isLoginMode,
          onTap: () => changeAuthMode(isLogin: true),
        ),
        AuthModeItem(
          title: AppCubit.appText!.register,
          showIndicator: !_isLoginMode,
          onTap: () => changeAuthMode(isLogin: false),
        ),
      ],
    );
  }

  Future<void> submit() async {
    if (_formKey.currentState != null && _formKey.currentState!.validate()) {
      if (_isLoginMode) {
        final phone = _phoneCtrl.text.trim();
        await LoginCubit.get(context).login(
          context,
          phone: '$phone@hospital25.com',
          password: _passwordCtrl.text,
        );
      } else {
        await RegistrationCubit.get(context).registerUser(
          context,
          phone: _phoneCtrl.text,
          password: _passwordCtrl.text,
        );
      }
    }
  }
}

class AuthModeItem extends StatelessWidget {
  const AuthModeItem({
    Key? key,
    required this.onTap,
    required this.title,
    required this.showIndicator,
  }) : super(key: key);
  final VoidCallback onTap;
  final String title;
  final bool showIndicator;

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: InkWell(
        onTap: onTap,
        child: Center(
          child: Column(
            children: [
              SizedBox(height: vMediumPadding),
              Text(
                title,
                style: Theme.of(context)
                    .textTheme
                    .headline4!
                    .copyWith(fontWeight: FontWeight.normal, height: 0.5),
              ),
              SizedBox(height: vSmallPadding),
              AnimatedContainer(
                duration: const Duration(milliseconds: 600),
                height: 7.h,
                width: showIndicator ? 35 : 0,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(smallRadius),
                  color: Theme.of(context).colorScheme.primary,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
