import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../pages/home_page.dart';
import '../pages/login_page.dart';

class LoginService {

  // 保存登录状态和用户名
  Future<void> saveLoginStatusAndUsername(bool isLoggedIn, String username) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setBool('isLoggedIn', isLoggedIn);
    await prefs.setString('username', username); // 保存用户名
  }

  // 检查登录状态
  Future<bool> checkLoginStatus() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getBool('isLoggedIn') ?? false;
  }

  // 获取保存的用户名
  Future<String?> getUsername() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getString('username');
  }

  // 退出登录
  Future<void> logout(BuildContext context) async {
    final prefs = await SharedPreferences.getInstance();
    // 清除登录状态和用户名
    await prefs.setBool('isLoggedIn', false);
    await prefs.remove('username');

    // 显示退出成功的对话框（可选）
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('退出成功'),
          content: Text('您已成功退出！'),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop(); // 关闭对话框
                // 跳转到登录页面或其他适当页面
                Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(builder: (context) => LoginPage()), // 确保LoginPage已定义
                );
              },
              child: Text('确定'),
            ),
          ],
        );
      },
    );
  }




  // 登录方法
  Future<void> login(BuildContext context, String username, String password) async {
    final Dio dio = Dio();
    final String checkUrl = "http://8.140.229.104:9091/login";

    final Map<String, dynamic> data = {
      "username": username,
      "password": password,
    };

    try {
      final Response response = await dio.post(checkUrl, data: data);

      if (response.statusCode == 200) {
        final Map<String, dynamic> responseData = response.data;

        if (responseData['code'] == '200') {
          // 保存登录状态为 true 并保存用户名
          await saveLoginStatusAndUsername(true, username);

          // 登录成功，显示成功对话框并跳转到主页
          showDialog(
            context: context,
            builder: (BuildContext context) {
              return AlertDialog(
                title: Text('登录成功'),
                content: Text('欢迎回来！'),
                actions: [
                  TextButton(
                    onPressed: () {
                      Navigator.of(context).pop(); // 关闭对话框
                      // 登录成功后跳转到主页或其他页面
                      Navigator.pushReplacement(
                        context,
                        MaterialPageRoute(builder: (context) => HomePage()), // 确保HomePage已定义
                      );
                    },
                    child: Text('确定'),
                  ),
                ],
              );
            },
          );
        } else {
          // 业务逻辑上的失败，显示错误消息
          showDialog(
            context: context,
            builder: (BuildContext context) {
              return AlertDialog(
                title: Text('登录失败'),
                content: Text('${responseData['msg']}'), // 显示具体的错误信息
                actions: [
                  TextButton(
                    onPressed: () {
                      Navigator.of(context).pop(); // 关闭对话框
                    },
                    child: Text('确定'),
                  ),
                ],
              );
            },
          );
        }
      } else {
        // HTTP请求失败
        throw Exception('HTTP请求失败，状态码: ${response.statusCode}');
      }
    } catch (e) {
      // 处理异常
      print('发生错误: $e');
      // 显示网络错误或其它错误消息
      showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: Text('登录失败'),
            content: Text('发生了一个错误，请稍后再试。'),
            actions: [
              TextButton(
                onPressed: () {
                  Navigator.of(context).pop(); // 关闭对话框
                },
                child: Text('确定'),
              ),
            ],
          );
        },
      );
    }
  }
}