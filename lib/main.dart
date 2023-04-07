import 'package:flutter/material.dart';
import 'package:flutter_9/screens/login_screen.dart';
import 'package:flutter_9/screens/profile_screen.dart';
import 'package:flutter_9/shared_preferences.dart';
import 'package:sizer/sizer.dart';

Future main() async {
  WidgetsFlutterBinding.ensureInitialized();
  // Инициализация UserPreferences
  await UserPreferences().init();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Sizer(
      builder: (_, __, ___) {
        return MaterialApp(
          debugShowCheckedModeBanner: false,
          title: 'My account',
          theme: ThemeData(primarySwatch: Colors.grey),
          home: const MyHomePage(),
        );
      },
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key}) : super(key: key);

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  // переменная содержит инфу о наличии данных в SharedPreferences
  bool _hasData = true;

  @override
  void initState() {
    super.initState();
    _init();
  }

// ждем результат выполнения функции hasData,
//чтобы получить значения данных пользователя и проверить их
  Future<void> _init() async {
    _hasData = await hasData(_hasData);
    setState(() {});
  }

// функция hasData() получает значения данных пользователя,
// (переменной rememberMe)
// если хотя бы одно из значений null --> данных нет -->
// возвращает _hasData = false
  Future<bool> hasData(bool hasData) async {
    final rememberMe = UserPreferences().getRememberMe();
    // final userName = UserPreferences().getUserName();
    // final userEmail = UserPreferences().getUserEmail();
    // final userPassword = UserPreferences().getUserPassword();
    // final userRePassword = UserPreferences().getUserRePassword();
    return rememberMe ?? false;
    // &&  userName != null &&
    //     userEmail != null &&
    //     userPassword != null &&
    //     userRePassword != null;
  }

  // если _hasData = true, показываем экран профайла,
  // если _hasData = false, показываем экран авторизации
  @override
  Widget build(BuildContext context) {
    return _hasData && UserPreferences().getRememberMe() == true
        ? const ProfileWidget()
        : const LoginWidget();
  }
}
