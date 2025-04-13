import 'package:http/http.dart' as http;

class UpdateGoalService {
  Future<void> updateGoal(String username, int num) async {
    for (int i = 0; i < num; i++) {
      try {
        final response = await http.get(Uri.parse('http://8.140.229.104:9091/problem/update/$username'));
        if (response.statusCode == 200) {
          print('成功更新目标');
        } else {
          print('更新目标失败，状态码: ${response.statusCode}');
        }
      } catch (e) {
        print('发生异常: $e');
      }
    }
  }
}