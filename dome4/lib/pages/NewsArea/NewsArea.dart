import 'package:flutter/material.dart';
import '../../services/NewsArea_service.dart';
import '../../widgets/item.dart';
import 'package:just_audio/just_audio.dart';

class NewsArea extends StatefulWidget {
  @override
  _NewsAreaState createState() => _NewsAreaState();
}

class _NewsAreaState extends State<NewsArea> {
  final AudioPlayer _audioPlayer = AudioPlayer();

  @override
  void initState() {
    super.initState();
    _initAudio(); // 初始化音频
  }

  @override
  Widget build(BuildContext context) {
    // 调用 fetchData 获取数据
    final future = fetchData();

    return Scaffold(
      appBar: AppBar(
        title: Text('新闻区'),
      ),
      body: FutureBuilder<List<NewsData>>(
        future: future, // 直接传递Future对象
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.done) {
            if (snapshot.hasData) {
              List<NewsData> data = snapshot.data!;
              print("数据加载完成，共${data.length}条记录。"); // 打印数据条数
              return ListView.builder(
                padding: EdgeInsets.all(8.0),
                itemCount: data.length,
                itemBuilder: (context, index) {
                  return Item(
                    title: data[index].title,
                    htmlContent: data[index].content,
                    url: data[index].url,
                  );
                },
              );
            } else if (snapshot.hasError) {
              print("加载数据时出错: ${snapshot.error}");
              return Center(child: Text('错误: ${snapshot.error}'));
            }
          }
          // 当数据正在加载时显示一个加载指示器
          return Center(child: CircularProgressIndicator());
        },
      ),
    );
  }

  Future<void> _initAudio() async {
    try {
      await _audioPlayer.setAsset('assets/audio/home.mp3');
      _audioPlayer.play();
    } catch (e) {
      print("音频加载失败: $e");
    }
  }

  @override
  void dispose() {
    _audioPlayer.dispose(); // 在页面销毁时释放资源
    super.dispose();
  }
}