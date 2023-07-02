import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hive_bloc/application/home/home_bloc.dart';
import 'package:hive_bloc/infrastructure/services/todo_service.dart';
import 'package:hive_bloc/presentation/pages/home/widgets/add_task_textfield.dart';

class HomePage extends StatefulWidget {
  final String username;
  const HomePage({super.key, required this.username});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
        create: (context) =>
            HomeBloc(todoService: RepositoryProvider.of<TodoService>(context))
              ..add(LoadTodosEvent(username: widget.username)),
        child: BlocBuilder<HomeBloc, HomeState>(
          builder: (context, state) {
            if (state is TodosLoadedState) {
              return Scaffold(
                  appBar: AppBar(
                    title: const Text('Home Page'),
                    actions: [
                      Padding(
                        padding: const EdgeInsets.all(10.0),
                        child: Center(child: Text(state.username)),
                      ),
                    ],
                  ),
                  floatingActionButton: FloatingActionButton(
                    onPressed: () async {
                      final result = await showDialog(
                        context: context,
                        builder: (context) {
                          return SimpleDialog(
                            children: [
                              Padding(
                                padding: const EdgeInsets.all(10),
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  children: [
                                    Container(
                                      width: double.infinity,
                                      child: Text(
                                        'Add New Task',
                                        style: TextStyle(
                                            fontSize: 18,
                                            fontWeight: FontWeight.bold),
                                        textAlign: TextAlign.start,
                                      ),
                                    ),
                                    SizedBox(
                                      height: 15,
                                    ),
                                    AddTaskField(),
                                  ],
                                ),
                              )
                            ],
                          );
                        },
                      );

                      if (result != null) {
                        context
                            .read<HomeBloc>()
                            .add(AddTodosEvent(task: result));
                      }
                    },
                    child: const Icon(Icons.add),
                  ),
                  body: ListView.builder(
                    itemBuilder: (context, index) {
                      return ListTile(
                        title: Text(state.tasks[index].task),
                        trailing: Checkbox(
                          value: state.tasks[index].completed,
                          onChanged: (value) {
                            print(
                              'Status on Home ${state.tasks[index].completed}',
                            );
                            setState(() {
                              context.read<HomeBloc>().add(ToggleTodosEvent(
                                  task: state.tasks[index].task));
                            });
                          },
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
            );
          },
        ));
  }
}
