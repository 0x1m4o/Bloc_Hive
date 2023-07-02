import 'package:flutter/material.dart';

class UserTextField extends StatelessWidget {
  const UserTextField({
    super.key,
    required this.usernameC,
  });

  final TextEditingController usernameC;

  @override
  Widget build(BuildContext context) {
    return TextField(
      controller: usernameC,
      decoration: const InputDecoration(
        focusedBorder:
            OutlineInputBorder(borderSide: BorderSide(color: Colors.black)),
        floatingLabelStyle: TextStyle(color: Colors.black),
        border: OutlineInputBorder(),
        hintText: 'Enter your username',
        labelText: 'Username',
      ),
    );
  }
}
