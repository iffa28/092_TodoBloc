import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:todo_app/bloc/todo_bloc.dart';

class TodoPage extends StatelessWidget {
  const TodoPage({super.key});

  @override
  Widget build(BuildContext context) {
    final _key = GlobalKey<FormState>();
    final _controller = TextEditingController();
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.all(16.0),
          child: Column(
            children: [
              Text('Todo List'),
              Row(
                children: [
                  Text('Selected Date'),

                ],
              ),
              Row(
                children: [
                  BlocBuilder<TodoBloc, TodoState>(
                    builder: (context, state) {
                      if (state is TodoLoaded) {
                        if (state.selectedDate != null) {
                          return Text(
                            '${state.selectedDate!.day}/${state.selectedDate!.month}/${state.selectedDate!.year}',
                          );
                        }
                      }
                      return Text('No Date selected');
                    },
                  ),
                  SizedBox(width: 178),
                  Expanded(
                    child: ElevatedButton(
                      onPressed: () {
                        showDatePicker(
                          context: context,
                          initialDate: DateTime.now(),
                          firstDate: DateTime(2000),
                          lastDate: DateTime(2100),
                        ).then((selectedDate) {
                          //setelah pilih tanggal, kirim event ke bloc
                          if (selectedDate != null) {
                            context.read<TodoBloc>().add(
                              TodoSelectDate(date: selectedDate),
                            );
                          }
                        });
                      },
                      child: Text('Select Date'),
                    ),
                  ),
                ],
              ),
              SizedBox(height: 16),

              Form(
                key: _key,
                child: Row(
                  children: [
                    Expanded(
                      child: TextFormField(
                        controller: _controller,
                        decoration: InputDecoration(
                          labelText: 'Todo',
                          border: OutlineInputBorder(),
                        ),
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Please enter a todo';
                          }
                          return null;
                        },
                      ),
                    ),
                    SizedBox(width: 25),
                    FilledButton(
                      onPressed: () {
                        if (_key.currentState!.validate()) {
                          final selectedDate = context.read<TodoBloc>().state;  // mengambil data terbaru dari bloc
                          if (selectedDate is TodoLoaded) {   //kalau data nya sudah ke load
                            context.read<TodoBloc>().add(    //mengirim event baru yaitu todoEventBloc ke block 
                              TodoEventAdd(
                                title: _controller.text,
                                date: selectedDate.selectedDate!,
                              ),
                            );
                            _controller.clear();
                            selectedDate.selectedDate = null;   //setelah submit akan kosong lagi
                          }
                        }
                      },
                      child: Text('Tambah'),
                    ),
                  ],
                ),
              ),
              SizedBox(height: 16.0),
              Expanded(
                child: BlocBuilder<TodoBloc, TodoState>(
                  builder: (context, state) {
                    if (state is TodoLoading) {         //loading ketika bloc set state sebelum load data
                      return Center(child: CircularProgressIndicator());
                    } else if (state is TodoLoaded) {
                      if (state.todos.isEmpty) {
                        return Center(child: Text('Todo list is empty'));
                      }
                      return ListView.builder(
                        itemCount: state.todos.length,     //jumlah todo
                        itemBuilder: (context, index) {
                          final todo = state.todos[index];   // ambil todo per item
                          return Container(
                            margin: EdgeInsets.only(bottom: 8),
                            padding: EdgeInsets.all(16.0),
                            decoration: BoxDecoration(
                              color: Colors.blue[50],
                              borderRadius: BorderRadius.circular(8),
                            ),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      todo.title,
                                      style: TextStyle(
                                        fontSize: 16,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                    SizedBox(height: 4),
                                    Text(
                                      todo.isCompleted
                                          ? 'Completed'
                                          : 'Not Completed',
                                      style: TextStyle(
                                        color:
                                            todo.isCompleted
                                                ? Colors.green
                                                : Colors.red,
                                      ),
                                    ),
                                  ],
                                ),
                                Checkbox(
                                  value: todo.isCompleted,
                                  onChanged:todo.isCompleted
                                  ? null       //jika sudah complete, checkbox jadi disable
                                  : (value) {
                                    context.read<TodoBloc>().add(
                                      TodoEventComplete(index: index),    // mengirim event ke bloc
                                    );
                                  },
                                ),
                              ],
                            ),
                          );
                        },
                      );
                    } else {
                      return Center(child: Text('No todos available'));
                    }
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
