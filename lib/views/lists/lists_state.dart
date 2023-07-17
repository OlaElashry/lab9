part of 'lists_cubit.dart';

@immutable
abstract class ListsState {}

class ListsIntial extends ListsState {}

class ListsLoading extends ListsState {}

class ListsSuccess extends ListsState {}

class ListsError extends ListsState {}
