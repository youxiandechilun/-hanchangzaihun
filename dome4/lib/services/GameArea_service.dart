import 'dart:convert';
import 'package:http/http.dart' as http;

class Clothing {
  final int id;
  final String url;
  final String eraTag;
  final String styleTag;
  final int goal;
  final String name;

  Clothing({
    required this.id,
    required this.url,
    required this.eraTag,
    required this.styleTag,
    required this.goal,
    required this.name,
  });

  factory Clothing.fromJson(Map<String, dynamic> json) {
    return Clothing(
      id: json['id'],
      url: json['url'],
      eraTag: json['eraTag'],
      styleTag: json['styleTag'],
      goal: json['goal'],
      name: json['name'],
    );
  }
}

Future<List<Clothing>> fetchMenClothing() async {
  return _fetchClothing(url: 'http://8.140.229.104:9091/clothing/selectAll2');
}

Future<List<Clothing>> fetchWomenClothing() async {
  return _fetchClothing(url: 'http://8.140.229.104:9091/clothing/selectAll1');
}

Future<List<Clothing>> _fetchClothing(
    {required String url, String eraTag = "", String styleTag = ""}) async {
  final response = await http.post(
    Uri.parse(url),
    headers: {'Content-Type': 'application/json; charset=utf-8'},
    body: jsonEncode(<String, String>{
      'eraTag': eraTag,
      'styleTag': styleTag,
    }),
  );

  if (response.statusCode == 200) {
    String responseBody = utf8.decode(response.bodyBytes);
    final Map<String, dynamic> responseBodyMap = jsonDecode(responseBody);
    final List<dynamic> body = responseBodyMap['data'];

    return body.map((dynamic item) => Clothing.fromJson(item)).toList();
  } else {
    throw Exception('Failed to load clothing data');
  }
}
