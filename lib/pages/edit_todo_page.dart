import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:todo_app/provider/todos.dart';
import 'package:todo_app/widgets/todo_form_widget.dart';
import 'package:todo_app/model/todo.dart';

class EditTodoPage extends StatefulWidget {
  final Todo todo;
  const EditTodoPage({super.key, required this.todo});

  @override
  State<EditTodoPage> createState() => _EditTodoPageState();
}

class _EditTodoPageState extends State<EditTodoPage> {
  final _formKey = GlobalKey<FormState>();

  late String title;
  late String description;

  @override
  void initState() {
    super.initState();

    title = widget.todo.title;
    description = widget.todo.description;
  }

  @override
  Widget build(BuildContext context) {
    void saveTodo() {
      final isValid = _formKey.currentState!.validate();
      if (!isValid) {
        return;
      } else {
        final provider = Provider.of<TodosProvider>(context, listen: false);
        provider.updateTodo(widget.todo, title, description);
        Navigator.of(context).pop();
      }
    }

    return Scaffold(
        appBar: AppBar(
          title: const Text('Edit Todo'),
          actions: [
            IconButton(
                onPressed: () {
                  final provider =
                      Provider.of<TodosProvider>(context, listen: false);
                  provider.removeTodo(widget.todo);
                  Navigator.of(context).pop();
                },
                icon: const Icon(Icons.delete))
          ],
        ),
        body: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Form(
            key: _formKey,
            child: TodoFormWidget(
              title: title,
              description: description,
              onChangedTitle: (title) {
                setState(() {
                  this.title = title;
                });
              },
              onChangedDescription: (decsription) {
                setState(() {
                  description = description;
                });
              },
              onSavedTodo: saveTodo,
            ),
          ),
        ));
  }
}
