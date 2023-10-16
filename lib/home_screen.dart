import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:module_10/add_new_task.dart';
import 'package:module_10/todos.dart';
import 'package:module_10/update_task_modal.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  List<ToDO> taskList = [];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("To Do"),
        centerTitle: true,
      ),
      body: ListView.separated(
          itemCount: taskList.length,
          itemBuilder: (context, index) {
            final ToDO todo = taskList[index];
            final String formattedDate =
                DateFormat("hh:mm a dd-MM-yyyy").format(todo.createdDateTime);
            return ListTile(
              tileColor: todo.status == 'done' ? Colors.green : null,
              title: Text(todo.details),
              subtitle: Text(formattedDate),
              trailing: Text(todo.status.toUpperCase()),
              onTap: () {
                showDialog(
                    context: context,
                    builder: (context) {
                      return AlertDialog(
                        title: Text("Action"),
                        content: Column(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            ListTile(
                              leading: Icon(Icons.edit),
                              title: Text("Update"),
                              onTap: () {
                                Navigator.pop(context);
                                showModalBottomSheet(
                                    context: context,
                                    builder: (context) {
                                      return UpdateTaskModel(
                                        todo: todo,
                                        onTodoUpdate:
                                            (String updatedDetailsText) {
                                          updateTodo(index, updatedDetailsText);
                                        },
                                      );
                                    });
                              },
                            ),
                            Divider(
                              height: 0,
                            ),
                            ListTile(
                              leading: Icon(Icons.delete),
                              title: Text("Delete"),
                              onTap: () {
                                deleteToDo(index);
                                Navigator.pop(context);
                                // TODO delete the item
                              },
                            )
                          ],
                        ),
                      );
                    });
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
          }),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          showModalBottomSheet(
              context: context,
              builder: (context) {
                return AddNewTaskModal(
                  onAddTap: (ToDO task) {
                    addTask(task);
                  },
                );
              });
        },
        child: Icon(Icons.add),
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

  void updateTodo(int index, String todoDetails) {
    taskList[index].details = todoDetails;
    setState(() {});
  }

  void updateStatus(int index, String status) {
    taskList[index].status = status;
    setState(() {});
  }
}
