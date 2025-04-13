import 'dart:async';
import 'package:http/http.dart' as http;
import 'dart:convert';

class Problem {
  final int id;
  final String question;
  final String answer;
  final String answer1;
  final String answer2;
  final String answer3;
  final String answer4;
  final String analysis;

  Problem({
    required this.id,
    required this.question,
    required this.answer,
    required this.answer1,
    required this.answer2,
    required this.answer3,
    required this.answer4,
    required this.analysis,
  });

  // 从 JSON 数据中创建 Problem 实例
  factory Problem.fromJson(Map<String, dynamic>? json) {
    if (json == null) {
      throw ArgumentError('JSON data is null');
    }
    return Problem(
      id: json['id'] as int? ?? -1,
      question: json['question'] as String? ?? '',
      answer: json['answer'] as String? ?? '',
      answer1: json['answer1'] as String? ?? '',
      answer2: json['answer2'] as String? ?? '',
      answer3: json['answer3'] as String? ?? '',
      answer4: json['answer4'] as String? ?? '',
      analysis: json['analysis'] as String? ?? '',
    );
  }
}

// 异步函数，用于从服务器获取数据
Future<List<Problem>> fetchProblems() async {
  var url = Uri.parse('http://8.140.229.104:9091/problem/selectAll');
  var headers = {'Accept': 'application/json; charset=utf-8'};

  try {
    final response = await http.get(url, headers: headers);

    if (response.statusCode == 200) {
      final data = json.decode(response.body);
      final problemList = data['data'] as List<dynamic>;

      return problemList.map((item) => Problem.fromJson(item)).toList();
    } else {
      throw Exception('请求失败，状态码: ${response.statusCode}');
    }
  } on TimeoutException catch (_) {
    throw Exception('请求超时');
  } on FormatException catch (_) {
    throw Exception('JSON 解析失败');
  } catch (e) {
    throw Exception('获取数据失败: $e');
  }
}