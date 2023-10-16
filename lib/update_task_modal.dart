import 'package:flutter/material.dart';
import 'package:module_10/todos.dart';

class UpdateTaskModel extends StatefulWidget {
  const UpdateTaskModel(
      {super.key, required this.todo, required this.onTodoUpdate});

  final ToDO todo;
  final Function(String) onTodoUpdate;

  @override
  State<UpdateTaskModel> createState() => _UpdateTaskModel();
}

class _UpdateTaskModel extends State<UpdateTaskModel> {
  late final TextEditingController todoTEController =
      TextEditingController(text: widget.todo.details);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Text(
                "Update todo",
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
            controller: todoTEController,
            maxLines: 4,
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
                    widget.onTodoUpdate(todoTEController.text.trim());
                    Navigator.pop(context);
                  },
                  child: Text("Update")))
        ],
      ),
    );
  }
}
