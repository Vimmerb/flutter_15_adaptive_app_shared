import 'package:shared_preferences/shared_preferences.dart';

class UserPreferences {
//переменная для сохранения preferences
  static SharedPreferences? _preferences;

//ключ для текстового поля
  final _keyUserName = 'userName';
  final _keyUserEmail = 'userEmail';
  final _keyUserPhone = 'userPhone';
  final _keyUserPassword = 'userPassword';
  final _keyUserRePassword = 'userRePassword';
  final _keyRememberMe = 'rememberMe';
  final _keyAboutUser = 'aboutUser';

//инициализация preferences
  Future init() async => _preferences = await SharedPreferences.getInstance();

//задаем значения ключам
  Future setUserName(String userName) async =>
      await _preferences?.setString(_keyUserName, userName);
  Future setUserEmail(String userEmail) async =>
      await _preferences?.setString(_keyUserEmail, userEmail);
  Future setUserPhone(String userPhone) async =>
      await _preferences?.setString(_keyUserPhone, userPhone);
  Future setUserPassword(String userPassword) async =>
      await _preferences?.setString(_keyUserPassword, userPassword);
  Future setUserRePassword(String userRePassword) async =>
      await _preferences?.setString(_keyUserRePassword, userRePassword);
  Future setAboutUser(String aboutUser) async =>
      await _preferences?.setString(_keyAboutUser, aboutUser);
  Future setRememberMe(bool rememberMe) async =>
      await _preferences?.setBool(_keyRememberMe, rememberMe);

//читаем значения
  String? getUserName() => _preferences?.getString(_keyUserName);
  String? getUserEmail() => _preferences?.getString(_keyUserEmail);
  String? getUserPhone() => _preferences?.getString(_keyUserPhone);
  String? getUserPassword() => _preferences?.getString(_keyUserPassword);
  String? getUserRePassword() => _preferences?.getString(_keyUserRePassword);
  String? getAboutUser() => _preferences?.getString(_keyAboutUser);
  bool? getRememberMe() => _preferences?.getBool(_keyRememberMe);

//удаляем значения
  Future<bool>? deleteUserName() => _preferences?.remove(_keyUserName);
  Future<bool>? deleteUserEmail() => _preferences?.remove(_keyUserEmail);
  Future<bool>? deleteUserPhone() => _preferences?.remove(_keyUserPhone);
  Future<bool>? deleteUserPassword() => _preferences?.remove(_keyUserPassword);
  Future<bool>? deleteUserRePassword() =>
      _preferences?.remove(_keyUserRePassword);
  Future<bool>? deleteAboutUser() => _preferences?.remove(_keyAboutUser);
  Future<bool>? deleteRememberMe() => _preferences?.remove(_keyRememberMe);
}
