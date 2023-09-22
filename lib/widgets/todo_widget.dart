import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:provider/provider.dart';
import 'package:todo_app/model/todo.dart';
import 'package:todo_app/provider/todos.dart';
import 'package:todo_app/utils.dart';
import 'package:todo_app/pages/edit_todo_page.dart';

class TodoWidget extends StatelessWidget {
  final Todo todo;

  const TodoWidget({required this.todo, super.key});

  @override
  Widget build(BuildContext context) {
    void editTodo(BuildContext context, Todo todo) =>
        Navigator.of(context).push(
            MaterialPageRoute(builder: (context) => EditTodoPage(todo: todo)));

    Widget buildTodo(BuildContext context) => GestureDetector(
          onTap: () {
            editTodo(context, todo);
          },
          child: Container(
            color: Colors.white,
            padding: const EdgeInsets.all(20),
            child: Row(
              children: [
                Checkbox(
                  activeColor: Theme.of(context).primaryColor,
                  checkColor: Colors.white,
                  value: todo.isDone,
                  onChanged: (value) {
                    final provider =
                        Provider.of<TodosProvider>(context, listen: false);
                    final isDone = provider.toggleTodoStatus(todo);
                    Utils.showSnackBar(context,
                        isDone ? 'Task Completed' : 'Task Marked Incomplete');
                  },
                ),
                const SizedBox(
                  width: 20,
                ),
                Expanded(
                    child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      todo.title,
                      style: TextStyle(
                          fontWeight: FontWeight.bold,
                          color: Theme.of(context).primaryColor,
                          fontSize: 22),
                    ),
                    if (todo.description.isNotEmpty)
                      Container(
                        child: Text(
                          todo.description,
                          style: const TextStyle(fontSize: 20, height: 1.5),
                        ),
                      )
                  ],
                ))
              ],
            ),
          ),
        );

    void deleteTodo(BuildContext context, Todo todo) {
      final provider = Provider.of<TodosProvider>(context, listen: false);
      provider.removeTodo(todo);

      Utils.showSnackBar(context, 'Deleted the Task');
    }

    return ClipRRect(
      borderRadius: BorderRadius.circular(16),
      child: Slidable(
          key: Key(todo.id),
          startActionPane: ActionPane(motion: const StretchMotion(), children: [
            SlidableAction(
              onPressed: (BuildContext) {
                editTodo(context, todo);
              },
              icon: Icons.edit,
              foregroundColor: Colors.white,
              backgroundColor: Colors.green,
              label: 'Edit',
            )
          ]),
          endActionPane: ActionPane(motion: const StretchMotion(), children: [
            SlidableAction(
              onPressed: (BuildContext) {
                deleteTodo(context, todo);
              },
              icon: Icons.delete,
              foregroundColor: Colors.white,
              backgroundColor: Colors.red,
              label: 'Delete',
            )
          ]),
          child: buildTodo(context)),
    );
  }
}
