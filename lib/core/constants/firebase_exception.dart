import 'package:hospital25/core/languages/language_ar.dart';
import 'package:hospital25/core/languages/languages.dart';
import 'package:hospital25/presentation/routers/import_helper.dart';

String? translateFirebaseMessage(BuildContext context,
    {required String code, required String? message}) {
  final isArabic = Languages.of(context) is LanguageAr;
  if (code == 'email-already-in-use') {
    return isArabic
        ? 'عنوان البريد الإلكتروني قيد الاستخدام بالفعل من قبل حساب آخر.'
        : message;
  } else if (code == 'operation-not-allowed') {
    return isArabic ? 'العملية غير مسموح بها' : message ?? code;
  } else if (code == 'invalid-email') {
    return isArabic ? 'بريد إلكتروني خاطئ' : message ?? code;
  } else if (code == 'weak-password') {
    return isArabic ? 'كلمة مرور ضعيفة' : message ?? code;
  } else if (code == 'user-disabled') {
    return isArabic ? 'تعطيل المستخدم' : message ?? code;
  } else if (code == 'user-not-found') {
    return isArabic
        ? 'لا يوجد سجل مستخدم مطابق لهذه البيانات. ربما تم حذف المستخدم.'
        : message ?? code;
  } else if (code == 'wrong-password') {
    return isArabic
        ? 'كلمة المرور غير صالحة أو ليس لدى المستخدم كلمة مرور.'
        : message ?? code;
  } else if (code == 'invalid-verification-code') {
    return isArabic ? 'رمز التحقق غير صالح' : message ?? code;
  } else if (code == 'invalid-verification-id') {
    return isArabic ? 'معرف التحقق غير صالح' : message ?? code;
  } else if (code == 'invalid-credential') {
    return isArabic ? 'بيانات المصادقة غير صالحة' : message ?? code;
  } else if (code == 'auth/invalid-email') {
    return isArabic ? 'المصادقة / البريد الإلكتروني غير صالح' : message ?? code;
  } else if (code == 'auth/user-not-found') {
    return isArabic ? 'المصادقة / المستخدم غير موجود' : message ?? code;
  }
}
