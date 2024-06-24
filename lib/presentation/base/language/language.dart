import 'package:get/get.dart';

class MessageKeys {
  static const String appName = "appName";
  static const String networkError = "NetworkError";
  static const String unKnown = "UnKnownError";
  static const String error = "error";

  static const String unAuthorized = "Unauthorized";
  static const String retry = "retry";
  static const String close = "close";
  static const String cancel = "cancel";
  static const String accept = "accept";
  static const String success = 'success';
  static const String alert = 'alert';
  static const String yes = 'yes';
  static const String ok = "OK";
  static const String dismiss = "dismiss";
  static const String welcome = "welcome";
  static const String viewMore = "viewMore";
  static const String noData = "noData";
  static const String noFound = "noFound";
  static const String logoutMessage = "logoutMessage";

  static const String loginButtonTitle = "loginButtonTitle";
  static const String adminPortalLogin = "adminPortalLogin";
  static const String webAdmin = "webAdmin";
  static const String password = "password";
  static const String username = "username";

}

class Language extends Translations {
  @override
  Map<String, Map<String, String>> get keys => {
        'en': {
          MessageKeys.appName: 'Amin Pet Shop',
          MessageKeys.alert: 'Attention',
          MessageKeys.networkError:
              "Please make sure you are connected to the internet",
          MessageKeys.unKnown: "Unknown error, please try again",
          MessageKeys.unAuthorized: "UnAuthorized, please re-login",
          MessageKeys.error: "Error",
          MessageKeys.cancel: "Cancel",
          MessageKeys.success: "Great",
          MessageKeys.accept: "Accept",
          MessageKeys.close: "Close",
          MessageKeys.yes: "Yes",
          MessageKeys.ok: "OK",
          MessageKeys.retry: "Retry",
          MessageKeys.dismiss: "Hide",
          MessageKeys.welcome: "Welcome!",
          MessageKeys.noData: "No data",
          MessageKeys.viewMore: "Show more",

          MessageKeys.noFound: "Not found",
          MessageKeys.logoutMessage: "Are you sure you want to logout",
          MessageKeys.loginButtonTitle: "Login",
          MessageKeys.adminPortalLogin: "Admin Portal Login",
          MessageKeys.webAdmin: "Web Admin",
          MessageKeys.password: "Password",
          MessageKeys.username: "Username",

        },
        'ar': {
          MessageKeys.appName: 'Amin Pet Shop',
          MessageKeys.alert: 'تنبيه',
          MessageKeys.networkError: "الرجاء التأكد من الإتصال بالشبكة",
          MessageKeys.unKnown: "حدث خطأ غير معروف الرجاء إعادة المحاولة",
          MessageKeys.unAuthorized: "يجب إعادة تسجيل الدخول",
          MessageKeys.error: "خطأ",
          MessageKeys.cancel: "إلغاء",
          MessageKeys.close: "إغلاق",
          MessageKeys.ok: "حسنا",
          MessageKeys.success: "نجاج",
          MessageKeys.yes: "نعم",
          MessageKeys.retry: "إعادة المحاولة",
          MessageKeys.dismiss: "إخفاء",
          MessageKeys.accept: "موافق",
          MessageKeys.welcome: "مرحبا بك",
          MessageKeys.noData: "لايوجد بيانات",
          MessageKeys.viewMore: "عرض المزيد",

          MessageKeys.noFound: "لا يوجد",
          MessageKeys.logoutMessage: "هل أنت متأكد من تسجيل الخروج؟",

          MessageKeys.loginButtonTitle: "تسجيل الدخول",
          MessageKeys.adminPortalLogin: "تسجيل دخول الإدارة",
          MessageKeys.webAdmin: "الموقع الإلكتروني",
          MessageKeys.password: "كلمة المرور",
          MessageKeys.username: "اسم المستخدم",

        }
      };
}
