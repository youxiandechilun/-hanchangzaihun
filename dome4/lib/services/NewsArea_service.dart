import 'dart:async';
import 'package:http/http.dart' as http;
import 'dart:convert';

class NewsData {
  final String title;
  final String content;
  final String url;

  NewsData({
    required this.title,
    required this.content,
    required this.url,
  });

  // 从 JSON 数据中创建 NewsData 实例
  factory NewsData.fromJson(Map<String, dynamic>? json) {
    if (json == null) {
      throw ArgumentError('JSON data is null');
    }
    return NewsData(
      title: json['title'] as String? ?? '',
      content: json['content'] as String? ?? '',
      url: json['url'] as String? ?? '',
    );
  }
}

// 异步函数，用于从服务器获取数据
Future<List<NewsData>> fetchData() async {
  var url = Uri.parse('http://8.140.229.104:9091/news/selectAll');
  var headers = {'Accept': 'application/json; charset=utf-8'};

  try {
    final response = await http.get(url, headers: headers);

    if (response.statusCode == 200) {
      final data = json.decode(response.body);
      final NewsDataList = data['data'] as List<dynamic>;

      print(NewsDataList);

      // 将列表中的每个 JSON 对象转换为 KnowledgeData 实例
      return NewsDataList.map((item) => NewsData.fromJson(item)).toList();
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