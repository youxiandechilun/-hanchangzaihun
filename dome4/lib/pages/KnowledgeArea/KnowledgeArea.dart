import 'package:flutter/material.dart';
import 'package:just_audio/just_audio.dart';
import '../../services/KnowledgeArea_service.dart'; // 请确保这个路径是正确的
import '../../widgets/item.dart';

class KnowledgeArea extends StatefulWidget {
  @override
  _KnowledgeAreaState createState() => _KnowledgeAreaState();
}

class _KnowledgeAreaState extends State<KnowledgeArea> {
  late AudioPlayer _audioPlayer;

  @override
  void initState() {
    super.initState();
    _audioPlayer = AudioPlayer();
    _initAudio();
  }

  Future<void> _initAudio() async {
    try {
      await _audioPlayer.setAsset('assets/audio/know.mp3');
      _audioPlayer.play();
    } catch (e) {
      print("音频加载失败: $e");
    }
  }

  @override
  void dispose() {
    _audioPlayer.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final future = fetchData();

    return Scaffold(
      appBar: AppBar(
        title: Text('知识区'),
      ),
      body: FutureBuilder<List<KnowledgeData>>(
        future: future,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.done) {
            if (snapshot.hasData) {
              List<KnowledgeData> data = snapshot.data!;
              print("数据加载完成，共${data.length}条记录。");
              return ListView.builder(
                padding: EdgeInsets.all(8.0),
                itemCount: data.length,
                itemBuilder: (context, index) {
                  return Item(
                    title: data[index].title,
                    htmlContent: data[index].body,
                    url: data[index].url,
                  );
                },
              );
            } else if (snapshot.hasError) {
              print("加载数据时出错: ${snapshot.error}");
              return Center(child: Text('错误: ${snapshot.error}'));
            }
          }
          return Center(child: CircularProgressIndicator());
        },
      ),
    );
  }
}