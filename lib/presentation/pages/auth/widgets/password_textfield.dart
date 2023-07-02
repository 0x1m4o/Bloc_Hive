import 'package:flutter/material.dart';

class PasswordTextField extends StatefulWidget {
  final TextEditingController passwordC;

  const PasswordTextField({super.key, required this.passwordC});

  @override
  State<PasswordTextField> createState() => _PasswordTextFieldState();
}

class _PasswordTextFieldState extends State<PasswordTextField> {
  bool _obscure = true;

  @override
  Widget build(BuildContext context) {
    return TextField(
      controller: widget.passwordC,
      obscureText: _obscure,
      decoration: InputDecoration(
        focusedBorder: const OutlineInputBorder(
            borderSide: BorderSide(color: Colors.black)),
        floatingLabelStyle: const TextStyle(color: Colors.black),
        border: const OutlineInputBorder(),
        suffixIcon: IconButton(
          onPressed: () {
            setState(() {
              _obscure = !_obscure;
            });
          },
          icon: Icon(
            _obscure
                ? Icons.remove_red_eye_sharp
                : Icons.remove_red_eye_outlined,
            color: Colors.black,
          ),
        ),
        hintText: 'Enter your password',
        labelText: 'Password',
      ),
    );
  }
}
