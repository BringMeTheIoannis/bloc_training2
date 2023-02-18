import 'dart:convert';
import 'package:http/http.dart' as http;

import 'package:block_training_2/data/user_model.dart';

class GetData {
  String url = 'https://jsonplaceholder.typicode.com/users';

  Future<List<User>> getUsers() async {
    var response = await http.get(Uri.parse(url));

    if (response.statusCode == 200) {
      final List<dynamic> data = jsonDecode(response.body);
      return data.map((element) => User.fromJson(element)).toList();
    } else {
      throw Exception("Error of receiveng data");
    }
  }
}
