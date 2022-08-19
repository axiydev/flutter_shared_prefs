import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_shared_prefs/utils/login/login_service.dart';
import 'package:flutter_shared_prefs/widgets/custom_button.dart';
import 'package:flutter_shared_prefs/widgets/login_field.dart';
import 'package:flutter_shared_prefs/widgets/password_field.dart';
import 'package:lottie/lottie.dart';

class SignUPPage extends StatefulWidget {
  const SignUPPage({super.key});

  @override
  State<SignUPPage> createState() => _SignUPPageState();
}

class _SignUPPageState extends State<SignUPPage> {
  final TextEditingController _login = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _confirmPasswordController =
      TextEditingController();
  final _key = GlobalKey<FormState>();
  final loginService = LoginRepo();

  bool? _validate() {
    return _key.currentState!.validate();
  }

  void _signUp() async {
    if (!_validate()!) return;

    ///sign up repo
    final String? token = await loginService.signUp(
        login: _login.text,
        password: _passwordController.text,
        confirmPassword: _confirmPasswordController.text);
    if (token != null && token.isNotEmpty) {
      showCupertinoDialog(
          context: context,
          barrierDismissible: true,
          builder: (_) => CupertinoAlertDialog(
                content: Center(
                  child: Lottie.asset('assets/lottie/success.json', width: 200),
                ),
              ));
      await Future.delayed(const Duration(seconds: 1), () {});
      // ignore: use_build_context_synchronously
      Navigator.of(context).pushNamedAndRemoveUntil('/home', (route) => false);
    }
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
              ///login field
              Padding(
                  padding:
                      const EdgeInsets.only(left: 20, right: 20, bottom: 15),
                  child: LoginField(
                    login: _login,
                    hintText: 'Login',
                    onChanged: (newValue) => print(newValue),
                    validator: (value) => !value!.contains('@gmail.com')
                        ? 'Login @gmail bilan tugashi kerak'
                        : null,
                  )),

              ///password field
              Padding(
                  padding:
                      const EdgeInsets.only(left: 20, right: 20, bottom: 15),
                  child: PasswordField(
                    passwordController: _passwordController,
                    hintText: 'Password',
                    validator: (value) => value!.isEmpty || value.length < 6
                        ? 'passsword kiritilmagan yoki 6 ta belgidan kam'
                        : null,
                  )),

              ///confirm password filed
              Padding(
                  padding:
                      const EdgeInsets.only(left: 20, right: 20, bottom: 15),
                  child: PasswordField(
                    passwordController: _confirmPasswordController,
                    hintText: 'Confirm Password',
                    validator: (value) => value!.isEmpty || value.length < 6
                        ? 'passsword kiritilmagan yoki 6 ta belgidan kam'
                        : null,
                  )),

              ///my button
              Builder(builder: (context) {
                return Padding(
                  padding:
                      const EdgeInsets.only(left: 20, right: 20, bottom: 15),
                  child: MyButton(
                    onPressed: _signUp,
                    title: 'Sign Up',
                  ),
                );
              }),
              TextButton(
                  onPressed: () {
                    Navigator.of(context).pushNamed('/sign_in');
                  },
                  child: const Text('I already have an account'))
            ],
          ),
        ),
      ),
    );
  }
}
