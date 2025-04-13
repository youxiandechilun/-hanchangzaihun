import 'dart:convert';
import 'package:http/http.dart' as http;

class User {
  final String name;
  final String username;
  final String password;
  final int goal;

  User({
    required this.name,
    required this.username,
    required this.password,
    required this.goal, // 不需要 required，因为它是可空的
  });

  factory User.fromJson(Map<String, dynamic> json) {
    return User(
      name: json['name'],
      username: json['username'],
      password: json['password'],
      goal: json['goal'] is int ? json['goal'] : null, // 检查是否为整数
    );
  }
}

class UserService {
  // 获取用户信息的函数
  Future<User> getUserByUsername(String username) async {
    final response = await http.get(
      Uri.http('8.140.229.104:9091', '/selectByUsername/$username'),
      headers: {
        'Accept': 'application/json; charset=utf-8', // 指定接受的字符编码
      },
    );


    if (response.statusCode == 200) {
      final jsonResponse = json.decode(response.body);
      if (jsonResponse.containsKey('data') && jsonResponse['data'] != null) {
        return User.fromJson(jsonResponse['data']);
      } else {
        throw Exception('No data found in the response.');
      }
    } else {
      throw Exception('Failed to load user by username: ${response.statusCode}');
    }
  }
}