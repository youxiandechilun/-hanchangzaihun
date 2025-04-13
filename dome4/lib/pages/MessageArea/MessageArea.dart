import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../../services/MessageAreaState_service.dart';

class MessageArea extends StatefulWidget {
  @override
  _MessageAreaState createState() => _MessageAreaState();
}

Future<String?> getUsername() async {
  final prefs = await SharedPreferences.getInstance();
  return prefs.getString('username');
}

class _MessageAreaState extends State<MessageArea> {
  double _rating = 0.0;
  final TextEditingController _textEditingController = TextEditingController();
  final MessageareaStateService _service = MessageareaStateService();

  void _submitReview() async {
    String? username = await getUsername();
    if (username == null) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('请先登录！')),
      );
      return;
    }

    int category = (_rating * 2).toInt(); // 半颗星算作1分
    String reviewText = _textEditingController.text;

    try {
      await _service.SubMessagearea(context, username, category, reviewText);
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('感谢您的评价！')),
      );
    } catch (e) {
      print('Error: $e');
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('提交失败，请重试！')),
      );
    }

    // 清空输入框
    _textEditingController.clear();
    setState(() {
      _rating = 0.0; // 重置评分
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('留言区'),
      ),
      body: Container(
        width: double.infinity,
        height: double.infinity,
        decoration: BoxDecoration(
          image: DecorationImage(
            image: NetworkImage(
                'http://8.140.229.104:9091/files/download?filename=zsqback.png'),
            fit: BoxFit.cover,
          ),
        ),
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: <Widget>[
              Text(
                '请选择您的评分',
                style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                    color: Colors.black),
              ),
              SizedBox(height: 16.0),
              RatingBar.builder(
                initialRating: _rating,
                minRating: 1,
                direction: Axis.horizontal,
                allowHalfRating: true,
                itemCount: 5,
                itemPadding: EdgeInsets.symmetric(horizontal: 4.0),
                itemBuilder: (context, _) => Icon(
                  Icons.star,
                  color: Colors.amber,
                ),
                onRatingUpdate: (rating) {
                  setState(() {
                    _rating = rating;
                  });
                },
              ),
              SizedBox(height: 32.0),
              TextField(
                controller: _textEditingController,
                maxLines: 5,
                decoration: InputDecoration(
                  labelText: '请输入您的评论',
                  labelStyle: TextStyle(color: Colors.black),
                  border: OutlineInputBorder(),
                  enabledBorder: OutlineInputBorder(
                    borderSide: BorderSide(color: Colors.grey),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderSide: BorderSide(color: Colors.grey),
                  ),
                ),
              ),
              SizedBox(height: 16.0),
              ElevatedButton(
                onPressed: _rating > 0 ? _submitReview : null,
                child: Text('提交评价', style: TextStyle(color: Colors.white)),
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.grey[500],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
