import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

import '../pages/login_page.dart';

class RegisterService {
  Future<void> register(
      BuildContext context,
      String name,
      String username,
      String password,
      int goal) async {
    try {
      String registerUrl = "http://8.140.229.104:9091/register";
      Map<String, dynamic> data = {
        "name": name,
        "username": username,
        "password": password,
        "goal": goal
      };

      final response = await http.post(
        Uri.parse(registerUrl),
        headers: {'Content-Type': 'application/json'},
        body: json.encode(data), // 将Map转换为JSON字符串
      );

      // 将响应体转换为Map对象
      Map<String, dynamic> responseBody = json.decode(response.body);

      // 打印响应的状态码和响应体
      print('Status code: ${response.statusCode}');
      print('Body: $responseBody');

      if (response.statusCode == 200 && responseBody['code'] == '200') {
        // 注册成功
        _showDialog(context, '注册成功', '请登录', () {
          Navigator.of(context).pop(); // 关闭对话框
          Navigator.of(context).pushReplacement(
            MaterialPageRoute(builder: (context) => LoginPage(key: UniqueKey())),
          );
        });
      } else {
        // 注册失败
        _showDialog(context, '注册失败', '账户已存在', () {
          Navigator.of(context).pop();
        });
      }
    } catch (e) {
      // 请求过程中出现错误
      _showDialog(context, '请求错误', e.toString(), () {
        Navigator.of(context).pop();
      });
    }
  }

  void _showDialog(BuildContext context, String title, String message, VoidCallback onPressed) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text(title),
          content: Text(message),
          actions: <Widget>[
            TextButton(
              onPressed: onPressed,
              child: Text('确定'),
            ),
          ],
        );
      },
    );
  }
}