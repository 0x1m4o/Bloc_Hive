import 'package:flutter/material.dart';

Widget showBackground(int direction) {
  return Container(
    margin: const EdgeInsets.all(4),
    padding: const EdgeInsets.symmetric(horizontal: 10),
    color: Colors.red,
    alignment: direction == 0 ? Alignment.centerLeft : Alignment.centerRight,
    child: const Icon(
      Icons.delete,
      size: 30,
      color: Colors.white,
    ),
  );
}
