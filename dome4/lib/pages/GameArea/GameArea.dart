import 'package:flutter/material.dart';
import 'package:dome2/services/GameArea_service.dart';
import 'package:just_audio/just_audio.dart';

final AudioPlayer globalAudioPlayer = AudioPlayer();

class GameArea extends StatefulWidget {
  final int userGoal;

  GameArea({required this.userGoal});

  @override
  _GameAreaState createState() => _GameAreaState();
}

class _GameAreaState extends State<GameArea> {
  List<Clothing> clothingList = [];
  List<Clothing> filteredClothingList = [];
  int selectedClothingIndex = 0;
  String selectedGender = "women"; // 默认显示女装
  String selectedEraTag = ""; // 选中的朝代标签
  String selectedStyleTag = ""; // 选中的风格标签
  late AudioPlayer _audioPlayer;

  @override
  void initState() {
    super.initState();
    _audioPlayer = AudioPlayer();
    _initAudio();
    _fetchClothing(); // 初始化加载默认女装
  }

  Future<void> _initAudio() async {
    try {
      await _audioPlayer.setAsset('assets/audio/game.mp3');
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

  Future<void> _fetchClothing() async {
    try {
      final clothing;
      switch (selectedGender) {
        case "women":
          clothing = await fetchWomenClothing();
          break;
        case "men":
          clothing = await fetchMenClothing();
          break;
        default:
          throw ArgumentError("Invalid gender");
      }
      setState(() {
        clothingList = clothing;
        filteredClothingList = clothing; // 初始化时，过滤列表与完整列表相同
        if (clothing.isNotEmpty) {
          selectedClothingIndex = 0; // 重置选中索引
        }
      });
    } catch (error) {
      print(error);
    }
  }

  void _filterClothing() {
    // 根据朝代和风格筛选服装
    setState(() {
      filteredClothingList = clothingList.where((clothing) {
        return (selectedEraTag.isEmpty || clothing.eraTag == selectedEraTag) &&
            (selectedStyleTag.isEmpty || clothing.styleTag == selectedStyleTag);
      }).toList();
      if (filteredClothingList.isNotEmpty) {
        selectedClothingIndex = 0; // 重置选中索引
      } else {
        selectedClothingIndex = -1; // 如果筛选后列表为空，设置一个无效的索引
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('换装游戏'),
      ),
      body: Column(
        children: <Widget>[
          // 性别切换按钮
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              ElevatedButton(
                onPressed: () {
                  setState(() {
                    selectedGender =
                        selectedGender == "women" ? "men" : "women";
                    _fetchClothing(); // 根据新的性别重新加载数据
                  });
                },
                child: Text(selectedGender == "women" ? '女' : '男'),
              ),
            ],
          ),
          // 朝代和风格的下拉菜单
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Text('选择朝代: '),
              DropdownButton<String>(
                value: selectedEraTag,
                onChanged: (String? newValue) {
                  setState(() {
                    selectedEraTag = newValue ?? "";
                    _filterClothing(); // 根据新的朝代标签筛选数据
                  });
                },
                items: <String>['', '唐代', '宋代', '明代', '清代']
                    .map<DropdownMenuItem<String>>((String value) {
                  return DropdownMenuItem<String>(
                    value: value,
                    child: Text(value),
                  );
                }).toList(),
              ),
              SizedBox(width: 20),
              Text('选择风格: '),
              DropdownButton<String>(
                value: selectedStyleTag,
                onChanged: (String? newValue) {
                  setState(() {
                    selectedStyleTag = newValue ?? "";
                    _filterClothing(); // 根据新的风格标签筛选数据
                  });
                },
                items: <String>['', '豪放', '婉约', '文雅', '端庄']
                    .map<DropdownMenuItem<String>>((String value) {
                  return DropdownMenuItem<String>(
                    value: value,
                    child: Text(value),
                  );
                }).toList(),
              ),
            ],
          ),
          // 服装展示和标签滑动区域
          Expanded(
            child: Row(
              children: [
                Expanded(
                  flex: 2, // 增加人物图像的占比
                  child: Container(
                    width: 500, // 增大人物图像的宽度
                    height: 600, // 增大人物图���的高度
                    child: filteredClothingList.isNotEmpty &&
                            selectedClothingIndex >= 0 &&
                            selectedClothingIndex < filteredClothingList.length
                        ? Column(
                            children: [
                              Image.network(
                                filteredClothingList[selectedClothingIndex].url,
                                fit: BoxFit.cover,
                              ),
                              Text(filteredClothingList[selectedClothingIndex]
                                  .name), // 显示服装名称
                            ],
                          )
                        : Center(
                            child: Text('暂无服装数据'),
                          ),
                  ),
                ),
                Expanded(
                  flex: 1, // 减少标签区域的占比
                  child: SingleChildScrollView(
                    child: Padding(
                      padding: const EdgeInsets.all(20.0),
                      child: Wrap(
                        spacing: 10.0, // 水平间距
                        runSpacing: 10.0, // 垂直间距
                        children: filteredClothingList.map((clothing) {
                          int index = filteredClothingList.indexOf(clothing);
                          bool isUnlocked = widget.userGoal >=
                              clothing.goal; // 使用传递过来的 userGoal
                          return ElevatedButton(
                            onPressed: isUnlocked
                                ? () {
                                    setState(() {
                                      selectedClothingIndex = index;
                                    });
                                  }
                                : null, // 如果未解锁，按钮不可用
                            child: Text(
                                '${clothing.eraTag} - ${clothing.styleTag}'),
                          );
                        }).toList(),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
