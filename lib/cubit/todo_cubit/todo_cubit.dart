import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mobile/models/todo.dart';

class TodoCubit extends Cubit<List<ToDo>> {
  TodoCubit() : super([]);

  void addTodo(ToDo todo) {
    print('todo: ${todo.body}');
    emit([...state, todo]);
    print('state: $state');
  }

  void deleteTodo(ToDo todo) {
    emit(state.where((element) => element.id != todo.id).toList());
  }

  void updateTodo(ToDo todo) {
    emit(state.map((e) => e.id == todo.id ? todo : e).toList());
  }
}
