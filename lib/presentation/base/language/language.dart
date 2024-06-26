import 'package:get/get.dart';

class MessageKeys {
  static const String appName = "appName";
  static const String networkError = "NetworkError";
  static const String unKnown = "UnKnownError";
  static const String error = "error";
  static const String errorTitle = "errorTitle";
  static const String errorMessage = "errorMessage";
  static const String unAuthorized = "Unauthorized";
  static const String retry = "retry";
  static const String close = "close";
  static const String cancel = "cancel";
  static const String accept = "accept";
  static const String success = 'success';
  static const String alert = 'alert';
  static const String yes = 'yes';
  static const String no = 'no';
  static const String ok = "OK";
  static const String dismiss = "dismiss";
  static const String welcome = "welcome";
  static const String viewMore = "viewMore";
  static const String noData = "noData";
  static const String noFound = "noFound";
  static const String logoutButtonTitle = "logoutButtonTitle";

  static const String loginButtonTitle = "loginButtonTitle";
  static const String adminPortalLogin = "adminPortalLogin";
  static const String webAdmin = "webAdmin";
  static const String password = "password";
  static const String username = "username";

  static const String dashboardTitle = "dashboardTitle";
  static const String productsTitle = "productsTitle";
  static const String categoriesTitle = "categoriesTitle";
  static const String categoryDetailTitle = "categoryDetailTitle";
  static const String addCategoryTitle = "addCategoryTitle";
  static const String addProductTitle = "addProductTitle";
  static const String productDetailTitle = "productDetail";

  static const String dashboardTotalOrders = "dashboardTotalOrders";
  static const String dashboardTodayOrders = "todayOrders";
  static const String dashboardTotalUsers = "totalUsers";

  static const String recentOrders = "recentOrders";


  static const String noColumnTitle = "noColumnTitle";
  static const String nameColumnTitle = "nameColumnTitle";
  static const String dateColumnTitle = "dateColumnTitle";
  static const String priceColumnTitle = "priceColumnTitle";
  static const String actionsColumnTitle = "actionsColumnTitle";
  static const String quantityColumnTitle = "quantityColumnTitle";
  static const String photoColumnTitle = "photoColumnTitle";
  static const String isAvailableColumnTitle = "isAvailableColumnTitle";

  static const String categoryNameTitle = "categoryNameTitle";

  static const String addButtonTitle  = "addButtonTitle";
  static const String editButtonTitle = "editButtonTitle";
  static const String deleteButtonTitle = "deleteButtonTitle";
  static const String backButtonTitle = "backButtonTitle";
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
          MessageKeys.errorMessage: "Try again later",
          MessageKeys.errorTitle: "Failed to load page",
          MessageKeys.cancel: "Cancel",
          MessageKeys.success: "Great",
          MessageKeys.accept: "Accept",
          MessageKeys.close: "Close",
          MessageKeys.yes: "Yes",
          MessageKeys.no: "No",
          MessageKeys.ok: "OK",
          MessageKeys.retry: "Retry",
          MessageKeys.dismiss: "Hide",
          MessageKeys.welcome: "Welcome!",
          MessageKeys.noData: "No data",
          MessageKeys.viewMore: "Show more",
          MessageKeys.noFound: "Not found",
          MessageKeys.logoutButtonTitle: "Logout",
          MessageKeys.loginButtonTitle: "Login",
          MessageKeys.adminPortalLogin: "Admin Portal Login",
          MessageKeys.webAdmin: "Web Admin",
          MessageKeys.password: "Password",
          MessageKeys.username: "Username",
          MessageKeys.dashboardTitle: "Dashboard",
          MessageKeys.productsTitle: "Products",
          MessageKeys.categoryDetailTitle: "Category Detail",
          MessageKeys.addCategoryTitle: "Add Category",
          MessageKeys.addProductTitle: "Add Product",
          MessageKeys.productDetailTitle: "Product Detail",

          MessageKeys.dashboardTotalOrders: "Total Orders",
          MessageKeys.dashboardTodayOrders: "Today Orders",
          MessageKeys.dashboardTotalUsers: "Total Users",
          MessageKeys.recentOrders: "Recent Orders",

          MessageKeys.categoriesTitle: "Categories",
          MessageKeys.noColumnTitle: "No.",
          MessageKeys.dateColumnTitle: "Date",
          MessageKeys.priceColumnTitle: "Price",
          MessageKeys.nameColumnTitle: "Name",
          MessageKeys.actionsColumnTitle: "Actions",
          MessageKeys.quantityColumnTitle: "Quantity",
          MessageKeys.isAvailableColumnTitle: "Is Available",
          MessageKeys.photoColumnTitle: "Photo",

          MessageKeys.categoryNameTitle: "Category Name",

          MessageKeys.editButtonTitle: "Edit",
          MessageKeys.deleteButtonTitle: "Delete",
          MessageKeys.addButtonTitle: "Add",
          MessageKeys.backButtonTitle: "Back",
        },
        'ar': {
          MessageKeys.appName: 'Amin Pet Shop',
          MessageKeys.alert: 'تنبيه',
          MessageKeys.networkError: "الرجاء التأكد من الإتصال بالشبكة",
          MessageKeys.unKnown: "حدث خطأ غير معروف الرجاء إعادة المحاولة",
          MessageKeys.unAuthorized: "يجب إعادة تسجيل الدخول",
          MessageKeys.error: "خطأ",
          MessageKeys.errorMessage: "حاول مرة أخرى في وقت لاحق",
          MessageKeys.errorTitle: "فشل تحميل الصفحة",
          MessageKeys.cancel: "إلغاء",
          MessageKeys.close: "إغلاق",
          MessageKeys.ok: "حسنا",
          MessageKeys.success: "نجاج",
          MessageKeys.yes: "نعم",
          MessageKeys.no: "لا",
          MessageKeys.retry: "إعادة المحاولة",
          MessageKeys.dismiss: "إخفاء",
          MessageKeys.accept: "موافق",
          MessageKeys.welcome: "مرحبا بك",
          MessageKeys.noData: "لايوجد بيانات",
          MessageKeys.viewMore: "عرض المزيد",
          MessageKeys.noFound: "لا يوجد",
          MessageKeys.logoutButtonTitle: "تسجيل الخروج",
          MessageKeys.loginButtonTitle: "تسجيل الدخول",
          MessageKeys.adminPortalLogin: "تسجيل دخول الإدارة",
          MessageKeys.webAdmin: "الموقع الإلكتروني",
          MessageKeys.password: "كلمة المرور",
          MessageKeys.username: "اسم المستخدم",
          MessageKeys.dashboardTitle: "لوحة التحكم",
          MessageKeys.productsTitle: "المنتجات",
          MessageKeys.categoriesTitle: "الأقسام",
          MessageKeys.productDetailTitle: "تفاصيل المنتج",
          MessageKeys.categoryDetailTitle: "تفاصيل القسم",
          MessageKeys.addCategoryTitle: "إضافة قسم",
          MessageKeys.addProductTitle: "إضافة منتج",
          MessageKeys.dashboardTotalOrders: "إجمالي الطلبات",
          MessageKeys.dashboardTodayOrders: "طلبات اليوم",
          MessageKeys.dashboardTotalUsers: "إجمالي المستخدمين",
          MessageKeys.recentOrders: "الطلبات الأخيرة",
          MessageKeys.noColumnTitle: "رقم",
          MessageKeys.dateColumnTitle: "تاريخ",
          MessageKeys.priceColumnTitle: "السعر",
          MessageKeys.nameColumnTitle: "الاسم",
          MessageKeys.actionsColumnTitle: "العمليات",
          MessageKeys.quantityColumnTitle: "الكمية",
          MessageKeys.isAvailableColumnTitle: "متوفر",
          MessageKeys.photoColumnTitle: "الصورة",

          MessageKeys.categoryNameTitle: "اسم القسم",

          MessageKeys.editButtonTitle: "تعديل",
          MessageKeys.deleteButtonTitle: "حذف",
          MessageKeys.addButtonTitle: "إضافة",
          MessageKeys.backButtonTitle: "رجوع",
        }
      };
}
