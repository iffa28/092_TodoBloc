import 'package:bloc/bloc.dart';
import 'package:todo_app/model/todo.dart';

part 'todo_event.dart';
part 'todo_state.dart';

class TodoBloc extends Bloc<TodoEvent, TodoState> {
  TodoBloc() : super(TodoLoaded(todos: [], selectedDate: null)) {
    on<TodoEventAdd>((event, emit) {
      //akan menambahkan data ke list,
      final currentState = state; //buat variabel untuk menyimpan state

      //cek jika state adalah TodoLoaded
      if (currentState is TodoLoaded) {

        // duplikat list todos lama agar tidak mengubah aslinya
        final List<Todo> updatedTodos = List.from(currentState.todos);

        // tambahkan todo baru ke list
        updatedTodos.add(
          Todo(title: event.title, isCompleted: false, date: event.date),
        );

      }
    });
  }
}
