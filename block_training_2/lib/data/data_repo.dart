import 'package:block_training_2/data/data_get_api.dart';
import 'package:block_training_2/data/user_model.dart';

class DataRepository {
  GetData users = GetData();

  Future<List<User>> getData() {
    return users.getUsers();
  }
}
