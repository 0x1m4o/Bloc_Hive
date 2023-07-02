import 'package:flutter/material.dart';

class AddTaskField extends StatefulWidget {
  AddTaskField({super.key});

  @override
  State<AddTaskField> createState() => _AddTaskFieldState();
}

class _AddTaskFieldState extends State<AddTaskField> {
  TextEditingController addTask = TextEditingController();

  @override
  void dispose() {
    addTask.clear();
    super.dispose();
  }

  Widget build(BuildContext context) {
    return Column(
      children: [
        TextField(
          controller: addTask,
          decoration: const InputDecoration(
            focusedBorder:
                OutlineInputBorder(borderSide: BorderSide(color: Colors.black)),
            floatingLabelStyle: TextStyle(color: Colors.black),
            border: OutlineInputBorder(),
            hintText: 'Enter New Task',
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
              Navigator.of(context).pop(addTask.text);
            },
            style: const ButtonStyle(
                side: MaterialStatePropertyAll(BorderSide(width: 1))),
            child: const Text(
              'Add',
              style: TextStyle(color: Colors.black),
            ),
          ),
        ),
      ],
    );
  }
}
