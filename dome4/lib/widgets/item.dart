import 'package:flutter/material.dart';
import '../pages/HtmlContentPage.dart';

class Item extends StatelessWidget {
final String url;
final String title;
final String htmlContent;

Item({required this.url, required this.title, required this.htmlContent});

@override
Widget build(BuildContext context) {
  return InkWell(
    onTap: () {
      // 导航到新的 HtmlContentPage 页面
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => HtmlContentPage(
            title: title,
            htmlContent: htmlContent,
          ),
        ),
      );

      print('Clicked on $title');
    },
    child: Card(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          AspectRatio(
            aspectRatio: 16 / 9,
            child: Image.network(
              url,
              errorBuilder: (context, error, stackTrace) {
                return Icon(Icons.broken_image, size: 50.0);
              },
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Text(
              title,
              style: TextStyle(fontSize: 18),
            ),
          ),
        ],
      ),
    ),
  );
}
}