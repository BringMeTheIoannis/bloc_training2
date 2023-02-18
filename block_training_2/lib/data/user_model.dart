class User {
  int id;
  String name;
  String address;

  User({required this.id, required this.name, required this.address});
  factory User.fromJson(data) {
    return User(
        id: data['id'], name: data['name'], address: data['address']['street']);
  }
}
