import 'package:flutter/material.dart';
import 'package:module_10/todos.dart';

class UpdateTaskModal extends StatefulWidget {
  const UpdateTaskModal({Key? key, required this.todo, required this.onTodoUpdate}) : super(key: key);

  final ToDO todo;
  final Function(String, String) onTodoUpdate;

  @override
  State<UpdateTaskModal> createState() => _UpdateTaskModalState();
}

class _UpdateTaskModalState extends State<UpdateTaskModal> {
  late final TextEditingController titleController;
  late final TextEditingController subtitleController;

  @override
  void initState() {
    super.initState();
    titleController = TextEditingController(text: widget.todo.title);
    subtitleController = TextEditingController(text: widget.todo.subtitle);
  }

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
                "Update Task",
                style: Theme.of(context).textTheme.headline6,
              ),
              IconButton(
                onPressed: () {
                  Navigator.pop(context);
                },
                icon: Icon(Icons.close),
              ),
            ],
          ),
          SizedBox(height: 16),
          TextFormField(
            controller: titleController,
            decoration: InputDecoration(
              labelText: "Title",
              hintText: "Enter task title",
              enabledBorder: OutlineInputBorder(),
              focusedBorder: OutlineInputBorder(),
            ),
          ),
          SizedBox(height: 16),
          TextFormField(
            controller: subtitleController,
            decoration: InputDecoration(
              labelText: "Subtitle",
              hintText: "Enter task subtitle",
              enabledBorder: OutlineInputBorder(),
              focusedBorder: OutlineInputBorder(),
            ),
          ),
          SizedBox(height: 16),
          SizedBox(
            width: double.infinity,
            child: ElevatedButton(
              onPressed: () {
                widget.onTodoUpdate(titleController.text.trim(), subtitleController.text.trim());
                Navigator.pop(context);
              },
              child: Text("Update"),
            ),
          ),
        ],
      ),
    );
  }

  @override
  void dispose() {
    titleController.dispose();
    subtitleController.dispose();
    super.dispose();
  }
}
