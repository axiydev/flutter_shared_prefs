import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_shared_prefs/utils/login/login_service.dart';
import 'package:flutter_shared_prefs/widgets/custom_button.dart';
import 'package:flutter_shared_prefs/widgets/login_field.dart';
import 'package:flutter_shared_prefs/widgets/password_field.dart';
import 'package:lottie/lottie.dart';

class SignInPage extends StatefulWidget {
  const SignInPage({super.key});

  @override
  State<SignInPage> createState() => _SignInPageState();
}

class _SignInPageState extends State<SignInPage> {
  final TextEditingController _login = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final loginService = LoginRepo();
  final _key = GlobalKey<FormState>();

  void _signIn() async {
    if (!_validate()!) return;

    ///login service
    final String? token = await loginService.signIn(
        login: _login.text, password: _passwordController.text);
    if (token != null && token.isNotEmpty) {
      if (mounted) {
        showCupertinoDialog(
            context: context,
            useRootNavigator: true,
            barrierDismissible: true,
            builder: (context) => CupertinoAlertDialog(
                  content: Center(
                    child:
                        Lottie.asset('assets/lottie/success.json', width: 200),
                  ),
                ));
        await Future.delayed(const Duration(seconds: 1), () {
          Navigator.pop(context);
        });
        // ignore: use_build_context_synchronously
        Navigator.of(context)
            .pushNamedAndRemoveUntil('/home', (route) => false);
      }
    }
  }

  bool? _validate() {
    return _key.currentState!.validate();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SizedBox(
        height: double.infinity,
        width: double.infinity,
        child: Form(
          key: _key,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              ///login
              Padding(
                padding: const EdgeInsets.only(left: 20, right: 20, bottom: 15),
                child: LoginField(
                  login: _login,
                  hintText: 'Login',
                  onChanged: (newValue) => print(newValue),
                  validator: (value) => !value!.contains('@gmail.com')
                      ? 'Login kiritishda xatolik'
                      : null,
                ),
              ),

              ///password
              Padding(
                padding: const EdgeInsets.only(left: 20, right: 20, bottom: 15),
                child: PasswordField(
                  passwordController: _passwordController,
                  hintText: 'Password',
                  validator: (value) => value!.isEmpty || value.length < 6
                      ? 'passsword kiritilmagan yoki 6 ta belgidan kam'
                      : null,
                ),
              ),
              Padding(
                  padding:
                      const EdgeInsets.only(left: 20, right: 20, bottom: 15),
                  child: MyButton(
                    onPressed: _signIn,
                    title: 'Login',
                  )),
              TextButton(
                  onPressed: () {
                    Navigator.of(context).pushNamed('/sign_up');
                  },
                  child: const Text('I don\'t have an account'))
            ],
          ),
        ),
      ),
    );
  }
}
