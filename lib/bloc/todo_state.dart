part of 'todo_bloc.dart';

sealed class TodoState {}

final class TodoInitial extends TodoState {}  //default

final class TodoLoading extends TodoState {}  

