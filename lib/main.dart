import 'package:ecommerce_admin/presentation/base/controller/app_settings_controller.dart';
import 'package:ecommerce_admin/presentation/base/controller/user_controller.dart';
import 'package:ecommerce_admin/presentation/base/language/language.dart';
import 'package:ecommerce_admin/presentation/base/style/theme.dart';
import 'package:ecommerce_admin/presentation/base/utils/app_bindings.dart';
import 'package:ecommerce_admin/presentation/home/screen/home_screen.dart';
import 'package:ecommerce_admin/presentation/login/screen/login_screen.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';


void main() async {

  WidgetsFlutterBinding.ensureInitialized();

  await AppBindings().dependencies();

  await Firebase.initializeApp(
    options: const FirebaseOptions(
        apiKey: "AIzaSyAt4d2f85aYI0Fpn4dQrvxg1o_7SwJJ9RU",
        authDomain: "ecommerce-57aeb.firebaseapp.com",
        projectId: "ecommerce-57aeb",
        databaseURL: "https://ecommerce-57aeb-default-rtdb.firebaseio.com/",
        storageBucket: "ecommerce-57aeb.appspot.com",
        messagingSenderId: "681909148680",
        appId: "1:681909148680:web:cff41319f8840fed44c5bd"),
  );

  SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp,
  ]).then((value) {
    runApp(const MyApp());
  });
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<StatefulWidget> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  late Locale _locale;
  late final AppSettingsController _settingsController;
  late final UserController _userController;

  void setLocale(Locale locale) {
    setState(() {
      _locale = locale;
    });
  }

  @override
  void initState() {
    super.initState();
    _settingsController = Get.find();
    _userController = Get.find();
    _userController.getSavedUser();
    setLocale(Locale(_settingsController.getLanguage()));
  }

  @override
  Widget build(BuildContext context) {
    var theme =
        CustomTheme.lightTheme(_settingsController.getLanguage() == "ar");
    return GetMaterialApp(
      locale: _locale,
      debugShowCheckedModeBanner: false,
      theme: theme,
      darkTheme: theme,
      home: GetX<UserController>(
          init: _userController, //here
          builder: (controller) {
            Widget widget = Container();
            if (_userController.userState.value == null) {
              widget = const LoginScreen();
            } else {
              widget = const HomeScreen();
            }
            return widget;
          }),
      translations: Language(),
    );
  }
}
