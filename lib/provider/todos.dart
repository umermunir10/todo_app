import 'package:flutter/cupertino.dart';
import 'package:todo_app/model/todo.dart';

class TodosProvider extends ChangeNotifier {
  final List<Todo> _todos = [
    Todo(createdTime: DateTime.now(), title: 'Buy Food', description: '''- Eggs 
- Milk
- Bread
- Water'''),
    Todo(
        createdTime: DateTime.now(),
        title: 'Plan Family Trip to Norway',
        description: '''- Rent some Hotels
- Rent a Car
- Pack Suitcase '''),
    Todo(createdTime: DateTime.now(), title: 'Walk the Dog'),
    Todo(createdTime: DateTime.now(), title: 'Plan Jacobs Birthday Party')
  ];

  List<Todo> get todos => _todos.where((todo) => todo.isDone == false).toList();
}
