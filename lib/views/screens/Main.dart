import 'package:first_application/models/work_list.dart';
import 'package:first_application/services/list_services.dart';
import 'package:first_application/views/lists/lists_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class Main extends StatefulWidget {
  const Main({super.key});

  @override
  State<Main> createState() => _MainState();
}

class _MainState extends State<Main> {
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => ListsCubit(),
      child: BlocConsumer<ListsCubit, ListsState>(builder: (context, state) {
        if (state is ListsLoading) {
          return Center(
            child: CircularProgressIndicator(),
          );
        } else if (state is ListsSuccess) {
          return ListView.builder(
              itemCount: context.watch<ListsCubit>().works.length,
              itemBuilder: (BuildContext context, int index) {
                return ListTile(
                  leading: Text(context
                      .watch<ListsCubit>()
                      .works[index]
                      .userId
                      .toString()),
                  title: Text(
                      context.watch<ListsCubit>().works[index].title ?? "--"),
                  subtitle: Text(context
                      .watch<ListsCubit>()
                      .works[index]
                      .completed
                      .toString()),
                  trailing: Icon(Icons.edit),
                );
              });
        } else {
          return Center(
            child: Text(
              'Error!',
              style: TextStyle(fontSize: 24),
            ),
          );
        }
      }, listener: (context, state) {
        if (state is ListsError) {
          ScaffoldMessenger.of(context)
              .showSnackBar(SnackBar(content: Text("Error")));
        }
      }),
    );
  }
}
