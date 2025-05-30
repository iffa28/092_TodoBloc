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

        emit(
          // kirim state baru dengan todo yang sudah di update
          TodoLoaded(
            todos: updatedTodos, // memastikan list nya terbaru
            selectedDate: currentState.selectedDate,
          ),
        );
      }
    });

    //memanggil event untuk select date
    on<TodoSelectDate>((event, emit) {
      final currentState = state;
      if (currentState is TodoLoaded) {

        //kirim state baru dengan tanggal yang baru di pilih, tapi list todos tetap
        emit(TodoLoaded(todos: currentState.todos, selectedDate: event.date));
      }
    });

    // memanggil event todoEventComplete
    on<TodoEventComplete>((event, emit) {
      final currentState = state;
      if (currentState is TodoLoaded) {
        final List<Todo> updatedTodos = List.from(currentState.todos);

        if (event.index >= 0 && event.index < updatedTodos.length) {
          updatedTodos[event.index] = Todo(
            title: updatedTodos[event.index].title,
            date: updatedTodos[event.index].date,
            isCompleted: !updatedTodos[event.index].isCompleted,
            // isCompleted: updatedTodos[event.index].isCompleted == true,
          );

          emit(
            TodoLoaded(
              todos: updatedTodos,
              selectedDate: currentState.selectedDate,
            ),
          );
        }
      }
    });

    
  }
}
