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

              
            ],
          ),
        ),
      ),
    );
  }
}
