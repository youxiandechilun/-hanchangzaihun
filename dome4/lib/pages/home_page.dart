import 'package:flutter/material.dart';
import 'package:just_audio/just_audio.dart';

import '../services/User_service.dart';
import '../services/login_service.dart';
import 'CompetitionArea/CompetitionArea.dart';
import 'GameArea/GameArea.dart';
import 'KnowledgeArea/KnowledgeArea.dart';
import 'MessageArea/MessageArea.dart';
import 'NewsArea/NewsArea.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  late AudioPlayer _audioPlayer; // 创建 AudioPlayer 实例
  double _musicVolume = 0.5;
  String? _username;
  String? _name;
  int? _goal;

  @override
  void initState() {
    super.initState();
    _audioPlayer = AudioPlayer(); // 初始化 AudioPlayer
    _playMusic(); // 页面初始化时播放音乐
    _fetchUsernameAndUserDetails(); // 获取用户名及用户详细信息
  }

  Future<void> _playMusic() async {
    await _audioPlayer.setVolume(_musicVolume);
    final audioFile = 'assets/audio/home.mp3';
    await _audioPlayer.setAsset(audioFile);
    await _audioPlayer.setLoopMode(LoopMode.all);
    await _audioPlayer.play();
  }

  Future<void> _fetchUsernameAndUserDetails() async {
    // 假设这是你的服务类实例
    final loginService = LoginService();
    final userService = UserService();

    final username = await loginService.getUsername();
    setState(() {
      _username = username;
    });

    if (_username != null) {
      try {
        final user = await userService.getUserByUsername(_username!);
        setState(() {
          _name = user.name;
          _goal = user.goal as int?;
        });
      } catch (e) {
        print('Error fetching user details: $e');
      }
    }
  }

  @override
  void dispose() {
    _audioPlayer.dispose(); // 清理资源
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: <Widget>[
          Container(
            decoration: BoxDecoration(
              image: DecorationImage(
                image: NetworkImage('http://8.140.229.104:9091/files/download?filename=home1.png'),
                fit: BoxFit.cover,
              ),
            ),
          ),
          Builder(
            builder: (BuildContext context) {
              return Positioned(
                top: MediaQuery.of(context).padding.top - 20,
                left: MediaQuery.of(context).size.width * 0.1 - 40,
                child: IconButton(
                  icon: Icon(Icons.settings, color: Color.fromRGBO(50, 180, 34, 0.7), size: 48.0),
                  onPressed: () {
                    Scaffold.of(context).openDrawer();
                  },
                ),
              );
            },
          ),
          Positioned(
            top: MediaQuery.of(context).size.height * 0.01 ,
            left: MediaQuery.of(context).size.width * 0.28 ,
            child: GestureDetector(
              onTap: () {
                // 点击flag1跳转到留言区页面
                _audioPlayer.pause(); // 暂停音乐
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => MessageArea()),
                ).then((_) => _playMusic()); // 返回主页时播放音乐
              },
              child: Image(
                image: NetworkImage('http://8.140.229.104:9091/files/download?filename=flag1.png'),
                width: MediaQuery.of(context).size.width * 0.3, // 设置宽度
                height: MediaQuery.of(context).size.width * 0.3, // 设置高度
              ),
            ),
          ),
          Positioned(
            top: MediaQuery.of(context).size.height * 0.13,
            left: MediaQuery.of(context).size.width * 0.15,
            child: GestureDetector(
              onTap: () {
                // 点击flag2跳转到竞技区页面
                _audioPlayer.pause(); // 暂停音乐
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => CompetitionArea()),
                ).then((_) => _playMusic()); // 返回主页时播放音乐
              },
              child: Image(
                image: NetworkImage('http://8.140.229.104:9091/files/download?filename=flag2.png'),
                width: MediaQuery.of(context).size.width * 0.4, // 设置宽度
                height: MediaQuery.of(context).size.width * 0.4, // 设置高度
              ),
            ),
          ),
          Positioned(
            top: MediaQuery.of(context).size.height * 0.15,
            left: MediaQuery.of(context).size.width * 0.85,
            child: GestureDetector(
              onTap: () {
                // 点击flag3跳转到新闻区页面
                _audioPlayer.pause(); // 暂停音乐
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => NewsArea()),
                ).then((_) => _playMusic()); // 返回主页时播放音乐
              },
              child: Image(
                image: NetworkImage('http://8.140.229.104:9091/files/download?filename=flag3.png'),
                width: MediaQuery.of(context).size.width * 0.25, // 设置宽度
                height: MediaQuery.of(context).size.height * 0.25, // 设置高度
              ),
            ),
          ),
          Positioned(
            top: MediaQuery.of(context).size.height * 0.33,
            left: MediaQuery.of(context).size.width * 0.35,
            child: GestureDetector(
              onTap: () {
                // 点击flag4跳转到知识区页面
                _audioPlayer.pause(); // 暂停音乐
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => KnowledgeArea()),
                ).then((_) => _playMusic()); // 返回主页时播放音乐
              },
              child: Image(
                image: NetworkImage('http://8.140.229.104:9091/files/download?filename=flag4.png'),
                width: MediaQuery.of(context).size.width * 0.2, // 设置宽度
                height: MediaQuery.of(context).size.height * 0.2, // 设置高度
              ),
            ),
          ),
          Positioned(
            top: MediaQuery.of(context).size.height * 0.73,
            left: MediaQuery.of(context).size.width * 0.7,
            child: GestureDetector(
              onTap: () {
                // 点击flag5跳转到游戏区页面
                _audioPlayer.pause(); // 暂停音乐
                Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => GameArea(userGoal: _goal ?? 0)),
                ).then((_) => _playMusic()); // 返回主页时播放音乐
              },
              child: Image(
                image: NetworkImage('http://8.140.229.104:9091/files/download?filename=flag5.png'),
                width: MediaQuery.of(context).size.width * 0.25, // 设置宽度
                height: MediaQuery.of(context).size.height * 0.25, // 设置高度
              ),
            ),
          ),
        ],
      ),
      drawer: Drawer(
        child: ListView(
          padding: EdgeInsets.zero,
          children: <Widget>[
            UserAccountsDrawerHeader(
              accountName: Text(_name ?? '未登录', style: TextStyle(fontSize: 40.0)),
              accountEmail: _username != null ? Text(_username!) : null,
              currentAccountPicture: null,
              decoration: BoxDecoration(color: Colors.green),
            ),
            ListTile(
              leading: Icon(Icons.person),
              title: Text('个人分数：$_goal'),
            ),
            Divider(),
            ListTile(
              leading: Icon(Icons.volume_up),
              title: Text('音量调节'),
              subtitle: Slider(
                value: _musicVolume,
                min: 0.0,
                max: 1.0,
                divisions: 10,
                label: '${(_musicVolume * 100).round()}%',
                onChanged: (double value) {
                  setState(() {
                    _musicVolume = value;
                  });
                  _audioPlayer.setVolume(value); // 调整音量
                },
              ),
            ),
            Divider(),
            ListTile(
              leading: Icon(Icons.exit_to_app),
              title: Text('退出登录'),
              onTap: () async {
                final loginService = LoginService();
                await loginService.logout(context);
              },
            ),
          ],
        ),
      ),
    );
  }
}