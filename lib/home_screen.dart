import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:module_10/todos.dart';
import 'package:module_10/update_task_modal.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final TextEditingController todoTController = TextEditingController();
  final TextEditingController todoSTController = TextEditingController();
  GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  List<ToDO> taskList = [];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("To Do"),
        centerTitle: true,
      ),
      body: Form(
        key: _formKey,
        child: Column(
          children: [
            TextFormField(
              maxLines: 1,
              controller: todoTController,
              validator: (String? value) {
                if (value?.isEmpty ?? true) {
                  return "Enter a value";
                }
                return null;
              },
              decoration: InputDecoration(
                hintText: "Add Title",
                enabledBorder: OutlineInputBorder(),
                focusedBorder: OutlineInputBorder(),
              ),
            ),
            TextFormField(
              maxLines: 1,
              controller: todoSTController,
              validator: (String? value) {
                if (value?.isEmpty ?? true) {
                  return "Enter a value";
                }
                return null;
              },
              decoration: const InputDecoration(
                hintText: "Add description",
                enabledBorder: OutlineInputBorder(),
                focusedBorder: OutlineInputBorder(),
              ),
            ),
            const SizedBox(
              height: 16,
            ),
            SizedBox(
              //width: double.infinity,
              child: ElevatedButton(
                onPressed: () {
                  if (_formKey.currentState!.validate()) {
                    ToDO todo = ToDO(
                      title: todoTController.text.trim(),
                      subtitle: todoSTController.text.trim(),
                      createdDateTime: DateTime.now(),
                      updatedDateTime: DateTime.now(),
                      status: 'pending',
                    );
                    addTask(todo);
                    todoTController.clear();
                  }
                },
                child: const Text("Add"),
              ),
            ),
            Expanded(
              child: ListView.separated(
                itemCount: taskList.length,
                itemBuilder: (context, index) {
                  final ToDO todo = taskList[index];
                  final String formattedDate =
                  DateFormat("hh:mm a dd-MM-yyyy").format(todo.createdDateTime);
                  return ListTile(
                    tileColor: todo.status == 'done' ? Colors.green : null,
                    title: Text(todo.title),
                    subtitle: Text(todo.subtitle),
                    trailing: Text(todo.status.toUpperCase()),
                    onTap: () {
                      showDialog(
                        context: context,
                        builder: (context) {
                          return AlertDialog(
                            title: Text("Alert"),
                            content: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                TextButton(
                                  onPressed: () {
                                    Navigator.pop(context);
                                    showModalBottomSheet(
                                      context: context,
                                      builder: (context) {
                                        return UpdateTaskModal(
                                          todo: todo,
                                          onTodoUpdate: (String updatedTitle,String updatedSubtitle) {
                                            updateTodo(index, updatedTitle,updatedSubtitle);
                                          },
                                        );
                                      },
                                    );
                                  },
                                  child: Text("Edit"),
                                ),
                                TextButton(
                                  onPressed: () {
                                    deleteToDo(index);
                                    Navigator.pop(context);
                                  },
                                  child: Text("Delete"),
                                ),
                              ],
                            ),

                          );
                        },
                      );
                    },
                    onLongPress: () {
                      String currentState =
                      todo.status == "pending" ? "done" : "pending";
                      updateStatus(index, currentState);
                    },
                    leading: CircleAvatar(
                      child: Text("${index + 1}"),
                    ),
                  );
                },
                separatorBuilder: (BuildContext context, int index) {
                  return const Divider(
                    height: 4,
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }

  void addTask(ToDO task) {
    taskList.add(task);
    setState(() {});
  }

  void deleteToDo(int index) {
    taskList.removeAt(index);
    setState(() {});
  }

  void updateTodo(int index, String todoTitle, String updatedSubtitle) {
    taskList[index].title = todoTitle;
    taskList[index].subtitle = updatedSubtitle;
    setState(() {});
  }

  void updateStatus(int index, String status) {
    taskList[index].status = status;
    setState(() {});
  }
}
