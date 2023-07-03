// ignore_for_file: must_be_immutable

import 'package:flutter/material.dart';

class AddOrEditTaskField extends StatefulWidget {
  final String addOrEdit;
  String? task;
  AddOrEditTaskField({Key? key, required this.addOrEdit, this.task})
      : super(key: key);

  @override
  State<AddOrEditTaskField> createState() => _AdOrEditdTaskFieldState();
}

class _AdOrEditdTaskFieldState extends State<AddOrEditTaskField> {
  TextEditingController addOrTask = TextEditingController();

  @override
  void dispose() {
    addOrTask.clear();
    super.dispose();
  }

  @override
  void initState() {
    if (widget.task != null) {
      addOrTask.text = widget.task!;
    }
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        TextField(
          controller: addOrTask,
          decoration: InputDecoration(
            focusedBorder: const OutlineInputBorder(
                borderSide: BorderSide(color: Colors.black)),
            floatingLabelStyle: const TextStyle(color: Colors.black),
            border: const OutlineInputBorder(),
            hintText: '${widget.addOrEdit} Task',
            labelText: 'Task',
          ),
        ),
        const SizedBox(
          height: 10,
        ),
        Container(
          width: double.infinity,
          alignment: Alignment.centerRight,
          child: OutlinedButton(
            onPressed: () {
              Navigator.of(context).pop(addOrTask.text);
            },
            style: const ButtonStyle(
                side: MaterialStatePropertyAll(BorderSide(width: 1))),
            child: Text(
              widget.addOrEdit,
              style: const TextStyle(color: Colors.black),
            ),
          ),
        ),
      ],
    );
  }
}
