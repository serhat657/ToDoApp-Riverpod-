import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:todo_provider/models/todo_model.dart';
import 'package:todo_provider/providers/all_providers.dart';
import 'package:todo_provider/widgets/title_widget.dart';
import 'package:todo_provider/widgets/todo_listitem_widget.dart';
import 'package:todo_provider/widgets/toolbar_widget.dart';
import 'package:uuid/uuid.dart';

// ignore: must_be_immutable
class TodoApp extends ConsumerWidget {
  TodoApp({super.key});
  final NewTodoController = TextEditingController();
  List<TodoModel> allTodos = [
    TodoModel(id: const Uuid().v4(), description: 'Go to gym'),
    TodoModel(id: const Uuid().v4(), description: 'go to GroceryShop'),
    TodoModel(id: const Uuid().v4(), description: 'Brush Your Teeth')
  ];

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    var allTodos = ref.watch(filteredTodoList);
    return  Scaffold(
      body: ListView(
        padding: const EdgeInsets.symmetric(horizontal:20 , vertical: 30 ),
        children: [
          const TitleWidget(),
          TextField(
            controller: NewTodoController,
            decoration: const InputDecoration(
              labelText: 'Whats your plan today '
            ),

            onSubmitted: (newTodo){
              ref.read(todoListProvider.notifier).addTodo(newTodo);
            },
          ),
          const SizedBox(height: 20,),
           ToolbarWidget(),
           allTodos.length == 0 ? Center(child: Text('It looks like clean ')) : const SizedBox(),
          for(var i=0; i<allTodos.length;i++)
            Dismissible(
              key: ValueKey(allTodos[i].id), 
              onDismissed: (_){
                ref.read(todoListProvider.notifier).remove(allTodos[i]);
              },
              child:  ProviderScope (
                overrides: [
                  currentTodoProvider.overrideWithValue(allTodos[i]),
                ],
                child: const TodoListitemWidget()  
              ),
            )
        ],
      ),
    );
  }
}