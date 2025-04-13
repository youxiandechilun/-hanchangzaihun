import 'package:flutter/material.dart';
import 'package:flutter_widget_from_html/flutter_widget_from_html.dart';

class HtmlContentPage extends StatelessWidget {
  final String title;
  final String htmlContent;

  HtmlContentPage({required this.title, required this.htmlContent});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(title),
      ),
      body: SingleChildScrollView(
        child: Container(
          padding: const EdgeInsets.all(16.0),
          child: HtmlWidget(htmlContent),
        ),
        //渲染一个视频播放 http://8.140.229.104:9091/files/stream?filename=11.mp4
      ),
    );
  }
}

