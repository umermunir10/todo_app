import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:todo_app/model/todo.dart';

class TodoWidget extends StatelessWidget {
  final Todo todo;

  const TodoWidget({required this.todo, super.key});

  @override
  Widget build(BuildContext context) {
    Widget buildTodo(BuildContext context) => Container(
          color: Colors.white,
          padding: const EdgeInsets.all(20),
          child: Row(
            children: [
              Checkbox(
                activeColor: Theme.of(context).primaryColor,
                checkColor: Colors.white,
                value: todo.isDone,
                onChanged: (value) {},
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
        );

    return ClipRRect(
      borderRadius: BorderRadius.circular(16),
      child: Slidable(
          key: Key(todo.id),
          startActionPane: const ActionPane(motion: StretchMotion(), children: [
            SlidableAction(
              onPressed: null,
              icon: Icons.edit,
              foregroundColor: Colors.white,
              backgroundColor: Colors.green,
              label: 'Edit',
            )
          ]),
          endActionPane: const ActionPane(motion: StretchMotion(), children: [
            SlidableAction(
              onPressed: null,
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
