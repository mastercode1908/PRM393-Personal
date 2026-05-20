import 'dart:convert';

// Class User
class User {
  final String name;
  final String email;

  User({required this.name, required this.email});

  // Factory constructor
  factory User.fromJson(Map<String, dynamic> json) {
    return User(name: json['name'], email: json['email']);
  }

  @override
  String toString() {
    return 'User(name: $name, email: $email)';
  }
}

// Repository giả lập gọi API
class UserRepository {
  Future<List<User>> fetchUsers() async {
    await Future.delayed(Duration(seconds: 1));

    const jsonString = '''
    [
      {"name": "Duc", "email": "chutheduc@gmail.com"},
      {"name": "Test", "email": "test@gmail.com"}
    ]
    ''';

    // Chuyen json sang List<Dynamic>
    final List<dynamic> jsonData = jsonDecode(jsonString);

    // Map sang User
    return jsonData.map((item) => User.fromJson(item)).toList();
  }
}

Future<void> main() async {
  final repository = UserRepository();

  print('Danh sach ng dung');

  final users = await repository.fetchUsers();

  for (var user in users) {
    print(user);
  }
}
