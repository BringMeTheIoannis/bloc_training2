import 'package:bloc/bloc.dart';
import 'package:block_training_2/bloc/events/events.dart';
import 'package:block_training_2/bloc/states/states.dart';
import 'package:block_training_2/data/data_repo.dart';
import 'package:block_training_2/data/user_model.dart';

class BlocModel extends Bloc<Events, States> {
  DataRepository dataRepository;

  BlocModel({required this.dataRepository}) : super(Empty()) {
    on<Load>((event, emit) async {
      emit(Loading());
      try {
        List<User> listOfUsers = await dataRepository.getData();
        emit(Loaded(users: listOfUsers));
      } catch (_) {
        emit(ErrorState());
      }
    });
    on<Clear>((event, emit) => emit(Empty()));
  }
}
