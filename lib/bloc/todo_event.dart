part of 'todo_bloc.dart';

sealed class TodoEvent {}

final class TodoEventAdd extends TodoEvent {
  //untuk menambahkan todo
  final String title;
  final DateTime date;

  //constructor untuk membuat event tambah todo
  TodoEventAdd({required this.title, required this.date});   
}
