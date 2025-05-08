part of 'todo_bloc.dart';

sealed class TodoEvent {}

final class TodoEventAdd extends TodoEvent {
  //untuk menambahkan todo
  final String title;
  final DateTime date;

  //constructor untuk membuat event tambah todo
  TodoEventAdd({required this.title, required this.date});  
}

final class TodoEventComplete extends TodoEvent {
  //untuk mengganti status
  final int index;      //untuk membaca array todo
  
  //constructor untuk membuat event mengganti status
  TodoEventComplete({required this.index});
}

final class TodoSelectDate extends TodoEvent {
  // pilih tanggal
  final DateTime date;  

  //constructor untuk membuat event memilih tanggal
  TodoSelectDate({required this.date});
}
