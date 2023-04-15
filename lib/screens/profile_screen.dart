import 'package:flutter/material.dart';
import 'package:flutter_9/screens/login_screen.dart';
import 'package:flutter_9/shared_preferences.dart';
import 'package:sizer/sizer.dart';

class ProfileWidget extends StatefulWidget {
  const ProfileWidget({Key? key}) : super(key: key);

  @override
  State<ProfileWidget> createState() => _ProfileWidgetState();
}

class _ProfileWidgetState extends State<ProfileWidget> {
  //final _textEditingController = TextEditingController();
  String? _name;
  String? _email;
  String? _phone;
  String? _info;
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  bool _isPressed = false;

  //читаем данные пользователя
  @override
  void initState() {
    super.initState();
    _name = UserPreferences().getUserName() ?? '';
    _email = UserPreferences().getUserEmail() ?? '';
    _phone = UserPreferences().getUserPhone() ?? '';
    _info = UserPreferences().getAboutUser() ?? '';
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
        padding: const EdgeInsets.only(top: 0, left: 0, right: 30, bottom: 0),
        decoration: const BoxDecoration(
          color: Color(0xFFF5F5F5),
        ),
        alignment: Alignment.center,
        child: Row(
          children: [
            Expanded(
              flex: 4,
              child: Container(
                // alignment: Alignment.center,
                height: double.infinity,
                //height: MediaQuery.of(context).size.height,
                padding: const EdgeInsets.all(10),
                color: const Color(0xFFD9D9D9),
                child: SingleChildScrollView(
                  child: Column(
                    //mainAxisSize: MainAxisSize.max,
                    //mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    //crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      buildHelloText(),
                      const SizedBox(
                        height: 20,
                      ),
                      buildAvatar(),
                      const SizedBox(
                        height: 100,
                      ),
                      buildExitTextButton(),
                    ],
                  ),
                ),
              ),
            ),
            Expanded(flex: 1, child: Column()),
            Expanded(
              flex: 7,
              child: SingleChildScrollView(
                child: Column(
                  //mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    buildNameText(),
                    buildNameField(),
                    const SizedBox(
                      height: 10,
                    ),
                    buildEmailText(),
                    buildEmailField(),
                    const SizedBox(
                      height: 10,
                    ),
                    buildPhoneText(),
                    buildPhoneField(),
                    const SizedBox(
                      height: 10,
                    ),
                    buildAboutYouText(),
                    buildAboutYouField(),
                    const SizedBox(
                      height: 20,
                    ),
                    buildElevatedButtonSave(),
                  ],
                ),
              ),
            ),
          ],
        ),
      );

  Widget portraitLayout() => Container(
        padding:
            const EdgeInsets.only(top: 30, left: 30, right: 30, bottom: 10),
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
                buildHelloText(),
                const SizedBox(
                  height: 20,
                ),
                buildAvatar(),
                const SizedBox(
                  height: 20,
                ),
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
                buildAboutYouText(),
                buildAboutYouField(),
                const SizedBox(
                  height: 25,
                ),
                buildElevatedButtonSave(),
                const SizedBox(
                  height: 30,
                ),
                buildExitTextButton(),
              ],
            ),
          ),
        ),
      );

  Widget buildHelloText() {
    return Center(
      child: Text(
        'Hello, $_name!',
        style: const TextStyle(
          fontFamily: 'Inter-Black',
          fontSize: 25,
          color: Color(0xFF000000),
        ),
      ),
    );
  }

  Widget buildAvatar() {
    return const Center(
      child: CircleAvatar(
        radius: 55,
        backgroundColor: Color(0xFF17E444),
        child: CircleAvatar(
          backgroundImage: NetworkImage(
              'https://img.icons8.com/ios/512/question-mark--v1.png'),
          radius: 52,
        ),
      ),
    );
  }

  Widget buildNameText() {
    return const Text(
      'Your name',
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
      style: const TextStyle(
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
      initialValue: _email,
      style: const TextStyle(
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
      'Phone number',
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
      style: const TextStyle(
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

  Widget buildAboutYouText() {
    return const Text(
      'Tell about yourself',
      style: TextStyle(
        fontFamily: 'Inter-SemiBold',
        fontSize: 16,
        color: Color(0xFF000000),
      ),
    );
  }

  Widget buildAboutYouField() {
    return TextFormField(
      maxLines: null,
      initialValue: _info,
      style: const TextStyle(
        fontFamily: 'Inter-SemiBold',
        fontSize: 16,
        color: Color(0xFF000000),
      ),
      decoration: const InputDecoration(
        border: InputBorder.none,
        fillColor: Color(0xFFD9D9D9),
        filled: true,
      ),
      keyboardType: TextInputType.text,
      onChanged: (value) => setState(() => _info = value),
    );
  }

  Widget buildElevatedButtonSave() {
    return Center(
      child: ElevatedButton(
        onPressed: () {
          if (_formKey.currentState!.validate()) {
            UserPreferences().setUserName(_name!);
            UserPreferences().setUserEmail(_email!);
            UserPreferences().setUserPhone(_phone!);
            UserPreferences().setAboutUser(_info!);
            // если форма прошла валидацию,
            //данные пользователя сохраняются в SharedPreferences
            ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(
                content: Text('Changes saved'),
                backgroundColor: Color(0xFF17E444),
              ),
            ); //всплывающее сообщение пользователю
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
          'Save',
          style: TextStyle(
            fontFamily: 'Inter-SemiBold',
            color: Color(0xFF1A1717),
            fontSize: 16,
          ),
        ),
      ),
    );
  }

  Widget buildExitTextButton() {
    return Center(
      child: TextButton(
        child: Text(
          'Exit',
          style: TextStyle(
            fontFamily: 'Inter-SemiBold',
            fontSize: 16,
            color:
                _isPressed ? const Color(0xFF17E444) : const Color(0xFF000000),
          ),
        ),
        onPressed: () async {
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
      ),
    );
  }
}
