import 'package:flutter/material.dart';
import 'package:module_10/todos.dart';

class AddNewTaskModal extends StatefulWidget {
  AddNewTaskModal({super.key, required this.onAddTap});

  final Function(ToDO) onAddTap;

  @override
  State<AddNewTaskModal> createState() => _AddNewTaskModalState();
}

class _AddNewTaskModalState extends State<AddNewTaskModal> {
  final TextEditingController todoTEController = TextEditingController();
  GlobalKey<FormState> _formKew = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Form(
        key: _formKew,
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Text(
                  "Add new todo",
                  style: Theme.of(context).textTheme.titleLarge,
                ),
                IconButton(
                    onPressed: () {
                      Navigator.pop(context);
                    },
                    icon: Icon(Icons.close))
              ],
            ),
            //Icon(Icons.close),
            TextFormField(
              maxLines: 4,
              controller: todoTEController,
              validator: (String? value) {
                if (value?.isEmpty ?? true) {
                  return "Enter a value";
                }
                return null;
              },
              decoration: InputDecoration(
                hintText: "Enter Your todo here",
                enabledBorder: OutlineInputBorder(),
                focusedBorder: OutlineInputBorder(),
              ),
            ),
            const SizedBox(
              height: 16,
            ),
            SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                    onPressed: () {
                      if (_formKew.currentState!.validate()) {
                        ToDO todo = ToDO(
                            details: todoTEController.text.trim(),
                            createdDateTime: DateTime.now(),
                            UpdatedDateTime: DateTime.now());
                        widget.onAddTap(todo);
                        Navigator.pop(context);
                      }
                    },
                    child: const Text("Add")))
          ],
        ),
      ),
    );
  }
}
