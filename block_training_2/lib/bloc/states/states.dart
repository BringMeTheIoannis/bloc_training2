import 'package:block_training_2/data/user_model.dart';

abstract class States {}

class Empty extends States {}

class Loading extends States {}

class Loaded extends States {
  List<User> users;
  Loaded({required this.users});
}

class ErrorState extends States {}
