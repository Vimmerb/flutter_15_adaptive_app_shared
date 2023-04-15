import 'package:flutter/material.dart';
import 'package:flutter_9/screens/login_screen.dart';
import 'package:flutter_9/screens/profile_screen.dart';
import 'package:flutter_9/shared_preferences.dart';
import 'package:sizer/sizer.dart';

class RegisterWidget extends StatefulWidget {
  const RegisterWidget({Key? key}) : super(key: key);

  @override
  State<RegisterWidget> createState() => _RegisterWidgetState();
}

class _RegisterWidgetState extends State<RegisterWidget> {
  String? _name;
  String? _email;
  String? _phone;
  String? _password;
  String? _rePassword;
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  bool _showPassword =
      false; // переменная для хранения состояния видимости пароля в форме регистрации
  bool _isPressed = false;

  //читаем данные пользователя
  @override
  void initState() {
    super.initState();
    // _name = UserPreferences().getUserName() ?? '';
    // _email = UserPreferences().getUserEmail() ?? '';
    // _phone = UserPreferences().getUserPhone() ?? '';
    // _password = UserPreferences().getUserPassword() ?? '';
    // _rePassword = UserPreferences().getUserRePassword() ?? '';
  }

  @override
  Widget build(BuildContext context) => LayoutBuilder(
        builder: (_, constraints) => SafeArea(
          child: Scaffold(
            body: SizerUtil.orientation == Orientation.portrait
                ? portraitLayout()
                : landscapeLayout(),
          ),
        ),
      );

  Widget landscapeLayout() => Container(
        padding:
            EdgeInsets.only(right: 40.w, left: 40.w, top: 3.h, bottom: 3.h),
        decoration: const BoxDecoration(
          color: Color(0xFFF5F5F5),
        ),
        alignment: Alignment.center,
        child: Form(
          key: _formKey,
          child: SingleChildScrollView(
            child: Column(
              //mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                buildNameText(),
                buildNameField(),
                const SizedBox(
                  height: 15,
                ),
                buildEmailText(),
                buildEmailField(),
                const SizedBox(
                  height: 15,
                ),
                buildPhoneText(),
                buildPhoneField(),
                const SizedBox(
                  height: 15,
                ),
                buildPasswordText(),
                buildPasswordField(),
                const SizedBox(
                  height: 15,
                ),
                buildRePasswordText(),
                buildRePasswordField(),
                const SizedBox(
                  height: 25,
                ),
                buildElevatedButtonRegister(),
                const SizedBox(
                  height: 30,
                ),
                buildOldAccountText(),
              ],
            ),
          ),
        ),
      );

  Widget portraitLayout() => Container(
        padding: const EdgeInsets.all(30),
        decoration: const BoxDecoration(
          color: Color(0xFFF5F5F5),
        ),
        alignment: Alignment.center,
        child: Form(
          key: _formKey,
          child: SingleChildScrollView(
            child: Column(
              //mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                buildNameText(),
                buildNameField(),
                const SizedBox(
                  height: 15,
                ),
                buildEmailText(),
                buildEmailField(),
                const SizedBox(
                  height: 15,
                ),
                buildPhoneText(),
                buildPhoneField(),
                const SizedBox(
                  height: 15,
                ),
                buildPasswordText(),
                buildPasswordField(),
                const SizedBox(
                  height: 15,
                ),
                buildRePasswordText(),
                buildRePasswordField(),
                const SizedBox(
                  height: 40,
                ),
                buildElevatedButtonRegister(),
                const SizedBox(
                  height: 50,
                ),
                buildOldAccountText(),
              ],
            ),
          ),
        ),
      );

  Widget buildNameText() {
    return const Text(
      'Your name*',
      style: TextStyle(
        fontFamily: 'Inter-SemiBold',
        fontSize: 16,
        color: Color(0xFF000000),
      ),
    );
  }

  Widget buildNameField() {
    return TextFormField(
      initialValue: _name,
      style: TextStyle(
        fontFamily: 'Inter-SemiBold',
        fontSize: 16,
        color: Color(0xFF000000),
      ),
      decoration: const InputDecoration(
        border: InputBorder.none,
        fillColor: Color(0xFFD9D9D9),
        filled: true,
      ),
      keyboardType: TextInputType.name,
      validator: (value) {
        if (value!.isEmpty) {
          return 'Enter your name';
        }
        return null;
      },
      onChanged: (value) => setState(() => _name = value),
    );
  }

  Widget buildEmailText() {
    return const Text(
      'Email*',
      style: TextStyle(
        fontFamily: 'Inter-SemiBold',
        fontSize: 16,
        color: Color(0xFF000000),
      ),
    );
  }

  Widget buildEmailField() {
    return TextFormField(
      initialValue: _email,
      style: TextStyle(
        fontFamily: 'Inter-SemiBold',
        fontSize: 16,
        color: Color(0xFF000000),
      ),
      decoration: const InputDecoration(
        border: InputBorder.none,
        fillColor: Color(0xFFD9D9D9),
        filled: true,
      ),
      keyboardType: TextInputType.emailAddress,
      validator: (value) {
        if (value!.isEmpty) {
          return 'Enter your email address';
        }
        if (!value.contains('@') || !value.contains('.')) {
          return 'Enter a valid email address';
        }
        return null;
      },
      onChanged: (value) => setState(() => _email = value),
    );
  }

  Widget buildPhoneText() {
    return const Text(
      'Phone number*',
      style: TextStyle(
        fontFamily: 'Inter-SemiBold',
        fontSize: 16,
        color: Color(0xFF000000),
      ),
    );
  }

  Widget buildPhoneField() {
    return TextFormField(
      initialValue: _phone,
      style: TextStyle(
        fontFamily: 'Inter-SemiBold',
        fontSize: 16,
        color: Color(0xFF000000),
      ),
      decoration: const InputDecoration(
        border: InputBorder.none,
        fillColor: Color(0xFFD9D9D9),
        filled: true,
      ),
      keyboardType: TextInputType.phone,
      validator: (value) {
        if (value!.isEmpty) {
          return 'Enter your phone number';
        }
        final phoneRegExp = RegExp(r'^\d+$');
        if (!phoneRegExp.hasMatch(value)) {
          return 'Enter a valid phone number';
        }
        return null;
      },
      onChanged: (value) => setState(() => _phone = value),
    );
  }

  Widget buildPasswordText() {
    return const Text(
      'Password*',
      style: TextStyle(
        fontFamily: 'Inter-SemiBold',
        fontSize: 16,
        color: Color(0xFF000000),
      ),
    );
  }

  Widget buildPasswordField() {
    return TextFormField(
      initialValue:
          _password, //хранит значение, сохранненное в SharedPreferences
      style: TextStyle(
        fontFamily: 'Inter-SemiBold',
        fontSize: 16,
        color: Color(0xFF000000),
      ),
      decoration: InputDecoration(
        border: InputBorder.none,
        fillColor: const Color(0xFFD9D9D9),
        filled: true,
        suffixIcon: IconButton(
          icon: Icon(
            _showPassword ? Icons.visibility : Icons.visibility_off,
          ), //изменение отображения пароля в текстовом поле
          onPressed: () {
            setState(() {
              _showPassword = !_showPassword;
            });
          },
        ),
      ),
      obscureText: !_showPassword,
      // maxLength: 10,
      validator: (value) {
        if (value!.isEmpty) {
          return 'Enter a password';
        }
        if (value.length < 6) {
          return 'Password must be at least 6 characters';
        }
        return null;
      },
      onChanged: (value) => setState(() => _password = value),
    );
  }

  Widget buildRePasswordText() {
    return const Text(
      'Repeat password*',
      style: TextStyle(
        fontFamily: 'Inter-SemiBold',
        fontSize: 16,
        color: Color(0xFF000000),
      ),
    );
  }

  Widget buildRePasswordField() {
    return TextFormField(
      initialValue: _rePassword,
      style: TextStyle(
        fontFamily: 'Inter-SemiBold',
        fontSize: 16,
        color: Color(0xFF000000),
      ),
      decoration: InputDecoration(
        border: InputBorder.none,
        fillColor: const Color(0xFFD9D9D9),
        filled: true,
        suffixIcon: IconButton(
          icon: Icon(
            _showPassword ? Icons.visibility : Icons.visibility_off,
          ),
          onPressed: () {
            setState(() {
              _showPassword = !_showPassword;
            });
          },
        ),
      ),
      obscureText: !_showPassword,
      validator: (value) {
        if (value!.isEmpty) {
          return 'Repeat the password';
        }
        if (_password != null && value != _password) {
          return 'Incorrect password';
        }
        return null;
      },
      onChanged: (value) => setState(() => _rePassword = value),
    );
  }

  Widget buildElevatedButtonRegister() {
    return Center(
      child: ElevatedButton(
        onPressed: () async {
          if (_formKey.currentState!.validate()) {
            await UserPreferences().setUserName(_name!);
            await UserPreferences().setUserEmail(_email!);
            await UserPreferences().setUserPhone(_phone!);
            await UserPreferences().setUserPassword(_password!);
            await UserPreferences().setUserRePassword(_rePassword!);
            // если форма прошла валидацию,
            //данные пользователя сохраняются в SharedPreferences
            // ignore: use_build_context_synchronously
            ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(
                content: Text('Registration completed'),
                backgroundColor: Color(0xFF17E444),
              ),
            ); //всплывающее сообщение пользователю: регистрация завершена
            //Navigator.pushNamed(context, '/weatherResultScreen');
            // ignore: use_build_context_synchronously
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) {
                return const ProfileWidget();
              }),
            );
          }
        },
        style: ElevatedButton.styleFrom(
          backgroundColor: const Color(0xFF17E444),
          fixedSize: const Size(184, 40),
          shape: const RoundedRectangleBorder(
            borderRadius: BorderRadius.zero,
          ),
        ),
        child: const Text(
          'Register',
          style: TextStyle(
            fontFamily: 'Inter-SemiBold',
            color: Color(0xFF1A1717),
            fontSize: 16,
          ),
        ),
      ),
    );
  }

  Widget buildOldAccountText() {
    return GestureDetector(
      onTap: () async {
        setState(() {
          _isPressed = true;
        });
        await Future.delayed(const Duration(milliseconds: 50));
        // ignore: use_build_context_synchronously
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) {
            return const LoginWidget();
          }),
        );
      },
      child: Center(
        child: Text(
          'ALREADY REGISTERED',
          style: TextStyle(
            fontFamily: 'Inter-SemiBold',
            fontSize: 16,
            color:
                _isPressed ? const Color(0xFF17E444) : const Color(0xFF000000),
          ),
        ),
      ),
    );
  }
}
