import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mobile/cubit/todo_cubit/todo_cubit.dart';
import 'package:mobile/models/todo.dart';
import 'package:mobile/widgets/drawer_widget.dart';

class EducationScreen extends StatefulWidget {
  const EducationScreen({super.key});

  @override
  State<EducationScreen> createState() => _EducationScreenState();
}

class _EducationScreenState extends State<EducationScreen> {
  TextEditingController todoTextController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return buildDrawerWidget(
      context: context,
      appBarTitle: 'Study',
      content: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          //! todo add
          Container(
            padding: const EdgeInsets.only(left: 16, right: 16, top: 60),
            child: Column(
              children: [
                TextField(
                  controller: todoTextController,
                  decoration: const InputDecoration(
                    enabledBorder: OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.grey, width: 0.0),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.blue, width: 0.0),
                    ),
                  ),
                ),
              ],
            ),
          ),
          ElevatedButton(
            onPressed: () {
              if (todoTextController.text.isNotEmpty) {
                context.read<TodoCubit>().addTodo(
                      ToDo(
                        body: todoTextController.text,
                        isCompleted: false,
                      ),
                    );
                todoTextController.clear();
              }
            },
            child: const Text('add todo'),
          ),
          const SizedBox(height: 32),

          Container(width: 200, height: 20, color: Colors.yellow),
          //! BlocBuilder
          Expanded(
            child: BlocBuilder<TodoCubit, List<ToDo>>(
              builder: (context, todos) {
                return todos.isEmpty
                    ? const Text('not any todo...')
                    : ListView.builder(
                        itemCount: todos.length,
                        itemBuilder: (context, index) =>
                            Text(todos[index].body),
                      );
              },
            ),
          ),
          Container(width: 200, height: 20, color: Colors.yellow),
        ],
      ),
    );
  }
}
