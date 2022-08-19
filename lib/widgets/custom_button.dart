import 'package:flutter/cupertino.dart';

class MyButton extends StatelessWidget {
  final String? title;
  final VoidCallback onPressed;
  const MyButton({super.key, required this.title, required this.onPressed});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      height: 50,
      child: CupertinoButton.filled(
        borderRadius: BorderRadius.circular(30),
        onPressed: onPressed,
        child: Text(title!),
      ),
    );
  }
}
