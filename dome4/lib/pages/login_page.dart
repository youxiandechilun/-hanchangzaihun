import 'package:flutter/material.dart';
import 'register_page.dart';
import 'package:dome2/services/login_service.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final TextEditingController _usernameController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  // 定义 _submitForm 方法
  Future<void> _submitForm(BuildContext context) async {
    String username = _usernameController.text;
    String password = _passwordController.text;

    try {
      // 调用登录服务
      await LoginService().login(context, username, password);
    } catch (e) {
      // 捕获异常并显示错误对话框
      showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: const Text("登录失败"),
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
      backgroundColor: Colors.transparent, // 设置为透明色
      body: Stack(
        children: <Widget>[

          // 背景图片
          Container(
            decoration: BoxDecoration(
              image: DecorationImage(
                image: NetworkImage('http://8.140.229.104:9091/files/stream?filename=background2.png'),
                fit: BoxFit.cover,
              ),
            ),
          ),
          // 内容部分
          SingleChildScrollView(

            child: Column(

              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                SizedBox(height: 300), // 顶部留白
                Text(
                  "登录",
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
                          border: Border.all(color: Colors.black.withOpacity(0.5)), // 边框颜色和透明度
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
                          border: Border.all(color: Colors.black.withOpacity(0.5)), // 边框颜色和透明度
                        ),
                        child: TextField(
                          controller: _passwordController,
                          style: TextStyle(color: Colors.black), // 文本颜色
                          decoration: InputDecoration(
                            border: InputBorder.none,
                            hintText: "请输入密码",
                            hintStyle: TextStyle(color: Colors.grey[400]),
                          ),
                          obscureText: true, // 隐藏密码
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
                      child: Text("登录", style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold)),
                    ),
                  ),
                ),
                const SizedBox(height: 20),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    const Text("没有账号？", style: TextStyle(color: Colors.black)),
                    GestureDetector(
                      onTap: () {
                        Navigator.push(context, MaterialPageRoute(builder: (context) => RegisterPage()));
                      },
                      child: const Text("注册", style: TextStyle(color: Color.fromRGBO(143, 148, 251, 1))),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}