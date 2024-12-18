import 'package:bloc/bloc.dart';
import 'package:flutter_bloc_count/bloc/todo/to_do_event.dart';
import 'package:flutter_bloc_count/bloc/todo/to_do_state.dart';


class ToDoBloc extends Bloc<ToDoEvent, ToDoState> {

  final List<String> toDosList = [];
  ToDoBloc() : super(const ToDoState()) {
    on<AddTodoEvent>(_addToDoEvent);
    on<RemoveTodoEvent>(_removeToDoEvent);
  }

  void _addToDoEvent(AddTodoEvent event, Emitter<ToDoState> emit){
    toDosList.add(event.task);
    emit(state.copyWith(todosList: List.from(toDosList)));
  }

  void _removeToDoEvent(RemoveTodoEvent event, Emitter<ToDoState> emit){
    toDosList.remove(event.task);
    emit(state.copyWith(todosList: List.from(toDosList)));
  }


}
