part of 'todo_bloc.dart';

sealed class TodoState {}

final class TodoInitial extends TodoState {}  //default

final class TodoLoading extends TodoState {}  

final class TodoLoaded extends TodoState {  
  final List<Todo> todos;  //harus pakai ini supaya seluruh halaman tidak dibaca date
  DateTime? selectedDate;   //ketika memilih tanggal, harus mengembalikan list, krn selecteddate akan di simpan dalam list

  TodoLoaded({required this.todos, required this.selectedDate});
}
