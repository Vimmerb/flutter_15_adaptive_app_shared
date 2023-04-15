import 'package:flutter/material.dart';
import 'package:flutter_9/screens/register_screen.dart';
import 'package:flutter_9/screens/profile_screen.dart';
import 'package:flutter_9/shared_preferences.dart';
import 'package:sizer/sizer.dart';

class LoginWidget extends StatefulWidget {
  const LoginWidget({Key? key}) : super(key: key);

  @override
  State<LoginWidget> createState() => _LoginWidgetState();
}

class _LoginWidgetState extends State<LoginWidget> {
  late String _email;
  late String _password;
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  bool _showPassword = false;
  bool _isPressed = false;
  bool _isChecked = false;

  // автоматическоe заполнениe сохраненных данных пользователя
  @override
  void initState() {
    super.initState();
    _email = UserPreferences().getUserEmail() ?? '';
    _password = UserPreferences().getUserPassword() ?? '';
    final rememberMe = UserPreferences().getRememberMe();
    setState(() {
      _isChecked = rememberMe ?? false;
    });
  }

  bool _checkData(String email, String password) {
    final savedEmail = UserPreferences().getUserEmail();
    final savedPassword = UserPreferences().getUserPassword();
    return email == savedEmail && password == savedPassword;
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
        padding: EdgeInsets.only(
          right: 40.w,
          left: 40.w,
        ),
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
                buildEmailText(),
                buildEmailField(),
                const SizedBox(
                  height: 20,
                ),
                buildPasswordText(),
                buildPasswordField(),
                const SizedBox(
                  height: 10,
                ),
                buildRememberCheckbox(),
                const SizedBox(
                  height: 20,
                ),
                buildElevatedButtonLogin(),
                const SizedBox(
                  height: 30,
                ),
                buildNewAccountText(),
              ],
            ),
          ),
        ),
      );

  portraitLayout() => Container(
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
                buildEmailText(),
                buildEmailField(),
                const SizedBox(
                  height: 25,
                ),
                buildPasswordText(),
                buildPasswordField(),
                const SizedBox(
                  height: 25,
                ),
                buildRememberCheckbox(),
                const SizedBox(
                  height: 50,
                ),
                buildElevatedButtonLogin(),
                const SizedBox(
                  height: 80,
                ),
                buildNewAccountText(),
              ],
            ),
          ),
        ),
      );

  Widget buildEmailText() {
    return const Text(
      'Email',
      style: TextStyle(
        fontFamily: 'Inter-SemiBold',
        fontSize: 16,
        color: Color(0xFF000000),
      ),
    );
  }

  Widget buildEmailField() {
    return TextFormField(
      initialValue: _email, //хранит значение, сохранненное в SharedPreferences
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

  Widget buildPasswordText() {
    return const Text(
      'Password',
      style: TextStyle(
        fontFamily: 'Inter-SemiBold',
        fontSize: 16,
        color: Color(0xFF000000),
      ),
    );
  }

  Widget buildPasswordField() {
    return TextFormField(
      initialValue: _password,
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
          return 'Enter a password';
        }
        if (_password != null && value != _password) {
          return 'Incorrect password';
        }
        return null;
      },
      onChanged: (value) => setState(() => _password = value),
    );
  }

  Widget buildRememberCheckbox() {
    return Row(
      children: [
        Checkbox(
          value: _isChecked,
          onChanged: ((value) {
            setState(() {
              _isChecked = value!;
            });
            UserPreferences().setRememberMe(_isChecked);
          }),
        ),
        const Text(
          'Remember me',
          style: TextStyle(
            fontFamily: 'Inter-SemiBold',
            fontSize: 16,
            color: Color(0xFF000000),
          ),
        ),
      ],
    );
  }

  Widget buildElevatedButtonLogin() {
    return Center(
      child: ElevatedButton(
        onPressed: () async {
          if (_formKey.currentState!.validate()) {
            if (_checkData(_email, _password)) {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) {
                  return const ProfileWidget();
                }),
              );
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(
                  content: Text('Successful authorization'),
                  backgroundColor: Color(0xFF17E444),
                ),
              );
            } else {
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(
                  content: Text('Incorrect email or password'),
                  backgroundColor: Colors.red,
                ),
              );
            }
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
          'Login',
          style: TextStyle(
            fontFamily: 'Inter-SemiBold',
            color: Color(0xFF1A1717),
            fontSize: 16,
          ),
        ),
      ),
    );
  }

  Widget buildNewAccountText() {
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
            return const RegisterWidget();
          }),
        );
      },
      child: Center(
        child: Text(
          'CREATE NEW ACCOUNT',
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
