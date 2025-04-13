import 'dart:async';
import 'package:http/http.dart' as http;
import 'dart:convert';

class KnowledgeData {
  final String title;
  final String body;
  final String url;

  KnowledgeData({
    required this.title,
    required this.body,
    required this.url,
  });

  // 从 JSON 数据中创建 KnowledgeData 实例
  factory KnowledgeData.fromJson(Map<String, dynamic>? json) {
    if (json == null) {
      throw ArgumentError('JSON data is null');
    }
    return KnowledgeData(
      title: json['title'] as String? ?? '',
      body: json['body'] as String? ?? '',
      url: json['url'] as String? ?? '',
    );
  }
}

// 异步函数，用于从服务器获取数据
Future<List<KnowledgeData>> fetchData() async {
  var url = Uri.parse('http://8.140.229.104:9091/knowledge/selectAll');
  var headers = {'Accept': 'application/json; charset=utf-8'};

  try {
    final response = await http.get(url, headers: headers);

    if (response.statusCode == 200) {
      final data = json.decode(response.body);
      final knowledgeDataList = data['data'] as List<dynamic>;

      // 将列表中的每个 JSON 对象转换为 KnowledgeData 实例
      return knowledgeDataList.map((item) => KnowledgeData.fromJson(item)).toList();
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