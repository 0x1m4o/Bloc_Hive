import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hive_bloc/application/home/home_bloc.dart';
import 'package:hive_bloc/infrastructure/services/todo_service.dart';

class HomePage extends StatelessWidget {
  final String username;
  const HomePage({super.key, required this.username});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
        create: (context) =>
            HomeBloc(todoService: RepositoryProvider.of<TodoService>(context))
              ..add(LoadTodosEvent(username: username)),
        child: BlocBuilder<HomeBloc, HomeState>(
          builder: (context, state) {
            print('State is $state');
            if (state is TodosLoadedState) {
              return Scaffold(
                  appBar: AppBar(
                    title: const Text('Home Page'),
                  ),
                  body: ListView.builder(
                    itemBuilder: (context, index) {
                      return ListTile(
                        title: Text(state.tasks[index].task),
                        trailing: Checkbox(
                          value: state.tasks[index].completed,
                          onChanged: (value) {},
                        ),
                      );
                    },
                    itemCount: state.tasks.length,
                  ));
            }
            return Container(
              color: Colors.white,
              child: const Center(
                child: Text('No Loaded State'),
              ),
              width: 100,
              height: 100,
            );
          },
        ));
  }
}
