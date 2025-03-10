import 'package:cool_alert/cool_alert.dart';
import 'package:flutter/material.dart';
import 'package:flutter_speed_dial/flutter_speed_dial.dart';
import 'package:project/pages/DeleteMenuPage.dart';
import 'package:project/pages/login.dart';
import 'package:project/pages/order_history.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../model/screen/AddMenuScreen.dart';
import 'menu_screen.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  Future<void> _logout() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setBool("isLoggedIn", false);

    CoolAlert.show(
      context: context,
      type: CoolAlertType.confirm,
      title: "ออกจากระบบ",
      text: "คุณต้องการออกจากระบบหรือไม่?",
      confirmBtnText: "ใช่",
      cancelBtnText: "ยกเลิก",
      onConfirmBtnTap: () {
        Navigator.pop(context); // ปิด CoolAlert
        Future.delayed(const Duration(milliseconds: 300), () {
          Navigator.pushAndRemoveUntil(
            context,
            MaterialPageRoute(builder: (context) => const LoginScreen()),
            (Route<dynamic> route) => false,
          );
        });
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Cafe ว้าดำ',
            style: TextStyle(fontWeight: FontWeight.bold)),
        flexibleSpace: Container(
          decoration: const BoxDecoration(
            gradient: LinearGradient(
              colors: [Colors.blueAccent, Colors.lightBlue],
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
            ),
          ),
        ),
        actions: [
          IconButton(
            icon: const Icon(Icons.exit_to_app, color: Colors.white),
            onPressed: _logout,
          ),
        ],
      ),
      body: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            colors: [Colors.white, Color(0xFFBBDEFB)],
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
          ),
        ),
        child: const MenuScreen(),
      ),
      floatingActionButton: SpeedDial(
        animatedIcon: AnimatedIcons.menu_close,
        backgroundColor: Colors.blueAccent,
        overlayColor: Colors.black,
        overlayOpacity: 0.3,
        children: [
          SpeedDialChild(
            child: const Icon(Icons.restaurant_menu, color: Colors.white),
            backgroundColor: Colors.green,
            label: "เพิ่มเมนู",
            onTap: () => Navigator.push(context,
                MaterialPageRoute(builder: (context) => AddMenuScreen())),
          ),
          SpeedDialChild(
            child: const Icon(Icons.history, color: Colors.white),
            backgroundColor: Colors.green,
            label: "ประวัติการสั่งซื้อ",
            onTap: () => Navigator.push(context,
                MaterialPageRoute(builder: (context) => OrderHistoryPage())),
          ),
          SpeedDialChild(
            child: const Icon(Icons.delete, color: Colors.white),
            backgroundColor: Colors.red,
            label: "ลบเมนู",
            onTap: () => Navigator.push(context,
                MaterialPageRoute(builder: (context) => DeleteMenuPage())),
          ),
        ],
      ),
    );
  }
}
