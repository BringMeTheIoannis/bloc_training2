import 'package:block_training_2/bloc/events/events.dart';
import 'package:block_training_2/bloc/model/bloc_model.dart';
import 'package:block_training_2/bloc/model/cubit_model.dart';
import 'package:block_training_2/bloc/states/states.dart';
import 'package:block_training_2/data/data_repo.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

void main() {
  runApp(const RootWidget());
}

class RootWidget extends StatelessWidget {
  const RootWidget({super.key});

  @override
  Widget build(BuildContext context) {
    final DataRepository dataRepository = DataRepository();
    return MaterialApp(
      home: MultiBlocProvider(
        providers: [
          BlocProvider(
            create: (context) =>
                BlocModel(dataRepository: dataRepository)..add(Load()),
          ),
          BlocProvider(create: (BuildContext context) => CubitModel()),
        ],
        child: const HomeWidget(),
      ),
      theme: ThemeData(primarySwatch: Colors.blue),
    );
  }
}

class HomeWidget extends StatefulWidget {
  const HomeWidget({super.key});

  @override
  State<HomeWidget> createState() => _HomeWidgetState();
}

class _HomeWidgetState extends State<HomeWidget> {
  @override
  Widget build(BuildContext context) {
    BlocModel bloc = BlocProvider.of<BlocModel>(context);
    return Container(
      color: Colors.blue,
      child: SafeArea(
        child: Scaffold(
          appBar: AppBar(
            centerTitle: true,
            title: BlocBuilder<CubitModel, InternetConnectionState>(
                builder: (BuildContext context, state) => state.isActive
                    ? const Text("Internet connection")
                    : const Text("No Internet connection")),
          ),
          body: Column(
            children: [
              const SizedBox(
                height: 10,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  ElevatedButton(
                    onPressed: () {
                      bloc.add(Load());
                    },
                    style: const ButtonStyle(
                      backgroundColor: MaterialStatePropertyAll(Colors.green),
                    ),
                    child: const Text("Load"),
                  ),
                  const SizedBox(
                    width: 10,
                  ),
                  ElevatedButton(
                    onPressed: () {
                      bloc.add(Clear());
                    },
                    style: const ButtonStyle(
                      backgroundColor: MaterialStatePropertyAll(Colors.red),
                    ),
                    child: const Text("Clear"),
                  ),
                ],
              ),
              const SizedBox(
                height: 30,
              ),
              Expanded(
                child: BlocBuilder<BlocModel, States>(
                  builder: ((context, state) {
                    if (state is Empty) {
                      return Container();
                    }
                    if (state is Loading) {
                      return const Center(
                        child: CircularProgressIndicator(),
                      );
                    }
                    if (state is Loaded) {
                      return ListView.builder(
                          itemCount: state.users.length,
                          itemBuilder: (context, index) {
                            return ListTile(
                              leading: Text("${state.users[index].id}"),
                              title: Text(state.users[index].name),
                              subtitle: Text(state.users[index].address),
                            );
                          });
                    }
                    if (state is ErrorState) {
                      return const Center(
                        child: Text('Error, no data has been fetched'),
                      );
                    }
                    return SizedBox.shrink();
                  }),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
