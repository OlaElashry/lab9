import 'package:bloc/bloc.dart';
import 'package:first_application/models/work_list.dart';
import 'package:first_application/services/list_services.dart';
import 'package:meta/meta.dart';

part 'lists_state.dart';

class ListsCubit extends Cubit<ListsState> {
  ListsCubit() : super(ListsIntial()) {
    getWorks();
  }
  List<ToDoListModel> works = [];
  bool isLoading = true;

  getWorks() async {
    emit(ListsLoading());
    try {
      works = await ListServices().getToDoList();
      isLoading = false;
      //throw Exception();
      emit(ListsSuccess());
    } catch (e) {
      print(e.toString());
      emit(ListsError());
    }
  }
}
