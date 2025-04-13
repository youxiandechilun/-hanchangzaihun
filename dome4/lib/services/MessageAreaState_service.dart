import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert'; // 导入dart:convert以处理JSON

class MessageareaStateService {
  Future<void> SubMessagearea(
    BuildContext context,
    String username,
    int category,
    String content,
  ) async {
    try {
      String registerUrl = "http://8.140.229.104:9091/message/add";
      Map<String, dynamic> data = {
        'username': username,
        'category': category,
        'content': content,
      };

      final response = await http.post(
        Uri.parse(registerUrl),
        headers: {'Content-Type': 'application/json; charset=utf-8'},
        body: jsonEncode(data), // 将Map转换为JSON字符串
      );

      // 检查响应状态码
      if (response.statusCode == 200) {
        // 请求成功
        // 将响应体转换为UTF-8编码的字符串
        String responseBody = utf8.decode(response.bodyBytes);

        Map<String, dynamic> jsonResponse = jsonDecode(responseBody);
        // 使用jsonResponse，例如打印某个字段
        print('Response data: ${jsonResponse['someKey']}');
      } else {
        // 如果服务器返回错误（例如状态码400或500）
        throw Exception('Failed to load post: ${response.statusCode}');
      }
    } catch (e) {
      // 处理异常
      print('Error: $e');
      // 可以在这里显示一个错误消息给用户
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('提交失败，请重试！')),
      );
    }
  }
}
