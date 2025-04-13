import 'package:flutter/material.dart';
import 'package:dome2/services/register_service.dart';

class RegisterPage extends StatefulWidget {
  const RegisterPage({super.key});

  @override
  _RegisterPageState createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  final TextEditingController _usernameController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _confirmPasswordController = TextEditingController(); // 新增确认密码控制器

  // 定义 _submitForm 方法
  Future<void> _submitForm(BuildContext context) async {
    String username = _usernameController.text;
    String password = _passwordController.text;
    String confirmPassword = _confirmPasswordController.text; // 获取确认密码
    String name = _nameController.text;
    int goal = 0;

    // 检查输入是否为空
    if (username.isEmpty || password.isEmpty || confirmPassword.isEmpty || name.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('请填写所有必填字段')),
      );
      return;
    }

    // 检查两次输入的密码是否相同
    if (password != confirmPassword) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('两次输入的密码不一致，请重新输入')),
      );
      return;
    }

    try {
      // 调用注册服务
      await RegisterService().register(context, name, username, password, goal);
    } catch (e) {
      // 捕获异常并显示错误对话框
      showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: const Text("注册失败"),
            content: Text(e.toString()), // 显示异常信息
            actions: <Widget>[
              TextButton(
                child: const Text("确定"),
                onPressed: () {
                  Navigator.of(context).pop();
                },
              ),
            ],
          );
        },
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: Stack(
        children: [
          // 全屏背景图片
          Container(
            decoration: BoxDecoration(
              image: DecorationImage(
                image: NetworkImage('http://8.140.229.104:9091/files/stream?filename=background.png'),
                fit: BoxFit.cover,
              ),
            ),
          ),

          SingleChildScrollView( // 添加可滚动视图
            child: Container(
              padding: const EdgeInsets.only(bottom: 20), // 防止键盘遮挡
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  SizedBox(height: 300), // 顶部留白
                  Text(
                    "注册",
                    style: TextStyle(color: Colors.black, fontSize: 40, fontWeight: FontWeight.bold),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(30.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start, // 添加交叉轴对齐方式
                      children: <Widget>[
                        Container(
                          padding: const EdgeInsets.all(8.0),
                          decoration: BoxDecoration(
                            color: Colors.transparent, // 输入框背景透明
                            borderRadius: BorderRadius.circular(10),
                            border: Border.all(color: Colors.grey.withOpacity(0.5)), // 边框颜色和透明度
                          ),
                          child: TextField(
                            controller: _nameController,
                            style: TextStyle(color: Colors.black), // 文本颜色
                            decoration: InputDecoration(
                              border: InputBorder.none,
                              hintText: "请输入昵称",
                              hintStyle: TextStyle(color: Colors.grey[400]),
                            ),
                          ),
                        ),
                        const SizedBox(height: 10),
                        Container(
                          padding: const EdgeInsets.all(8.0),
                          decoration: BoxDecoration(
                            color: Colors.transparent, // 输入框背景透明
                            borderRadius: BorderRadius.circular(10),
                            border: Border.all(color: Colors.grey.withOpacity(0.5)), // 边框颜色和透明度
                          ),
                          child: TextField(
                            controller: _usernameController,
                            style: TextStyle(color: Colors.black), // 文本颜色
                            decoration: InputDecoration(
                              border: InputBorder.none,
                              hintText: "请输入账号",
                              hintStyle: TextStyle(color: Colors.grey[400]),
                            ),
                          ),
                        ),
                        const SizedBox(height: 10),
                        Container(
                          padding: const EdgeInsets.all(8.0),
                          decoration: BoxDecoration(
                            color: Colors.transparent, // 输入框背景透明
                            borderRadius: BorderRadius.circular(10),
                            border: Border.all(color: Colors.grey.withOpacity(0.5)), // 边框颜色和透明度
                          ),
                          child: TextField(
                            obscureText: true, // 隐藏密码
                            controller: _passwordController,
                            style: TextStyle(color: Colors.black), // 文本颜色
                            decoration: InputDecoration(
                              border: InputBorder.none,
                              hintText: "请输入密码",
                              hintStyle: TextStyle(color: Colors.grey[400]),
                            ),
                          ),
                        ),
                        const SizedBox(height: 10),
                        Container(
                          padding: const EdgeInsets.all(8.0),
                          decoration: BoxDecoration(
                            color: Colors.transparent, // 输入框背景透明
                            borderRadius: BorderRadius.circular(10),
                            border: Border.all(color: Colors.grey.withOpacity(0.5)), // 边框颜色和透明度
                          ),
                          child: TextField(
                            obscureText: true, // 隐藏密码
                            controller: _confirmPasswordController, // 绑定到确认密码控制器
                            style: TextStyle(color: Colors.black), // 文本颜色
                            decoration: InputDecoration(
                              border: InputBorder.none,
                              hintText: "请再次输入密码",
                              hintStyle: TextStyle(color: Colors.grey[400]),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 30),
                  GestureDetector(
                    onTap: () {
                      _submitForm(context); // 传递 context
                    },
                    child: Container(
                      height: 50,
                      width: double.infinity,
                      margin: const EdgeInsets.symmetric(horizontal: 30.0),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10),
                        gradient: const LinearGradient(
                          colors: [
                            Color.fromRGBO(34, 100, 34, 1),
                            Color.fromRGBO(34, 100, 34, 0.6)
                          ],
                        ),
                      ),
                      child: const Center(
                        child: Text("注册", style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold)),
                      ),
                    ),
                  ),
                  const SizedBox(height: 20),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      const Text("已有账号？", style: TextStyle(color: Colors.white)),
                      GestureDetector(
                        onTap: () {
                          Navigator.pop(context); // 返回到上一个页面，通常是登录页
                        },
                        child: const Text("登录", style: TextStyle(color: Color.fromRGBO(143, 148, 251, 1))),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}