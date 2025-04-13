import 'package:flutter/material.dart';
import 'dart:async';
import 'dart:math'; // 用于生成随机数
import 'package:just_audio/just_audio.dart';
import '../../services/CompetitionArea_service.dart';
import '../../services/UpdateGoal_service.dart';
import '../../services/login_service.dart';
import '../home_page.dart';

// 假设 Problem 类已经被定义



class CompetitionArea extends StatefulWidget {
  @override
  _CompetitionAreaState createState() => _CompetitionAreaState();
}

class _CompetitionAreaState extends State<CompetitionArea> {
  List<Problem>? _allProblems; // 存储所有的题目
  List<Problem>? _problems; // 存储筛选后的题目
  int _currentQuestionIndex = 0;
  Timer? _timer;
  int _remainingTime = 120; // 120 seconds
  int _correctAnswersCount = 0; // 正确答案计数器
  late AudioPlayer _audioPlayer;

  @override
  void initState() {
    super.initState();
    _audioPlayer = AudioPlayer();
    _initAudio();
    fetchProblems().then((allProblems) {
      setState(() {
        _allProblems = allProblems;
        _problems = _shuffleAndSelectProblems(_allProblems!, 50);
      });
      _startTimer();
    }).catchError((error) {
      _showAlert('加载问题失败: $error');
    });
  }

  Future<void> _initAudio() async {
    try {
      await _audioPlayer.setAsset('assets/audio/know.mp3');
      _audioPlayer.play();
    } catch (e) {
      print("音频加载失败: $e");
    }
  }

  List<Problem> _shuffleAndSelectProblems(
      List<Problem> allProblems, int count) {
    final random = Random();
    var shuffled = List<Problem>.from(allProblems)..shuffle(random);
    return shuffled.take(count).toList();
  }

  void _startTimer() {
    const oneSec = Duration(seconds: 1);
    _timer = Timer.periodic(
      oneSec,
      (Timer timer) {
        if (_remainingTime == 0) {
          print('_startTimer: Time is up, showing final score.');
          _timer?.cancel(); // 确保在显示最终得分之前取消定时器
          _showFinalScore(); // 显示最终得分并停止答题
        } else {
          setState(() {
            _remainingTime--;
          });
        }
      },
    );
  }

  void _checkAnswer(String selectedAnswer) {
    final currentProblem = _problems![_currentQuestionIndex];
    if (selectedAnswer == currentProblem.answer) {
      _showAlert('回答正确！');
      _correctAnswersCount++; // 答案正确时增加计数
    } else {
      _showAlert(
          '回答错误！\n正确答案是：${currentProblem.answer}\n解析：\n${currentProblem.analysis}');
    }
    _nextQuestion();
  }

  Future<void> _nextQuestion() async {
    if (_currentQuestionIndex < _problems!.length - 1) {
      print(
          '_nextQuestion: Moving to next question. Current index: $_currentQuestionIndex');
      setState(() {
        _currentQuestionIndex++;
      });
    } else {
      print(
          '_nextQuestion: All questions answered, showing final score. Correct answers: $_correctAnswersCount');
      // 确保在显示最终得分之前取消定时器
      _timer?.cancel();

      final loginService = LoginService();
      final username = await loginService.getUsername();
      final updateGoalService = UpdateGoalService();
      await updateGoalService.updateGoal(username!, _correctAnswersCount);
      _showFinalScore(); // 所有问题答完后显示最终得分
    }
  }

  void _showFinalScore() {
    print(
        '_showFinalScore: Showing final score. Correct answers: $_correctAnswersCount');
    // 显示最终得分并停止答题
    _showAlert('时间到！\n您总共答对了 $_correctAnswersCount 道题。', navigateToHome: true);
  }

  void _showAlert(String message, {bool navigateToHome = false}) {
    showDialog(
      context: context,
      barrierDismissible: false, // 禁止点击背景关闭对话框
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('提示', style: TextStyle(fontSize: 24)),
          content: SingleChildScrollView(
            child: Text(message, style: TextStyle(fontSize: 20)),
          ),
          actions: <Widget>[
            TextButton(
              child: Text('确定', style: TextStyle(fontSize: 20)),
              onPressed: () {
                Navigator.of(context).pop(); // 关闭当前对话框
                if (navigateToHome) {
                  Navigator.pushReplacement(
                    context,
                    MaterialPageRoute(builder: (context) => HomePage()),
                  );
                }
              },
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    if (_problems == null) {
      return Scaffold(
        appBar: AppBar(title: Text('竞技区')),
        body: Center(child: CircularProgressIndicator()),
      );
    }

    final currentProblem = _problems![_currentQuestionIndex];
    final questionNumber = _currentQuestionIndex + 1; // 当前问题是第几题

    return Scaffold(
      appBar: AppBar(
        title: Text('竞技区'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Text(
              '剩余时间: $_remainingTime 秒',
              style: TextStyle(fontSize: 28),
            ),
            SizedBox(height: 20), // 增加时间和问题之间的间距
            Text(
              '$questionNumber. ${currentProblem.question}',
              style: TextStyle(fontSize: 24),
            ),
            SizedBox(height: 20), // 增加问题和选项之间的间距
            Expanded(
              child: ListView(
                children: [
                  ...[
                    'A: ${currentProblem.answer1}',
                    'B: ${currentProblem.answer2}',
                    'C: ${currentProblem.answer3}',
                    'D: ${currentProblem.answer4}',
                  ].map((answer) {
                    final letter = answer.substring(0, 1); // 提取选项字母
                    final option = answer.substring(3); // 提取答案文本
                    return Padding(
                      padding: const EdgeInsets.symmetric(vertical: 8.0),
                      child: ElevatedButton(
                        onPressed: () => _checkAnswer(option),
                        child: Row(
                          children: [
                            Text(letter, style: TextStyle(fontSize: 20)),
                            SizedBox(width: 8), // 可选：增加一些间距
                            Expanded(
                                child: Text(option,
                                    style:
                                        TextStyle(fontSize: 20))), // 将字体大小调整为20
                          ],
                        ),
                      ),
                    );
                  }).toList(),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  @override
  void dispose() {
    _timer?.cancel();
    _audioPlayer.dispose();
    super.dispose();
  }
}
